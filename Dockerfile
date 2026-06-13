# =============================================================================
# Cyber Detective DFIR Platform - Production Dockerfile
# =============================================================================
# Multi-stage build for minimal image size
# Runtime: Node.js 20 (standalone output from Next.js)
# =============================================================================

# ---- Stage 1: Dependencies ----
FROM node:20-alpine AS deps
RUN apk add --no-cache libc6-compat
WORKDIR /app

# Install Bun for dependency resolution
RUN npm install -g bun

# Copy package files
COPY package.json bun.lock ./

# Install dependencies with Bun, then ensure node_modules is compatible
RUN bun install --frozen-lockfile --production=false

# ---- Stage 2: Builder ----
FROM node:20-alpine AS builder
WORKDIR /app

# Install Bun
RUN npm install -g bun

# Copy dependencies from deps stage
COPY --from=deps /app/node_modules ./node_modules
COPY . .

# Generate Prisma client
RUN npx prisma generate

# Set environment variables for build
ENV NEXT_TELEMETRY_DISABLED=1
ENV NODE_ENV=production

# Build the Next.js standalone output
RUN npm run build

# ---- Stage 3: Runner (Production) ----
FROM node:20-alpine AS runner
WORKDIR /app

ENV NODE_ENV=production
ENV NEXT_TELEMETRY_DISABLED=1

# Create non-root user for security
RUN addgroup --system --gid 1001 nodejs && \
    adduser --system --uid 1001 nextjs

# Copy the standalone build output
COPY --from=builder /app/.next/standalone ./
COPY --from=builder /app/.next/static ./.next/static
COPY --from=builder /app/public ./public

# Copy Prisma schema and migrations for runtime DB setup
COPY --from=builder /app/prisma ./prisma
COPY --from=builder /app/node_modules/.prisma ./node_modules/.prisma
COPY --from=builder /app/node_modules/@prisma ./node_modules/@prisma

# Copy seed file for initial data
COPY --from=builder /app/prisma/seed.ts ./prisma/seed.ts

# Create data directory for SQLite
RUN mkdir -p /app/data && chown nextjs:nodejs /app/data

# Set environment defaults
ENV DATABASE_URL=file:/app/data/cyberdetective.db
ENV PORT=3000
ENV HOSTNAME="0.0.0.0"

# Expose port
EXPOSE 3000

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=40s --retries=3 \
    CMD wget --no-verbose --tries=1 --spider http://localhost:3000/api || exit 1

# Switch to non-root user
USER nextjs

# Start command - run DB migrations then start server
CMD ["sh", "-c", "npx prisma db push --skip-generate && node server.js"]
