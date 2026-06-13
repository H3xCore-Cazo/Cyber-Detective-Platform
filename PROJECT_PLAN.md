# 🔍 Cyber Detective — Project Plan

> **"Every attack leaves a trace. Can you find it?"**

---

## Table of Contents

1. [Project Overview](#1-project-overview)
2. [Architecture](#2-architecture)
3. [Folder Structure](#3-folder-structure)
4. [Coding Standards](#4-coding-standards)
5. [Design System](#5-design-system)
6. [Development Phases](#6-development-phases)
7. [Security Rules](#7-security-rules)
8. [Key Principles](#8-key-principles)

---

## 1. Project Overview

### Vision

**Cyber Detective** is the **"Hack The Box for Cyber Detectives"** — a gamified DFIR (Digital Forensics & Incident Response) education platform where users investigate realistic cybersecurity incidents rather than launch attacks. Players step into the role of a digital forensics investigator, analyzing evidence, reconstructing attack chains, and answering investigative questions to prove their skills.

### Core Concept

Unlike traditional CTF platforms that reward offensive skills, Cyber Detective rewards **investigative thinking**. Each case presents a realistic incident scenario — a breached server, a compromised endpoint, a data exfiltration event — and the user must:

1. **Explore the evidence** — Browse disk images, log files, memory dumps, network captures, and artifacts.
2. **Answer investigative questions** — Prove understanding by answering targeted questions about the incident.
3. **Submit the flag** — Capture the final flag by solving the case.

### Target Audience

| Segment | Description |
|---------|-------------|
| Security Analysts | Level-up DFIR skills with hands-on cases |
| SOC Teams | Train on realistic incident scenarios |
| Students | Learn forensics through interactive investigations |
| CTF Enthusiasts | A new challenge paradigm — defense, not offense |
| Hiring Managers | Evaluate candidate investigative skills |

### Key Differentiators

- **Investigation-first, not attack-first** — Users analyze, not exploit.
- **Realistic evidence** — Cases built from real-world incident patterns.
- **AI-powered hints** — LLM-guided investigation without giving away answers.
- **Progressive difficulty** — From log analysis to full incident reconstruction.
- **Cyberpunk aesthetic** — Immersive terminal-style interface that feels like a real investigation.

---

## 2. Architecture

### High-Level Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                        Client (Browser)                      │
│  ┌──────────┐  ┌──────────┐  ┌──────────┐  ┌────────────┐  │
│  │  Zustand  │  │TanStack  │  │  Framer  │  │  Socket.IO │  │
│  │  (State)  │  │  Query   │  │  Motion  │  │  (Labs)    │  │
│  └─────┬────┘  └─────┬────┘  └──────────┘  └─────┬──────┘  │
│        │              │                           │          │
│  ┌─────▼──────────────▼───────────────────────────▼──────┐   │
│  │              Next.js 16 App Router (Client)            │   │
│  │     Pages · Components · Hooks · Services              │   │
│  └──────────────────────┬────────────────────────────────┘   │
└─────────────────────────┼────────────────────────────────────┘
                          │ API Requests + WebSocket
┌─────────────────────────▼────────────────────────────────────┐
│              Next.js 16 App Router (Server)                   │
│  ┌────────────┐  ┌─────────────┐  ┌───────────────────────┐ │
│  │ API Routes │  │  NextAuth   │  │  Server Utilities     │ │
│  │ /api/*     │  │  /api/auth  │  │  (validation, etc.)   │ │
│  └─────┬──────┘  └──────┬──────┘  └───────────┬───────────┘ │
│        │                │                      │             │
│  ┌─────▼────────────────▼──────────────────────▼───────────┐ │
│  │                  Prisma ORM (SQLite)                     │ │
│  │         Users · Cases · Submissions · Labs              │ │
│  └─────────────────────────────────────────────────────────┘ │
└──────────────────────────────────────────────────────────────┘
                          │
┌─────────────────────────▼────────────────────────────────────┐
│                 Mini Services                                 │
│  ┌──────────────────┐  ┌──────────────────────────────────┐  │
│  │  Lab Service     │  │  AI Investigator Service         │  │
│  │  (Port 3003)     │  │  (Port 3004)                     │  │
│  │  Docker + Socket │  │  LLM Hint Generation             │  │
│  └──────────────────┘  └──────────────────────────────────┘  │
└──────────────────────────────────────────────────────────────┘
```

### Architectural Decisions

| Decision | Choice | Rationale |
|----------|--------|-----------|
| Framework | Next.js 16 App Router | Full-stack, API routes, SSR/SSG flexibility |
| Rendering | Client-side with SSR shells | Interactive SPA feel with SEO-capable shells |
| State | Zustand + TanStack Query | Zustand for client UI state, TanStack Query for server data |
| Auth | NextAuth.js v4 | Battle-tested, provider-flexible, session management |
| Database | Prisma + SQLite | Zero-config, file-based, perfect for single-instance |
| Real-time | Socket.IO | Lab session management, live terminal, timers |
| Styling | Tailwind CSS 4 + shadcn/ui | Utility-first with polished component library |
| Animation | Framer Motion | Declarative, performant, React-native integration |
| Charts | Recharts | React-native, composable, good for dashboards |
| Validation | Zod | TypeScript-first, runtime validation, API safety |
| AI | z-ai-web-dev-sdk (server-only) | LLM hints, investigation guidance |

### API Design Principles

- **RESTful routes** under `/api/*` — no server actions.
- **Server-side validation** on every endpoint with Zod schemas.
- **Never expose flags, answers, or solution data** to the client.
- **Rate limiting** on flag submission and AI hint endpoints.
- **Consistent response envelope**:

```typescript
interface ApiResponse<T> {
  success: boolean;
  data?: T;
  error?: string;
  message?: string;
}
```

### Single-Page App with Client-Side Views

The application functions as a single-page app at the `/` route. Navigation between views (Dashboard, Cases, Case Detail, Lab, Leaderboard) is handled entirely on the client side via state management — no route changes required.

```
/ → Root layout
  ├── View: Dashboard
  ├── View: Case Library (browse all cases)
  ├── View: Case Detail (evidence + questions + flag)
  ├── View: Lab (terminal session)
  ├── View: Leaderboard
  ├── View: Profile
  └── View: Settings
```

---

## 3. Folder Structure

```
cyber-detective/
├── prisma/
│   ├── schema.prisma              # Database schema
│   ├── seed.ts                    # Seed data (cases, users)
│   └── migrations/                # Migration history
│
├── db/
│   └── cyber-detective.db         # SQLite database file
│
├── public/
│   ├── images/
│   │   ├── cases/                 # Case cover images
│   │   └── avatars/               # User avatars / rank badges
│   └── favicon.ico
│
├── src/
│   ├── app/
│   │   ├── layout.tsx             # Root layout (providers, theme)
│   │   ├── page.tsx               # Main SPA entry (view router)
│   │   ├── globals.css            # Global styles + cyberpunk tokens
│   │   └── api/
│   │       ├── auth/
│   │       │   └── [...nextauth]/
│   │       │       └── route.ts   # NextAuth handler
│   │       ├── cases/
│   │       │   ├── route.ts       # GET /api/cases (list)
│   │       │   └── [id]/
│   │       │       ├── route.ts            # GET /api/cases/:id
│   │       │       ├── questions/route.ts  # GET questions for case
│   │       │       ├── flag/route.ts       # POST flag submission
│   │       │       └── evidence/route.ts   # GET evidence files
│   │       ├── submissions/
│   │       │   └── route.ts      # GET/POST user submissions
│   │       ├── leaderboard/
│   │       │   └── route.ts      # GET global leaderboard
│   │       ├── user/
│   │       │   ├── route.ts      # GET current user profile
│   │       │   └── stats/route.ts # GET user statistics
│   │       ├── labs/
│   │       │   ├── route.ts      # GET/POST lab sessions
│   │       │   └── [id]/
│   │       │       └── route.ts  # GET specific lab status
│   │       └── ai/
│   │           └── hint/
│   │               └── route.ts  # POST request AI hint
│   │
│   ├── components/
│   │   ├── ui/                    # shadcn/ui components (New York style)
│   │   │   ├── button.tsx
│   │   │   ├── card.tsx
│   │   │   ├── dialog.tsx
│   │   │   ├── input.tsx
│   │   │   ├── badge.tsx
│   │   │   ├── tabs.tsx
│   │   │   ├── progress.tsx
│   │   │   ├── skeleton.tsx
│   │   │   ├── toast.tsx
│   │   │   ├── tooltip.tsx
│   │   │   ├── scroll-area.tsx
│   │   │   └── ...                # Other shadcn/ui components
│   │   │
│   │   └── cyber/                 # Custom cyberpunk-themed components
│   │       ├── layout/
│   │       │   ├── AppShell.tsx           # Main app shell with nav
│   │       │   ├── Sidebar.tsx            # Navigation sidebar
│   │       │   ├── TopBar.tsx             # Top bar with user info
│   │       │   └── Footer.tsx             # Sticky footer
│   │       ├── terminal/
│   │       │   ├── Terminal.tsx           # Terminal emulator component
│   │       │   ├── TerminalLine.tsx       # Single terminal output line
│   │       │   ├── TerminalInput.tsx      # Terminal input with prompt
│   │       │   └── TerminalHistory.tsx    # Scrollable command history
│   │       ├── cases/
│   │       │   ├── CaseCard.tsx           # Case library card
│   │       │   ├── CaseGrid.tsx           # Grid of case cards
│   │       │   ├── CaseDetail.tsx         # Full case detail view
│   │       │   ├── EvidenceExplorer.tsx   # File tree + preview
│   │       │   ├── EvidencePreview.tsx    # File content viewer
│   │       │   ├── QuestionPanel.tsx      # Investigative questions
│   │       │   └── FlagSubmission.tsx     # Flag input + validation
│   │       ├── dashboard/
│   │       │   ├── DashboardView.tsx      # Main dashboard layout
│   │       │   ├── StatsOverview.tsx      # XP, rank, cases solved
│   │       │   ├── ActivityFeed.tsx       # Recent activity timeline
│   │       │   ├── SkillRadar.tsx         # Skill radar chart
│   │       │   └── ProgressChart.tsx      # XP progress over time
│   │       ├── leaderboard/
│   │       │   ├── LeaderboardTable.tsx   # Global ranking table
│   │       │   ├── RankBadge.tsx          # Visual rank indicator
│   │       │   └── UserRankRow.tsx        # Single user row
│   │       ├── lab/
│   │       │   ├── LabSession.tsx         # Active lab view
│   │       │   ├── LabTimer.tsx           # Countdown timer
│   │       │   ├── LabStatus.tsx          # Status indicator
│   │       │   └── LabControls.tsx        # Start/stop/reset controls
│   │       ├── auth/
│   │       │   ├── LoginForm.tsx          # Login form
│   │       │   ├── RegisterForm.tsx       # Registration form
│   │       │   └── AuthGuard.tsx          # Auth protection wrapper
│   │       └── shared/
│   │           ├── GlitchText.tsx         # Glitch animation text
│   │           ├── MatrixRain.tsx         # Matrix rain background
│   │           ├── CyberBadge.tsx         # Styled badge component
│   │           ├── NeonBorder.tsx         # Glowing border wrapper
│   │           ├── ScanLine.tsx           # CRT scan line overlay
│   │           ├── TypeWriter.tsx         # Typewriter text effect
│   │           ├── PulseDot.tsx           # Animated status dot
│   │           └── LoadingSkeleton.tsx    # Cyberpunk loading state
│   │
│   ├── hooks/
│   │   ├── useAuth.ts             # Auth state & actions
│   │   ├── useCases.ts            # Cases data & mutations
│   │   ├── useSubmissions.ts      # Submission state
│   │   ├── useLeaderboard.ts      # Leaderboard data
│   │   ├── useLab.ts              # Lab session management
│   │   ├── useAIHint.ts           # AI hint requests
│   │   ├── useTimer.ts            # Countdown timer logic
│   │   ├── useTerminal.ts         # Terminal state & commands
│   │   └── useView.ts             # Current view navigation
│   │
│   ├── lib/
│   │   ├── db.ts                  # Prisma client singleton
│   │   ├── auth.ts                # NextAuth configuration
│   │   ├── utils.ts               # General utilities (cn, etc.)
│   │   ├── validations.ts         # Zod schemas for all inputs
│   │   └── constants.ts           # App-wide constants
│   │
│   ├── services/
│   │   ├── case.service.ts        # Case business logic
│   │   ├── submission.service.ts  # Submission & flag logic
│   │   ├── user.service.ts        # User & stats logic
│   │   ├── leaderboard.service.ts # Leaderboard calculations
│   │   ├── lab.service.ts         # Lab session logic
│   │   └── ai.service.ts          # AI hint generation
│   │
│   ├── types/
│   │   ├── index.ts               # Re-exports
│   │   ├── case.ts                # Case, Evidence, Question types
│   │   ├── user.ts                # User, Profile, Stats types
│   │   ├── submission.ts          # Submission, Answer types
│   │   ├── lab.ts                 # Lab, Session, Timer types
│   │   ├── leaderboard.ts         # Ranking, Leaderboard types
│   │   └── api.ts                 # API response types
│   │
│   ├── stores/
│   │   ├── view-store.ts          # Current active view
│   │   ├── auth-store.ts          # Auth client state
│   │   ├── case-store.ts          # Active case state
│   │   └── lab-store.ts           # Lab session state
│   │
│   └── utils/
│       ├── crypto.ts              # Flag hashing, verification
│       ├── format.ts              # Date, number, rank formatters
│       ├── rank.ts                # Rank calculation from XP
│       └── xp.ts                  # XP calculation logic
│
├── mini-services/
│   ├── lab-service/               # Docker lab orchestration
│   │   ├── package.json
│   │   └── index.ts               # Socket.IO + Docker API (port 3003)
│   └── ai-service/                # AI hint generation
│       ├── package.json
│       └── index.ts               # LLM hint service (port 3004)
│
├── agent-ctx/                     # Agent work records
│
├── package.json
├── tsconfig.json
├── next.config.ts
├── tailwind.config.ts
├── components.json                # shadcn/ui config
├── Caddyfile                      # Gateway configuration
└── PROJECT_PLAN.md                # This file
```

---

## 4. Coding Standards

### TypeScript

```typescript
// ✅ DO: Strict mode, explicit types, no `any`
interface CaseEvidence {
  id: string;
  fileName: string;
  fileType: 'log' | 'pcap' | 'memory' | 'disk' | 'artifact';
  content: string;
  caseId: string;
}

// ❌ DON'T: Implicit any, loose types
const evidence: any = getData();
```

### Configuration

| Tool | Config | Notes |
|------|--------|-------|
| TypeScript | `strict: true` | No implicit any, strict null checks |
| ESLint | `next/core-web-vitals` | Next.js recommended rules |
| Prettier | Single quotes, 2 spaces | Consistent formatting |

### Naming Conventions

| Entity | Convention | Example |
|--------|-----------|---------|
| Components | PascalCase | `CaseCard.tsx`, `EvidenceExplorer.tsx` |
| Hooks | camelCase with `use` prefix | `useCases.ts`, `useTimer.ts` |
| Services | camelCase with `.service` | `case.service.ts` |
| Types / Interfaces | PascalCase | `CaseEvidence`, `UserStats` |
| API Routes | kebab-case | `/api/flag-submission/` |
| Constants | SCREAMING_SNAKE | `MAX_FLAG_ATTEMPTS` |
| Zod Schemas | camelCase with `Schema` suffix | `flagSubmissionSchema` |
| CSS Classes | Tailwind utilities | `bg-background text-foreground` |
| Custom CSS vars | kebab-case | `--cyber-green`, `--matrix-glow` |

### Component Patterns

```typescript
// ✅ Preferred: Functional component with explicit props type
interface CaseCardProps {
  case: CaseSummary;
  onSelect: (id: string) => void;
  isCompleted?: boolean;
}

export function CaseCard({ case: caseData, onSelect, isCompleted }: CaseCardProps) {
  // Component logic
}

// ✅ Client components must use 'use client' directive
'use client';

import { motion } from 'framer-motion';

export function GlitchText({ text }: { text: string }) {
  return <motion.span /* ... */ />;
}
```

### API Route Pattern

```typescript
// src/app/api/cases/[id]/flag/route.ts
import { NextRequest, NextResponse } from 'next/server';
import { flagSubmissionSchema } from '@/lib/validations';
import { validateFlag } from '@/services/submission.service';
import { getServerSession } from 'next-auth';

export async function POST(
  request: NextRequest,
  { params }: { params: Promise<{ id: string }> }
) {
  // 1. Authenticate
  const session = await getServerSession();
  if (!session?.user) {
    return NextResponse.json({ success: false, error: 'Unauthorized' }, { status: 401 });
  }

  // 2. Validate input
  const body = await request.json();
  const parsed = flagSubmissionSchema.safeParse(body);
  if (!parsed.success) {
    return NextResponse.json({ success: false, error: 'Invalid input' }, { status: 400 });
  }

  // 3. Process server-side (flag NEVER sent to client for comparison)
  const result = await validateFlag(params.id, parsed.data.flag, session.user.id);

  // 4. Return result (never expose the actual flag)
  return NextResponse.json({
    success: result.correct,
    data: result.correct ? { xpEarned: result.xpEarned } : undefined,
    error: result.correct ? undefined : 'Incorrect flag. Keep investigating.',
  });
}
```

### Error Handling

```typescript
// Service layer throws, API layer catches
class AppError extends Error {
  constructor(
    message: string,
    public statusCode: number,
    public code: string
  ) {
    super(message);
  }
}

// Usage in service
throw new AppError('Case not found', 404, 'CASE_NOT_FOUND');

// API route catches and returns consistent envelope
```

---

## 5. Design System

### Cyberpunk DFIR Theme

The visual identity is **"Late-night forensic workstation"** — dark terminals, glowing green accents, CRT-inspired overlays. Every element should feel like it belongs in a SOC at 3 AM.

### Color Tokens

```css
:root {
  /* ── Core Palette ── */
  --cyber-green:        #00ff41;   /* Matrix green — primary accent */
  --cyber-green-dim:    #00cc33;   /* Dimmer green for secondary */
  --cyber-green-glow:   #00ff4180; /* Green with 50% opacity for glows */

  /* ── Background Hierarchy ── */
  --bg-void:            #000000;   /* Deepest background */
  --bg-terminal:        #0a0a0a;   /* Terminal background */
  --bg-panel:           #111111;   /* Panel / card background */
  --bg-surface:         #1a1a1a;   /* Raised surface */
  --bg-hover:           #222222;   /* Hover state */

  /* ── Text Hierarchy ── */
  --text-primary:       #e0e0e0;   /* Primary text */
  --text-secondary:     #888888;   /* Secondary / muted text */
  --text-accent:        #00ff41;   /* Accent text (green) */
  --text-dim:           #555555;   /* Disabled / placeholder */

  /* ── Semantic Colors ── */
  --color-danger:       #ff3333;   /* Error / failed */
  --color-warning:      #ffaa00;   /* Warning */
  --color-success:      #00ff41;   /* Success / correct */
  --color-info:         #00aaff;   /* Informational */

  /* ── Border ── */
  --border-dim:         #222222;   /* Subtle border */
  --border-green:       #00ff4140; /* Green-tinted border */

  /* ── Effects ── */
  --glow-green:         0 0 10px #00ff4140, 0 0 20px #00ff4120;
  --glow-green-strong:  0 0 10px #00ff4180, 0 0 30px #00ff4140;
  --scanline:           repeating-linear-gradient(
                           0deg,
                           transparent,
                           transparent 2px,
                           rgba(0, 255, 65, 0.03) 2px,
                           rgba(0, 255, 65, 0.03) 4px
                         );
}
```

### Tailwind CSS Configuration

```typescript
// tailwind.config.ts — key extensions
{
  theme: {
    extend: {
      colors: {
        cyber: {
          green:      '#00ff41',
          'green-dim': '#00cc33',
          void:       '#000000',
          terminal:   '#0a0a0a',
          panel:      '#111111',
          surface:    '#1a1a1a',
          hover:      '#222222',
          danger:     '#ff3333',
          warning:    '#ffaa00',
          info:       '#00aaff',
        },
      },
      fontFamily: {
        mono: ['JetBrains Mono', 'Fira Code', 'monospace'],
        terminal: ['IBM Plex Mono', 'monospace'],
      },
      boxShadow: {
        'neon':      '0 0 10px #00ff4140, 0 0 20px #00ff4120',
        'neon-strong': '0 0 10px #00ff4180, 0 0 30px #00ff4140',
      },
      animation: {
        'glow-pulse': 'glow-pulse 2s ease-in-out infinite',
        'scanline':   'scanline 8s linear infinite',
        'typing':     'typing 3s steps(30) forwards',
      },
      keyframes: {
        'glow-pulse': {
          '0%, 100%': { boxShadow: '0 0 5px #00ff4140' },
          '50%':      { boxShadow: '0 0 20px #00ff4180' },
        },
      },
    },
  },
}
```

### Typography

| Role | Font | Weight | Size | Color |
|------|------|--------|------|-------|
| H1 Headings | JetBrains Mono | 700 | 2rem | `text-primary` |
| H2 Headings | JetBrains Mono | 600 | 1.5rem | `text-primary` |
| Body Text | IBM Plex Mono | 400 | 0.875rem | `text-primary` |
| Terminal | IBM Plex Mono | 400 | 0.8125rem | `text-accent` |
| Labels | JetBrains Mono | 500 | 0.75rem | `text-secondary` |
| Code | JetBrains Mono | 400 | 0.8125rem | `text-accent` |

### Component Library

#### shadcn/ui Base (New York style, dark theme overrides)

All standard shadcn/ui components are used with the following overrides:

| Component | Override |
|-----------|----------|
| Button | Add `variant="cyber"` — green outline with neon glow on hover |
| Card | Dark panel background, subtle green border on hover |
| Input | Terminal-style — dark background, green caret, monospace font |
| Badge | Multiple variants: `success` (green), `danger` (red), `warning` (amber), `rank` (glowing green) |
| Dialog | Dark panel with neon border, backdrop blur |
| Tabs | Green active indicator, monospace labels |
| Progress | Green fill with glow effect |
| Skeleton | Pulsing dark-green shimmer |
| Toast | Terminal-style notifications with icon indicators |
| ScrollArea | Custom scrollbar: thin dark track, green thumb |

#### Custom Cyber Components

| Component | Description | Key Features |
|-----------|-------------|--------------|
| `Terminal` | Full terminal emulator UI | Command history, auto-scroll, syntax highlighting |
| `GlitchText` | Text with glitch animation | CSS glitch effect, configurable intensity |
| `MatrixRain` | Matrix-style falling characters | Canvas-based, configurable density |
| `NeonBorder` | Glowing border wrapper | Configurable color, pulse animation |
| `ScanLine` | CRT scan line overlay | Subtle animated scan lines |
| `TypeWriter` | Typewriter text effect | Character-by-character reveal, cursor blink |
| `PulseDot` | Animated status indicator | Green pulse = active, red = alert, amber = pending |
| `CyberBadge` | Styled rank/achievement badge | Glow effect, tier colors |
| `LoadingSkeleton` | Cyberpunk loading state | Terminal-style loading messages |

### Spacing & Layout

```
Standard spacing scale (based on 4px):
  1 = 4px   → Tight inline spacing
  2 = 8px   → Compact element spacing
  3 = 12px  → Standard internal padding
  4 = 16px  → Card padding, standard gap
  6 = 24px  → Section padding
  8 = 32px  → Large section gap
  12 = 48px → Page section spacing
  16 = 64px → Major layout spacing

Layout constants:
  Sidebar width:    280px (collapsed: 64px)
  Max content:      1280px
  Card min-width:   300px
  Card gap:         24px
  Panel radius:     8px
  Border width:     1px
```

### Responsive Breakpoints

| Breakpoint | Width | Layout |
|-----------|-------|--------|
| Mobile | < 640px | Sidebar hidden, stacked cards, full-width terminal |
| Tablet | 640–1024px | Collapsed sidebar, 2-column grid |
| Desktop | > 1024px | Full sidebar, 3-column grid, side-by-side evidence |

---

## 6. Development Phases

### Phase 1: Foundation & Design System

**Goal**: Project skeleton, cyberpunk theme, base components, developer experience.

| Task | Description | Priority |
|------|-------------|----------|
| Initialize fullstack env | Run init script, verify dev server | 🔴 Critical |
| Configure Tailwind theme | Cyberpunk color tokens, fonts, shadows | 🔴 Critical |
| Global styles | CSS variables, scanline overlay, custom scrollbar | 🔴 Critical |
| shadcn/ui dark overrides | Configure all base components for dark theme | 🔴 Critical |
| AppShell layout | Sidebar + TopBar + Footer + view router | 🔴 Critical |
| MatrixRain background | Canvas-based animated background | 🟡 Medium |
| GlitchText component | Animated glitch text effect | 🟡 Medium |
| Terminal component | Static terminal UI (no backend yet) | 🔴 Critical |
| TypeWriter component | Typewriter text animation | 🟡 Medium |
| NeonBorder component | Glowing border wrapper | 🟡 Medium |
| LoadingSkeleton | Terminal-style loading states | 🔴 Critical |
| View router | Zustand store for client-side navigation | 🔴 Critical |

**Deliverable**: A fully themed, navigable shell with working view switching and all design-system components.

---

### Phase 2: Authentication & Database

**Goal**: User accounts, session management, database schema.

| Task | Description | Priority |
|------|-------------|----------|
| Prisma schema design | Users, Cases, Submissions, Labs tables | 🔴 Critical |
| Run db:push | Initialize database | 🔴 Critical |
| NextAuth configuration | Credentials provider, session strategy | 🔴 Critical |
| /api/auth routes | Login, register, session endpoints | 🔴 Critical |
| AuthGuard component | Protect views requiring authentication | 🔴 Critical |
| useAuth hook | Auth state management | 🔴 Critical |
| LoginForm component | Cyberpunk-styled login form | 🔴 Critical |
| RegisterForm component | Registration with validation | 🔴 Critical |
| Zod validation schemas | All auth input validation | 🔴 Critical |
| Seed script | Demo user + sample data | 🟡 Medium |

**Database Schema (Core)**:

```prisma
model User {
  id            String   @id @default(cuid())
  email         String   @unique
  username      String   @unique
  passwordHash  String
  displayName   String?
  avatarUrl     String?
  xp            Int      @default(0)
  rank          String   @default("Rookie")
  casesSolved   Int      @default(0)
  currentStreak Int      @default(0)
  longestStreak Int      @default(0)
  lastActiveAt  DateTime @default(now())
  createdAt     DateTime @default(now())
  updatedAt     DateTime @updatedAt

  submissions Submission[]
  labSessions LabSession[]
}

model Case {
  id            String   @id @default(cuid())
  title         String
  slug          String   @unique
  description   String
  scenario      String   // Rich scenario text
  difficulty    String   // "Rookie" | "Analyst" | "Investigator" | "Expert"
  category      String   // "Log Analysis" | "Memory Forensics" | "Network Forensics" | ...
  flagHash      String   // bcrypt hash of the flag — NEVER store plaintext
  xpReward      Int
  order         Int
  isPublished   Boolean  @default(false)
  coverImage    String?
  estimatedTime Int      // Minutes
  createdAt     DateTime @default(now())
  updatedAt     DateTime @updatedAt

  evidence   Evidence[]
  questions  Question[]
  submissions Submission[]
  labConfigs LabConfig[]
}

model Evidence {
  id        String @id @default(cuid())
  caseId    String
  fileName  String
  filePath  String   // Server-side path to evidence file
  fileType  String   // "log" | "pcap" | "memory" | "disk" | "artifact" | "image"
  mimeType  String
  fileSize  Int
  content   String?  // Text content for searchable evidence
  order     Int
  isLocked  Boolean @default(false) // Requires question answer to unlock?

  case Case @relation(fields: [caseId], references: [id], onDelete: Cascade)
}

model Question {
  id          String @id @default(cuid())
  caseId      String
  question    String
  answerHash  String  // bcrypt hash — NEVER plaintext
  hint        String?
  xpReward    Int     @default(50)
  order       Int
  unlocksEvidence String? // ID of evidence this question unlocks

  case Case @relation(fields: [caseId], references: [id], onDelete: Cascade)
}

model Submission {
  id          String   @id @default(cuid())
  userId      String
  caseId      String
  type        String   // "flag" | "question"
  questionId  String?
  answer      String   // The submitted answer (not the correct one)
  isCorrect   Boolean
  xpEarned    Int      @default(0)
  timeTaken   Int?     // Seconds
  createdAt   DateTime @default(now())

  user User @relation(fields: [userId], references: [id])
  case Case @relation(fields: [caseId], references: [id])
}

model LabConfig {
  id          String @id @default(cuid())
  caseId      String
  dockerImage String
  port        Int
  memoryLimit String  // e.g., "512m"
  timeLimit   Int     // Seconds
  description String

  case Case @relation(fields: [caseId], references: [id], onDelete: Cascade)
}

model LabSession {
  id          String   @id @default(cuid())
  userId      String
  caseId      String
  status      String   // "starting" | "running" | "expired" | "stopped"
  containerId String?
  startedAt   DateTime
  expiresAt   DateTime
  stoppedAt   DateTime?

  user User @relation(fields: [userId], references: [id])
}
```

**Deliverable**: Working auth flow, database with schema, seed data.

---

### Phase 3: Cases Engine

**Goal**: Core investigation experience — browse cases, explore evidence, answer questions, submit flags.

| Task | Description | Priority |
|------|-------------|----------|
| Case service | Business logic for case retrieval | 🔴 Critical |
| /api/cases routes | List cases, get case detail | 🔴 Critical |
| /api/cases/[id]/evidence | Serve evidence files securely | 🔴 Critical |
| /api/cases/[id]/questions | Get questions (without answers) | 🔴 Critical |
| /api/cases/[id]/flag | Flag submission endpoint | 🔴 Critical |
| CaseGrid view | Browse all cases with filters | 🔴 Critical |
| CaseCard component | Difficulty badge, category, completion status | 🔴 Critical |
| CaseDetail view | Full case with scenario, evidence, questions | 🔴 Critical |
| EvidenceExplorer | File tree + content preview | 🔴 Critical |
| EvidencePreview | Syntax-highlighted file viewer | 🔴 Critical |
| QuestionPanel | Questions with input validation | 🔴 Critical |
| FlagSubmission | Flag input with attempt tracking | 🔴 Critical |
| useCases hook | TanStack Query integration | 🔴 Critical |
| useSubmissions hook | Mutation + cache invalidation | 🔴 Critical |
| Seed 3 demo cases | Complete with evidence, questions, flags | 🔴 Critical |

**Case Browsing Experience**:

```
┌─────────────────────────────────────────────────┐
│  🔍 CASE LIBRARY                                 │
│  ─────────────────                               │
│  [All] [Log Analysis] [Memory] [Network] [Disk]  │
│  [Rookie] [Analyst] [Investigator] [Expert]      │
│                                                   │
│  ┌──────────┐ ┌──────────┐ ┌──────────┐         │
│  │ 📁 Case 1 │ │ 📁 Case 2 │ │ 📁 Case 3 │         │
│  │ Breached  │ │ Memory   │ │ Network  │         │
│  │ Web Server│ │ Dump Anal│ | Intrusion│         │
│  │           │ │          │ │          │         │
│  │ ● Rookie  │ │ ● Analyst│ │ ● Expert │         │
│  │ ✅ Solved │ │ 🔓 Open  │ │ 🔒 Locked│         │
│  └──────────┘ └──────────┘ └──────────┘         │
└─────────────────────────────────────────────────┘
```

**Evidence Explorer Layout**:

```
┌─────────────────────────────────────────────────────────────┐
│  CASE: Breached Web Server                                   │
│  ──────────────────────                                      │
│                                                               │
│  ┌─ FILES ──────┐  ┌─ PREVIEW ──────────────────────────┐  │
│  │ 📂 /var/log  │  │                                    │  │
│  │  ├── auth.log│  │  Jun 15 03:21:44 web sshd[1234]:   │  │
│  │  ├── syslog  │  │  Failed password for root from      │  │
│  │  └── access  │  │  192.168.1.105 port 22 ssh2         │  │
│  │ 📂 /home     │  │  Jun 15 03:21:47 web sshd[1234]:   │  │
│  │  └── .bash_h │  │  Failed password for root from      │  │
│  │ 📂 /etc      │  │  192.168.1.105 port 22 ssh2         │  │
│  │  └── passwd  │  │  Jun 15 03:21:52 web sshd[1234]:   │  │
│  │ 📂 /tmp      │  │  Accepted password for root from    │  │
│  │  └── susp.sh │  │  192.168.1.105 port 22 ssh2         │  │
│  └──────────────┘  │                                    │  │
│                     └────────────────────────────────────┘  │
│                                                               │
│  ┌─ QUESTIONS ──────────────────────────────────────────┐   │
│  │ Q1: What IP address brute-forced SSH?   ✅ Answered   │   │
│  │ Q2: What time was access gained?        ⬜ [Submit]   │   │
│  │ Q3: What script was left in /tmp?        🔒 Locked    │   │
│  └──────────────────────────────────────────────────────┘   │
│                                                               │
│  ┌─ FLAG ───────────────────────────────────────────────┐   │
│  │  FLAG{...}  [________________]  [SUBMIT]              │   │
│  │  Attempts: 2/5                                       │   │
│  └──────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────┘
```

**Deliverable**: Fully playable case investigation experience with 3 demo cases.

---

### Phase 4: Dashboard & Leaderboard

**Goal**: User stats, XP system, rank progression, global ranking.

| Task | Description | Priority |
|------|-------------|----------|
| User stats service | Calculate XP, rank, streaks, completion | 🔴 Critical |
| /api/user/stats | User statistics endpoint | 🔴 Critical |
| /api/leaderboard | Global ranking with pagination | 🔴 Critical |
| DashboardView | Main dashboard layout | 🔴 Critical |
| StatsOverview | XP, rank, cases solved cards | 🔴 Critical |
| ActivityFeed | Recent submissions timeline | 🟡 Medium |
| SkillRadar | Recharts radar chart for skill areas | 🟡 Medium |
| ProgressChart | XP progress line chart | 🟡 Medium |
| LeaderboardTable | Sortable ranking table | 🔴 Critical |
| RankBadge | Visual rank component | 🔴 Critical |
| XP calculation utility | XP rewards, bonuses, streak multipliers | 🔴 Critical |
| Rank calculation | XP → Rank mapping | 🔴 Critical |

**Rank System**:

| Rank | XP Required | Badge Color |
|------|------------|-------------|
| 🔹 Rookie | 0 | Gray |
| 🔹 Analyst | 500 | Blue |
| 🔸 Investigator | 1,500 | Amber |
| 🔶 Senior Investigator | 4,000 | Orange |
| 🔷 Lead Detective | 8,000 | Purple |
| 💎 Chief Detective | 15,000 | Green glow |
| 👑 Cyber Sage | 30,000 | Gold glow |

**XP Rewards**:

| Action | XP |
|--------|-----|
| Solve a question | 50 XP |
| Solve a Rookie case | 200 XP |
| Solve an Analyst case | 400 XP |
| Solve an Investigator case | 700 XP |
| Solve an Expert case | 1,000 XP |
| First-to-solve bonus | +50% XP |
| Streak bonus (3+ days) | +25% XP |
| No-hint bonus | +20% XP |

**Dashboard Layout**:

```
┌─────────────────────────────────────────────────────────────┐
│  🔍 CYBER DETECTIVE — Dashboard                              │
│  ──────────────────────────────                               │
│                                                               │
│  ┌─ STATS ─────┐ ┌─ STATS ─────┐ ┌─ STATS ─────┐          │
│  │ 2,450 XP    │ │ 7 Cases     │ │ ● Analyst   │          │
│  │ ▲ +200 today│ │ Solved      │ │ Rank        │          │
│  └─────────────┘ └─────────────┘ └─────────────┘          │
│                                                               │
│  ┌─ PROGRESS ────────────────┐  ┌─ SKILLS ─────────────┐  │
│  │ ▓▓▓▓▓▓▓▓▓▓▓░░░░ 68%     │  │     Log Analysis ●●●○ │  │
│  │ Next: Investigator (1,500)│  │     Memory      ●●○○ │  │
│  └───────────────────────────┘  │     Network     ●●●○ │  │
│                                  │     Disk        ●○○○ │  │
│  ┌─ RECENT ACTIVITY ──────────┐ └──────────────────────┘  │
│  │ ✅ Solved "Breached Server"  +200 XP   2h ago          │
│  │ ✅ Answered Q3 "Memory Dump" +50 XP    3h ago          │
│  │ ❌ Flag attempt "Net Intrusion"         5h ago          │
│  └────────────────────────────┘                            │
└─────────────────────────────────────────────────────────────┘
```

**Deliverable**: Complete dashboard and leaderboard with real data.

---

### Phase 5: Lab Architecture

**Goal**: Docker-based lab infrastructure — models, sessions, timer, status system.

| Task | Description | Priority |
|------|-------------|----------|
| Lab service (mini-service) | Socket.IO server on port 3003 | 🔴 Critical |
| Lab Prisma models | LabConfig, LabSession | 🔴 Critical |
| /api/labs routes | Create, status, stop lab sessions | 🔴 Critical |
| LabSession component | Full lab view with terminal | 🔴 Critical |
| LabTimer component | Countdown with visual warnings | 🔴 Critical |
| LabStatus component | Starting → Running → Expired → Stopped | 🔴 Critical |
| LabControls component | Start, stop, reset buttons | 🔴 Critical |
| useLab hook | Lab session state management | 🔴 Critical |
| useTimer hook | Countdown logic with expiration | 🔴 Critical |
| useTerminal hook | Terminal state + command handling | 🔴 Critical |
| Docker API integration | Container lifecycle management | 🔴 Critical |
| Caddy gateway config | Proxy lab Socket.IO through gateway | 🔴 Critical |

**Lab Session Lifecycle**:

```
  ┌──────────┐    ┌──────────┐    ┌──────────┐    ┌──────────┐
  │  IDLE    │───▶│ STARTING │───▶│ RUNNING  │───▶│ EXPIRED  │
  │          │    │          │    │  ⏱ Timer │    │  Time up │
  └──────────┘    └──────────┘    └────┬─────┘    └──────────┘
       ▲                               │
       │          ┌──────────┐         │
       └──────────│ STOPPED  │◀────────┘
                  │ User stop│
                  └──────────┘
```

**Lab View Layout**:

```
┌─────────────────────────────────────────────────────────────┐
│  🧪 LAB: Breached Web Server            ⏱ 00:42:18 / 01:00 │
│  ──────────────────────────────────────────────              │
│  Status: ● RUNNING                                          │
│                                                               │
│  ┌─ TERMINAL ────────────────────────────────────────────┐  │
│  │ root@breached-web:~# ls -la /var/log/                  │  │
│  │ total 128                                               │  │
│  │ drwxr-xr-x  8 root root 4096 Jun 15 03:21 .           │  │
│  │ -rw-r-----  1 root adm  12854 Jun 15 auth.log          │  │
│  │ -rw-r-----  1 root adm  45123 Jun 15 syslog            │  │
│  │ root@breached-web:~# _                                 │  │
│  └────────────────────────────────────────────────────────┘  │
│                                                               │
│  [🛑 STOP LAB]  [🔄 RESET]  [📋 COPY FLAG]                 │
└─────────────────────────────────────────────────────────────┘
```

**Deliverable**: Working lab session system with Docker containers and Socket.IO terminal.

---

### Phase 6: Docker Lab MVP

**Goal**: Simulated terminal experience for demo cases (no real Docker initially).

| Task | Description | Priority |
|------|-------------|----------|
| Simulated terminal backend | Pre-scripted responses for demo cases | 🔴 Critical |
| Terminal command parser | Parse commands, return scripted output | 🔴 Critical |
| File system simulation | Virtual file system with evidence files | 🔴 Critical |
| Command history | Arrow key navigation of past commands | 🟡 Medium |
| Auto-complete | Tab completion for commands and paths | 🟡 Medium |
| Terminal theming | Green-on-black, blinking cursor | 🔴 Critical |
| Copy/paste support | Standard terminal copy/paste | 🟡 Medium |
| Seed lab configs | Configuration for 3 demo case labs | 🔴 Critical |

**Simulated Terminal Architecture**:

```typescript
// The simulated terminal maps commands to pre-defined responses
// This allows a realistic experience without actual Docker containers

interface SimulatedCommand {
  command: string;        // e.g., "cat /var/log/auth.log"
  output: string;         // Pre-scripted response
  nextCommands?: string[] // Commands this unlocks
}

// For each case, a full command tree is defined
// When a user types a command, the simulator matches it
// and returns the scripted output
```

**Deliverable**: Fully functional simulated terminal for all demo cases.

---

### Phase 7: AI Investigator

**Goal**: LLM-powered hint system that guides without giving away answers.

| Task | Description | Priority |
|------|-------------|----------|
| AI service (mini-service) | LLM hint service on port 3004 | 🔴 Critical |
| /api/ai/hint | Rate-limited hint endpoint | 🔴 Critical |
| Hint cost system | Hints reduce XP earned | 🔴 Critical |
| Progressive hints | Hint 1: vague → Hint 3: specific | 🔴 Critical |
| Context-aware prompts | Include case + question + user progress | 🔴 Critical |
| useAIHint hook | Hint request + state management | 🔴 Critical |
| Hint UI | Hint display with XP cost warning | 🟡 Medium |
| Guardrails | Never reveal flags or direct answers | 🔴 Critical |

**Hint Tier System**:

| Tier | Cost | Style | Example |
|------|------|-------|---------|
| Tier 1 | -10% XP | Nudge | "Look at the authentication logs around 3 AM" |
| Tier 2 | -25% XP | Direction | "Focus on the SSH brute-force entries in auth.log" |
| Tier 3 | -50% XP | Near-answer | "Count the failed attempts from 192.168.1.105 before the success" |

**Prompt Engineering (Server-Side Only)**:

```typescript
// AI hint prompt template — NEVER sent to client
const hintPrompt = `
You are a senior DFIR investigator mentoring a junior detective.
They are working on case: "${case.title}"
The question is: "${question.text}"
The correct answer is: "${question.answer}" (NEVER reveal this)

Their progress so far: ${userProgress.summary}

Generate a ${tier} hint that guides them toward the answer
without revealing it directly. Be encouraging but precise.
Use DFIR terminology. Keep it under 100 words.
`;
```

**Deliverable**: Working AI hint system with progressive tiers and XP penalties.

---

### Phase 8: Community & Social Features

**Goal**: Social features for engagement and retention.

| Task | Description | Priority |
|------|-------------|----------|
| User profiles | Public profile with stats and badges | 🟡 Medium |
| Achievement system | Badges for milestones | 🟡 Medium |
| Write-up sharing | Post-solve write-ups (moderated) | 🟠 Low |
| Discussion threads | Per-case discussion (post-solve only) | 🟠 Low |
| Follow system | Follow other detectives | 🟠 Low |
| Activity feed | Global activity stream | 🟡 Medium |
| Notifications | Toast + badge for mentions, follow-ups | 🟡 Medium |

**Achievement Examples**:

| Achievement | Condition | Icon |
|------------|-----------|------|
| First Blood | First to solve a case | 🩸 |
| No Hints | Solve a case without any hints | 🧠 |
| Speed Demon | Solve under estimated time | ⚡ |
| Streak Master | 7-day investigation streak | 🔥 |
| Full House | Solve all cases in a category | 🏠 |
| Night Owl | Solve a case between midnight-5 AM | 🦉 |

**Deliverable**: Social features enhancing community engagement.

---

## 7. Security Rules

### Flag Security (CRITICAL)

```
┌─────────────────────────────────────────────────────────────┐
│                    FLAG SECURITY MODEL                       │
│                                                               │
│  Client                          Server                      │
│  ┌──────────┐                   ┌──────────────────────┐   │
│  │ Submit   │ ──FLAG STRING──▶ │ Hash submitted flag   │   │
│  │ "FLAG{xy}"│                  │ Compare with stored   │   │
│  └──────────┘                   │ bcrypt hash           │   │
│       │                         │                       │   │
│       │ ◀──correct/incorrect── │ Return boolean ONLY   │   │
│       │                         │ NEVER return the flag │   │
│                                  └──────────────────────┘   │
│                                                               │
│  RULES:                                                       │
│  1. Flags stored as bcrypt hashes ONLY                        │
│  2. Flag comparison happens ONLY on the server                │
│  3. API responses NEVER include the correct flag              │
│  4. Question answers follow the same hash-compare pattern     │
│  5. Max 5 flag attempts per case per user                     │
│  6. Rate limit: 1 flag attempt per 10 seconds                 │
└─────────────────────────────────────────────────────────────┘
```

### Input Validation (Zod Schemas)

```typescript
// Every API endpoint validates input with Zod

export const flagSubmissionSchema = z.object({
  flag: z.string()
    .min(1, 'Flag cannot be empty')
    .max(200, 'Flag too long')
    .regex(/^FLAG\{.+\}$/, 'Flag must match format FLAG{...}'),
});

export const questionAnswerSchema = z.object({
  questionId: z.string().cuid(),
  answer: z.string()
    .min(1, 'Answer cannot be empty')
    .max(500, 'Answer too long'),
});

export const labStartSchema = z.object({
  caseId: z.string().cuid(),
});

export const hintRequestSchema = z.object({
  caseId: z.string().cuid(),
  questionId: z.string().cuid(),
  tier: z.number().int().min(1).max(3),
});

export const registrationSchema = z.object({
  email: z.string().email('Invalid email'),
  username: z.string()
    .min(3, 'Username must be at least 3 characters')
    .max(20, 'Username must be at most 20 characters')
    .regex(/^[a-zA-Z0-9_-]+$/, 'Username can only contain letters, numbers, underscores, and hyphens'),
  password: z.string()
    .min(8, 'Password must be at least 8 characters')
    .regex(/[A-Z]/, 'Password must contain an uppercase letter')
    .regex(/[0-9]/, 'Password must contain a number'),
});
```

### Rate Limiting

| Endpoint | Limit | Window |
|----------|-------|--------|
| Flag submission | 6 requests | 60 seconds |
| Question answer | 10 requests | 60 seconds |
| AI hint | 3 requests | 60 seconds |
| Lab start | 2 requests | 300 seconds |
| Login | 5 requests | 300 seconds |
| Registration | 3 requests | 3600 seconds |

### Security Checklist

- [x] Server-side flag validation only — never client-side comparison
- [x] bcrypt hashing for all answers and flags in database
- [x] Zod validation on every API input
- [x] Rate limiting on sensitive endpoints
- [x] NextAuth session validation on protected routes
- [x] No `any` types — strict TypeScript throughout
- [x] SQL injection prevented via Prisma parameterized queries
- [x] XSS prevented via React's built-in escaping + content security
- [x] CORS configured for same-origin only
- [x] Evidence files served through API (not static directory) with auth checks
- [x] No secrets in client-side code — all AI/LLM calls server-only
- [x] Password requirements enforced at validation layer
- [x] Maximum attempt limits on flag/question submissions

---

## 8. Key Principles

### Investigation-First Mindset

> **"Every attack leaves a trace. Can you find it?"**

This is the guiding principle of Cyber Detective. The platform teaches users to **think like investigators**, not attackers.

| Traditional CTF | Cyber Detective |
|-----------------|-----------------|
| Find the vulnerability | Find the evidence of exploitation |
| Exploit the system | Reconstruct how the system was exploited |
| Capture the flag by attacking | Capture the flag by investigating |
| Offensive mindset | Defensive / investigative mindset |
| "Can you break it?" | "Can you figure out what happened?" |

### Core Principles

1. **Defense is a Skill** — Investigating incidents is as challenging and rewarding as launching attacks. We elevate the detective's craft.

2. **Evidence Over Exploitation** — Every case centers on analyzing artifacts left behind. The user never launches an attack — they uncover one.

3. **Progressive Disclosure** — Information is revealed through investigation. Evidence is unlocked by answering questions correctly, mimicking real forensic workflows.

4. **Real-World Relevance** — Cases are based on actual incident patterns (MITRE ATT&CK, real breach reports). Skills transfer directly to the job.

5. **Guidance Without Handouts** — AI hints guide thinking but never give answers. The satisfaction comes from the "Aha!" moment, not the hint.

6. **Gamification With Purpose** — XP, ranks, and leaderboards motivate learning, not just competition. Every point represents real skill development.

7. **Security by Design** — Flags are never exposed. Answers are never sent to the client. Rate limits prevent abuse. The platform itself is a model of secure engineering.

8. **Accessibility** — DFIR skills should be accessible to anyone willing to learn. Clear UX, progressive difficulty, and helpful onboarding.

### Design Philosophy

```
  "If it looks like a terminal at 3 AM in a SOC,
   you're doing it right."
```

The cyberpunk aesthetic isn't just decoration — it's immersion. When users open Cyber Detective, they should feel like they've sat down at a forensic workstation. The green-on-black terminal, the matrix rain, the glowing badges — these aren't gimmicks. They create an environment where investigation feels natural.

### User Experience Tenets

| Tenet | Implementation |
|-------|---------------|
| **Immersive** | Terminal UI, cyberpunk theme, sound effects (future) |
| **Intuitive** | Evidence explorer mirrors real forensic tools |
| **Progressive** | Cases unlock by difficulty, evidence unlocks by questions |
| **Rewarding** | XP, ranks, badges, streaks, first-to-solve bonuses |
| **Challenging** | Real difficulty curve — not everyone solves Expert cases |
| **Educational** | Each case teaches specific DFIR techniques |
| **Social** | Leaderboard, achievements, write-ups foster community |
| **Safe** | Secure by design — the platform itself teaches security |

---

## Appendix: Quick Reference

### API Endpoint Summary

| Method | Endpoint | Auth | Description |
|--------|----------|------|-------------|
| GET | `/api/cases` | ✅ | List published cases |
| GET | `/api/cases/[id]` | ✅ | Get case details |
| GET | `/api/cases/[id]/evidence` | ✅ | Get evidence file list |
| GET | `/api/cases/[id]/questions` | ✅ | Get questions (no answers) |
| POST | `/api/cases/[id]/flag` | ✅ | Submit flag |
| POST | `/api/submissions` | ✅ | Submit question answer |
| GET | `/api/user` | ✅ | Get current user |
| GET | `/api/user/stats` | ✅ | Get user statistics |
| GET | `/api/leaderboard` | ❌ | Get global leaderboard |
| POST | `/api/labs` | ✅ | Start lab session |
| GET | `/api/labs/[id]` | ✅ | Get lab status |
| POST | `/api/ai/hint` | ✅ | Request AI hint |
| POST | `/api/auth/register` | ❌ | Register new user |

### Component Index

| Component | Category | Status |
|-----------|----------|--------|
| AppShell | Layout | Phase 1 |
| Sidebar | Layout | Phase 1 |
| TopBar | Layout | Phase 1 |
| Terminal | Terminal | Phase 1 |
| CaseCard | Cases | Phase 3 |
| CaseGrid | Cases | Phase 3 |
| CaseDetail | Cases | Phase 3 |
| EvidenceExplorer | Cases | Phase 3 |
| QuestionPanel | Cases | Phase 3 |
| FlagSubmission | Cases | Phase 3 |
| DashboardView | Dashboard | Phase 4 |
| StatsOverview | Dashboard | Phase 4 |
| SkillRadar | Dashboard | Phase 4 |
| LeaderboardTable | Leaderboard | Phase 4 |
| LabSession | Lab | Phase 5 |
| LabTimer | Lab | Phase 5 |
| LoginForm | Auth | Phase 2 |
| GlitchText | Shared | Phase 1 |
| MatrixRain | Shared | Phase 1 |
| NeonBorder | Shared | Phase 1 |

---

*Last updated: 2026-03-04*
*Version: 1.0.0*
*Project: Cyber Detective — DFIR Education Platform*
