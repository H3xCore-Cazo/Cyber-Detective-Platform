# 🔍 Cyber Detective DFIR Platform — Deployment Guide

Complete guide to deploying the Cyber Detective Platform to production servers.

---

## Table of Contents

1. [Quick Start (Docker)](#1-quick-start-docker)
2. [VPS / Cloud Server (Manual)](#2-vps--cloud-server-manual)
3. [Platform-as-a-Service](#3-platform-as-a-service)
4. [Environment Variables](#4-environment-variables)
5. [Database Management](#5-database-management)
6. [SSL / HTTPS Setup](#6-ssl--https-setup)
7. [Creating Admin Users](#7-creating-admin-users)
8. [Monitoring & Maintenance](#8-monitoring--maintenance)
9. [Troubleshooting](#9-troubleshooting)
10. [Architecture Overview](#10-architecture-overview)

---

## 1. Quick Start (Docker)

The fastest way to deploy — everything runs in containers.

### Prerequisites
- A server with **Docker** and **Docker Compose V2** installed
- At least **2GB RAM**, **10GB disk**
- Ports **80** and **443** open

### Deploy in 3 Commands

```bash
# Clone or upload your project to the server
git clone <your-repo-url> /opt/cyber-detective
cd /opt/cyber-detective

# Run the deployment script
chmod +x deploy.sh
./deploy.sh

# Seed the database with demo data
./deploy.sh --seed
```

That's it! Your platform is running at `http://your-server-ip`.

### Manual Docker Commands

If you prefer to run commands manually:

```bash
# Build and start
docker compose up -d --build

# Check status
docker compose ps

# View logs
docker compose logs -f app

# Stop everything
docker compose down

# Restart (preserves data)
docker compose restart
```

### Data Persistence

Docker volumes persist your data across restarts:
- `app-data` → SQLite database (`/app/data/cyberdetective.db`)
- `app-uploads` → Uploaded evidence files (`/app/uploads`)

To backup:
```bash
# Backup database
docker compose exec app cp /app/data/cyberdetective.db /tmp/backup.db
docker compose cp app:/tmp/backup.db ./backup-$(date +%Y%m%d).db

# Restore database
docker compose cp ./backup.db app:/app/data/cyberdetective.db
docker compose restart app
```

---

## 2. VPS / Cloud Server (Manual)

Deploy without Docker on any Linux server (Ubuntu/Debian recommended).

### Prerequisites
- Ubuntu 22.04+ or similar Linux
- Node.js 20+
- At least 2GB RAM

### Step 1: Install Node.js & Bun

```bash
# Install Node.js 20
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt-get install -y nodejs

# Install Bun
curl -fsSL https://bun.sh/install | bash
source ~/.bashrc

# Install PM2 for process management
sudo npm install -g pm2
```

### Step 2: Upload Project

```bash
# Option A: Git clone
git clone <your-repo-url> /opt/cyber-detective
cd /opt/cyber-detective

# Option B: SCP upload from local
# From your machine:
scp -r ./cyber-detective user@server:/opt/
```

### Step 3: Configure Environment

```bash
cp .env .env.backup

cat > .env << 'EOF'
DATABASE_URL=file:/opt/cyber-detective/data/cyberdetective.db
JWT_SECRET=$(openssl rand -base64 48)
NODE_ENV=production
NEXT_TELEMETRY_DISABLED=1
PORT=3000
EOF
```

### Step 4: Install & Build

```bash
# Install dependencies
bun install

# Generate Prisma client
npx prisma generate

# Create database and push schema
mkdir -p data
npx prisma db push

# Seed with demo data (optional)
bun run db:seed

# Build for production
npm run build
```

### Step 5: Start with PM2

```bash
# Create PM2 ecosystem file
cat > ecosystem.config.js << 'EOF'
module.exports = {
  apps: [{
    name: 'cyber-detective',
    script: '.next/standalone/server.js',
    env: {
      NODE_ENV: 'production',
      PORT: 3000,
      DATABASE_URL: 'file:/opt/cyber-detective/data/cyberdetective.db',
      HOSTNAME: '0.0.0.0'
    },
    instances: 1,
    autorestart: true,
    max_memory_restart: '1G',
    error_file: './logs/error.log',
    out_file: './logs/out.log',
    time: true
  }]
}
EOF

# Start
pm2 start ecosystem.config.js

# Save for auto-start on reboot
pm2 save
pm2 startup
```

### Step 6: Configure Nginx

```bash
sudo apt install -y nginx

sudo tee /etc/nginx/sites-available/cyber-detective << 'EOF'
server {
    listen 80;
    server_name your-domain.com;

    location / {
        proxy_pass http://127.0.0.1:3000;
        proxy_http_version 1.1;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
        proxy_read_timeout 300s;
    }

    location /_next/static/ {
        proxy_pass http://127.0.0.1:3000;
        expires 365d;
        add_header Cache-Control "public, immutable";
    }

    location /api/ {
        proxy_pass http://127.0.0.1:3000;
        add_header Cache-Control "no-store";
        proxy_read_timeout 120s;
    }
}
EOF

sudo ln -s /etc/nginx/sites-available/cyber-detective /etc/nginx/sites-enabled/
sudo nginx -t && sudo systemctl reload nginx
```

---

## 3. Platform-as-a-Service

### Vercel (Recommended for Next.js)

> ⚠️ **Note**: SQLite won't work on Vercel (serverless = no persistent filesystem). You'd need to migrate to PostgreSQL or use a hosted database like [Turso](https://turso.tech/) (SQLite-compatible).

```bash
# Install Vercel CLI
npm i -g vercel

# Deploy
vercel --prod
```

**Required changes for Vercel:**
1. Update `prisma/schema.prisma` datasource to PostgreSQL:
   ```prisma
   datasource db {
     provider = "postgresql"
     url      = env("DATABASE_URL")
   }
   ```
2. Add PostgreSQL connection string to Vercel env vars
3. Run `npx prisma migrate deploy` in build command

### Railway

```bash
# Install Railway CLI
npm i -g @railway/cli

# Login and deploy
railway login
railway init
railway up
railway run -- npx prisma db push
```

Railway supports persistent volumes, so SQLite **can work** with a mounted volume.

### Fly.io

```bash
# Install Fly CLI
curl -L https://fly.io/install.sh | sh

# Launch
fly launch
fly volumes create data --size 1
fly secrets set JWT_SECRET="$(openssl rand -base64 48)"
fly deploy
```

---

## 4. Environment Variables

| Variable | Required | Default | Description |
|----------|----------|---------|-------------|
| `DATABASE_URL` | ✅ | `file:./data/cyberdetective.db` | SQLite connection string |
| `JWT_SECRET` | ✅ | — | Secret for signing auth tokens (min 32 chars) |
| `NODE_ENV` | ✅ | `production` | Environment mode |
| `PORT` | ❌ | `3000` | Server port |
| `NEXT_TELEMETRY_DISABLED` | ❌ | `1` | Disable Next.js telemetry |
| `ADMIN_EMAIL` | ❌ | — | Initial admin email (for seeding) |
| `ADMIN_PASSWORD` | ❌ | — | Initial admin password (for seeding) |

### Generate Secure Secrets

```bash
# JWT Secret
openssl rand -base64 48

# Or use any strong random string
node -e "console.log(require('crypto').randomBytes(48).toString('hex'))"
```

---

## 5. Database Management

### Schema Updates

After changing `prisma/schema.prisma`:

```bash
# Development
npx prisma db push

# Production (Docker)
docker compose exec app npx prisma db push --skip-generate

# Production (Manual/PM2)
npx prisma db push --skip-generate
pm2 restart cyber-detective
```

### Backup & Restore

```bash
# Backup
cp data/cyberdetective.db backup-$(date +%Y%m%d-%H%M%S).db

# Restore
cp backup-20240101-120000.db data/cyberdetective.db
pm2 restart cyber-detective  # or: docker compose restart app
```

### Reset Database (⚠️ Destroys All Data)

```bash
# Docker
docker compose down -v  # removes volumes
docker compose up -d --build

# Manual
rm data/cyberdetective.db
npx prisma db push
bun run db:seed
```

---

## 6. SSL / HTTPS Setup

### Option A: Let's Encrypt (Free, Recommended)

```bash
# Using the deploy script
./deploy.sh --ssl

# Or manually:
sudo apt install certbot
sudo certbot certonly --standalone -d your-domain.com
# Then update nginx.conf with SSL paths
```

### Option B: Cloud Provider SSL

Most cloud providers (AWS, GCP, DigitalOcean) offer managed SSL:
- **AWS**: Use CloudFront + ACM
- **GCP**: Use Cloud Load Balancer + Managed Certificates
- **DigitalOcean**: Use their managed Load Balancer with Let's Encrypt

### Option C: Custom Certificate

Place your cert files and update nginx.conf:
```nginx
ssl_certificate /etc/nginx/ssl/cert.pem;
ssl_certificate_key /etc/nginx/ssl/key.pem;
```

---

## 7. Creating Admin Users

### Method 1: Via Seed Script

Add admin credentials to `.env.production`:
```
ADMIN_EMAIL=admin@yourdomain.com
ADMIN_PASSWORD=YourSecurePassword123!
```

Then seed:
```bash
docker compose exec app sh -c "npx tsx prisma/seed.ts"
# or manually:
bun run db:seed
```

### Method 2: Via API (after deployment)

First, sign up a regular user, then promote them:

```bash
# Get the user ID from the database
docker compose exec app npx prisma studio
# Or use sqlite3 directly:
docker compose exec app sh -c "npx prisma db execute --stdin" << 'SQL'
UPDATE User SET role = 'admin' WHERE email = 'admin@yourdomain.com';
SQL
```

### Method 3: Direct Database Update

```bash
# In the Docker container
docker compose exec app sh -c "
  npx prisma db execute --stdin
" << 'SQL'
UPDATE User SET role = 'admin' WHERE email = 'your-email@example.com';
SQL

# On manual deployment
sqlite3 data/cyberdetective.db "UPDATE User SET role = 'admin' WHERE email = 'your-email@example.com';"
```

---

## 8. Monitoring & Maintenance

### Health Checks

```bash
# Quick check
curl -s http://localhost:3000/api | head -c 100

# Docker health status
docker compose ps

# PM2 monitoring
pm2 status
pm2 monit
```

### Log Management

```bash
# Docker logs (live)
docker compose logs -f app --tail=100

# PM2 logs
pm2 logs cyber-detective --lines=100

# Nginx access/error logs
sudo tail -f /var/log/nginx/access.log
sudo tail -f /var/log/nginx/error.log
```

### Automatic Updates

Create a cron job for automatic updates:

```bash
# Edit crontab
crontab -e

# Add: Check for updates daily at 3 AM
0 3 * * * cd /opt/cyber-detective && git pull && docker compose up -d --build
```

### Resource Monitoring

```bash
# Docker resource usage
docker stats

# Disk usage
df -h
du -sh data/

# Memory usage
free -h
```

---

## 9. Troubleshooting

### App won't start

```bash
# Check logs
docker compose logs app --tail=50

# Common issues:
# 1. Port already in use
sudo lsof -i :3000
# Kill: sudo kill -9 $(sudo lsof -t -i:3000)

# 2. Database locked
docker compose exec app sh -c "rm /app/data/cyberdetective.db-journal"
docker compose restart app

# 3. Permission issues
docker compose exec app sh -c "chown -R nextjs:nodejs /app/data"
```

### 502 Bad Gateway

```bash
# Check if app is running
docker compose ps
curl http://localhost:3000/api

# If app is down, restart
docker compose restart app
```

### Database errors

```bash
# Check database integrity
docker compose exec app sh -c "sqlite3 /app/data/cyberdetective.db 'PRAGMA integrity_check;'"

# Reset if corrupted
docker compose down -v
docker compose up -d --build
```

### Build failures

```bash
# Clear Next.js cache
rm -rf .next

# Rebuild
docker compose build --no-cache

# Check Node.js version compatibility
node --version  # Should be 20+
```

---

## 10. Architecture Overview

```
┌──────────────────────────────────────────────────────────┐
│                      Internet / Users                     │
└────────────────────────┬─────────────────────────────────┘
                         │
                    ┌────▼────┐
                    │  Nginx  │  ← Port 80/443 (SSL termination)
                    │  Proxy  │  ← Static caching, security headers
                    └────┬────┘
                         │
                    ┌────▼────┐
                    │ Next.js │  ← Port 3000 (standalone)
                    │  App    │  ← SSR, API routes, SPA
                    └────┬────┘
                         │
              ┌──────────┼──────────┐
              │          │          │
         ┌────▼───┐ ┌───▼───┐ ┌───▼────┐
         │ SQLite │ │Uploads│ │  AI    │
         │   DB   │ │Volume │ │  SDK   │
         └────────┘ └───────┘ └────────┘
```

### Tech Stack
| Component | Technology |
|-----------|-----------|
| Framework | Next.js 16 (App Router, standalone output) |
| Runtime | Node.js 20 |
| Database | SQLite via Prisma ORM |
| Auth | Custom Bearer token (bcryptjs) |
| UI | React + Tailwind CSS 4 + shadcn/ui |
| State | Zustand + TanStack Query |
| Animation | Framer Motion |
| Reverse Proxy | Nginx (production) |
| Container | Docker + Docker Compose |

### Security Considerations
- ✅ Passwords hashed with bcryptjs
- ✅ JWT tokens with expiry
- ✅ Answers/storagePath/sessionPassword never exposed to client
- ✅ Admin role-based access control
- ✅ Security headers via Nginx
- ✅ Non-root Docker container
- ✅ Rate limiting recommended (add to Nginx)

---

## Quick Reference Card

```bash
# === Docker Deployment ===
./deploy.sh                    # Deploy everything
./deploy.sh --seed             # Seed database
./deploy.sh --ssl              # Setup SSL
./deploy.sh --stop             # Stop services
./deploy.sh --logs             # View logs
./deploy.sh --status           # Health check

# === Manual Deployment ===
bun install                    # Install deps
npx prisma generate            # Generate Prisma client
npx prisma db push             # Create/migrate database
npm run build                  # Build for production
pm2 start ecosystem.config.js  # Start with PM2

# === Maintenance ===
docker compose logs -f app     # View live logs
docker compose restart app     # Restart app
docker compose down -v         # Reset everything (⚠️ data loss)
pm2 restart cyber-detective    # Restart (PM2)
pm2 monit                      # Monitor (PM2)
```
