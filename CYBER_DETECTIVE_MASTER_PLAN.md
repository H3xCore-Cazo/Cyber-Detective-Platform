# CYBER DETECTIVE — Master Plan

> **"Hack The Box for Cyber Detectives"**
> Build investigative minds, not attack skills.
> **Every attack leaves a trace. Can you find it?**

---

| Field | Value |
|---|---|
| **Project Type** | Cybersecurity Education Platform |
| **Category** | DFIR Cyber Range |
| **Version** | 2.0 — The Tiny Grains of Wheat Edition |
| **Status** | Blueprint / Active Development |
| **Last Updated** | 2025-03-04 |

---

## Table of Contents

1. [Vision & Core Philosophy](#1-vision--core-philosophy)
2. [Development Roadmap](#2-development-roadmap)
3. [Architecture](#3-architecture)
4. [Database Schema](#4-database-schema)
5. [Lab System](#5-lab-system)
6. [Case Categories](#6-case-categories)
7. [Evidence System](#7-evidence-system)
8. [Objectives & Flag System](#8-objectives--flag-system)
9. [AI Investigator](#9-ai-investigator)
10. [Security Rules](#10-security-rules)
11. [Future Features](#11-future-features)
12. [Pricing Tiers](#12-pricing-tiers)
13. [API Endpoints](#13-api-endpoints)
14. [Monitoring & Analytics](#14-monitoring--analytics)
15. [Deployment Guide](#15-deployment-guide)
16. [Pre-Launch Checklists](#16-pre-launch-checklists)
17. [Builder Learning Path](#17-builder-learning-path-30-days)
18. [First Prototype Blueprint](#18-first-prototype-blueprint)
19. [Final Vision](#19-final-vision)

---

## 1. Vision & Core Philosophy

### 1.1 The Paradigm Shift

Cyber Detective is built on a fundamentally different educational model than existing cybersecurity platforms. While other platforms teach attack skills, Cyber Detective **builds investigative minds**.

```
┌─────────────────────────────────┬──────────────────────────────────────┐
│      Traditional Platform       │         Cyber Detective              │
├─────────────────────────────────┼──────────────────────────────────────┤
│  Attack a vulnerable machine    │  Receive a real incident to          │
│                                 │  investigate                         │
│  Exploit → Capture Flag         │  Analyze → Trace → Report           │
│  Learn offensive tools          │  Learn investigative thinking        │
│  Hacker mindset                 │  Analyst / Detective mindset         │
│  Solo exploit                   │  Full incident reconstruction        │
└─────────────────────────────────┴──────────────────────────────────────┘
```

### 1.2 The Investigation Flow

```
  ┌───────────┐    ┌───────────┐    ┌───────────┐    ┌───────────┐
  │  Step 1   │───▶│  Step 2   │───▶│  Step 3   │───▶│  Step 4   │
  │ Incident  │    │ Collect   │    │ Analyze   │    │  Trace    │
  │ Happens   │    │ Evidence  │    │ Artifacts │    │ Attacker  │
  └───────────┘    └───────────┘    └───────────┘    └───────────┘
                                                          │
  ┌───────────┐    ┌───────────┐    ┌───────────┐    ┌────┴──────┐
  │  Step 8   │◀───│  Step 7   │◀───│  Step 6   │◀───│  Step 5   │
  │ Write     │    │ Determine │    │ Identify  │    │ Find      │
  │ Report    │    │ Impact    │    │Persist-   │    │ Initial   │
  │           │    │           │    │ ence      │    │ Access    │
  └───────────┘    └───────────┘    └───────────┘    └───────────┘
```

1. **Incident Happens** — A simulated breach occurs inside the lab environment
2. **Collect Evidence** — User gathers logs, PCAP, memory dumps, emails
3. **Analyze Artifacts** — User inspects files, applies forensic techniques
4. **Trace Attacker** — Timeline reconstruction, lateral movement mapping
5. **Find Initial Access** — Identify patient zero, entry vector
6. **Identify Persistence** — Find backdoors, scheduled tasks, registry keys
7. **Determine Impact** — What data was touched, exfiltrated, modified
8. **Write Incident Report** — Structured DFIR report with IOCs and recommendations

### 1.3 Who The User Becomes

- SOC Analyst
- Incident Responder
- DFIR Investigator
- Threat Hunter
- Malware Analyst
- Blue Team Operator

### 1.4 Why This Succeeds

- Companies hire people who can **analyze incidents and write reports** — not just run tools
- DFIR is a rapidly growing field with **increasing demand and shortage of trained professionals**
- The story-based format makes learning **engaging** — more like a detective game than a course
- **No other major platform** focuses exclusively on the defensive / investigative side

---

## 2. Development Roadmap

### Phase Overview

```
  Phase 1        Phase 2        Phase 3        Phase 4        Phase 5
  Months 1-2     Months 3-4     Months 5-6     Months 7-9     Months 10-11
  ┌──────┐       ┌──────┐       ┌──────┐       ┌──────┐       ┌──────┐
  │ MVP  │──────▶│Docker│──────▶│Multi │──────▶│ Win  │──────▶│  AI  │
  │      │       │ Labs │       │Machine│      │  AD  │       │ Inv. │
  └──────┘       └──────┘       └──────┘       └──────┘       └──────┘
       │              │              │              │              │
       ▼              ▼              ▼              ▼              ▼
  Auth + 5      ttyd + Orch.   Docker Comp    Proxmox +      Hints +
  cases +       + 3 Linux      + networking   Guacamole +    Report
  evidence +    cases          + 3 multi-     RDP + 2 AD     grading
  flags +                                      cases          + AI
  scoring +                                                    guardrails
  profile +
  leaderboard

  Phase 6          Phase 7        Phase 8        Phase 9        Phase 10
  Month 12+        Month 18       Month 24       Month 30       Month 36
  ┌──────┐         ┌──────┐       ┌──────┐       ┌──────┐       ┌──────┐
  │Scale │────────▶│Mobile│──────▶│ Live │──────▶│Case  │──────▶│  ML  │
  │  &   │         │ App  │       │Attack│       │Market│       │Unique│
  │Enter.│         │      │       │ Sim  │       │place │       │Cases │
  └──────┘         └──────┘       └──────┘       └──────┘       └──────┘
       │               │              │              │              │
       ▼               ▼              ▼              ▼              ▼
  K8s +           Evidence +     Real-time      Community      Never the
  SSO +           flag sub +     SOC response   creates +      same case
  certs +         case browse    + scoring      revenue share  twice
  custom cases
```

### Phase 1 — MVP (Months 1–2)

| # | Deliverable | Status |
|---|---|---|
| 1 | User authentication (signup, login, email verify, OAuth) | ☐ |
| 2 | 5 complete cases with static evidence files | ☐ |
| 3 | Evidence viewer with file browser and log viewer | ☐ |
| 4 | Flag submission system with server-side validation | ☐ |
| 5 | Scoring and XP calculation | ☐ |
| 6 | User profile page with statistics | ☐ |
| 7 | Global leaderboard | ☐ |
| 8 | Deploy to VPS (Nginx + Supabase) | ☐ |
| 9 | SSL certificate + basic monitoring | ☐ |

### Phase 2 — Docker Labs (Months 3–4)

| # | Deliverable | Status |
|---|---|---|
| 1 | Docker Engine setup on VPS | ☐ |
| 2 | ttyd browser terminal integration | ☐ |
| 3 | Lab Orchestrator API (start/stop/cleanup containers) | ☐ |
| 4 | 3 Linux forensics interactive cases | ☐ |
| 5 | Session time tracking and expiration | ☐ |
| 6 | Evidence injection automation | ☐ |
| 7 | Scale test: 50 concurrent users | ☐ |

### Phase 3 — Multi-Machine Labs (Months 5–6)

| # | Deliverable | Status |
|---|---|---|
| 1 | Docker Compose support for multi-container scenarios | ☐ |
| 2 | Internal networking between containers | ☐ |
| 3 | 3 multi-machine cases (web breach, lateral movement) | ☐ |
| 4 | Pro subscription tier + Stripe billing | ☐ |
| 5 | Lab template system (reusable configurations) | ☐ |
| 6 | Kubernetes research and prototype | ☐ |

### Phase 4 — Windows AD Labs (Months 7–9)

| # | Deliverable | Status |
|---|---|---|
| 1 | Proxmox VE setup on dedicated server | ☐ |
| 2 | Windows Server 2022 base templates | ☐ |
| 3 | Apache Guacamole — RDP in browser | ☐ |
| 4 | 2 Active Directory attack investigation cases | ☐ |
| 5 | VM snapshot management for fast cloning | ☐ |
| 6 | Windows evidence injection automation (WinRM) | ☐ |

### Phase 5 — AI Investigator (Months 10–11)

| # | Deliverable | Status |
|---|---|---|
| 1 | AI Investigator API integration (Anthropic / OpenAI) | ☐ |
| 2 | Context-aware hint generation | ☐ |
| 3 | Progressive hint levels (3-tier) | ☐ |
| 4 | Evidence summarization feature | ☐ |
| 5 | Guardrails: no flag leakage, rate limiting | ☐ |
| 6 | AI report grading for Investigation Reports | ☐ |
| 7 | All interactions logged for quality review | ☐ |

### Phase 6 — Scale & Enterprise (Month 12+)

| # | Deliverable | Status |
|---|---|---|
| 1 | Full Kubernetes migration | ☐ |
| 2 | Auto-scaling based on queue depth | ☐ |
| 3 | Enterprise features: SSO, private cases, audit logs | ☐ |
| 4 | Custom case builder (GUI) | ☐ |
| 5 | Community write-up sharing | ☐ |
| 6 | Certification system | ☐ |
| 7 | API documentation for integrations | ☐ |
| 8 | SOC2 Type II preparation | ☐ |

### Phase 7 — Mobile App (Month 18)

- Evidence viewer on mobile
- Flag submission from mobile
- Case browsing and progress tracking

### Phase 8 — Live Attack Simulation (Month 24)

- Real-time SOC response with scoring
- Scheduled live events where all users respond simultaneously
- Team-based incident response exercises

### Phase 9 — Case Marketplace (Month 30)

- Community creates and publishes cases
- Revenue sharing with case creators
- Quality review pipeline for published cases

### Phase 10 — ML-Generated Unique Cases (Month 36)

- ML generates unique investigation scenarios per user
- Never the same investigation twice
- Adaptive difficulty based on user skill level

---

## 3. Architecture

### 3.1 System Architecture Diagram

```
                              ┌─────────────────────────────┐
                              │        Cloudflare CDN        │
                              │    DDoS Protection + DNS     │
                              └──────────────┬──────────────┘
                                             │
                              ┌──────────────▼──────────────┐
                              │     Nginx Reverse Proxy      │
                              │   SSL Termination + Routing  │
                              └──────────────┬──────────────┘
                                             │
                    ┌────────────────────────┬┴┬────────────────────────┐
                    │                        │ │                        │
         ┌──────────▼──────────┐  ┌──────────▼──────────┐  ┌──────────▼──────────┐
         │   Next.js Frontend  │  │  Next.js API Routes  │  │   Lab Orchestrator  │
         │   (React + SSR)     │  │  (REST API Layer)    │  │  (Dedicated Service)│
         │                     │  │                      │  │                     │
         │  • Tailwind CSS     │  │  • Auth endpoints    │  │  • Container mgmt   │
         │  • shadcn/ui        │  │  • Case CRUD         │  │  • VM provisioning  │
         │  • xterm.js         │  │  • Flag validation   │  │  • Evidence inject  │
         │  • Monaco Editor    │  │  • Scoring engine    │  │  • Session lifecycle│
         │  • Zustand          │  │  • Report grading    │  │  • Cleanup cron     │
         │  • TanStack Query   │  │  • AI integration    │  │  • Health monitor   │
         │  • Framer Motion    │  │                      │  │                     │
         └─────────────────────┘  └──────────┬───────────┘  └──────────┬──────────┘
                                              │                         │
                    ┌─────────────────────────┬┘                         │
                    │                         │                          │
         ┌──────────▼──────────┐  ┌──────────▼──────────┐  ┌───────────▼──────────┐
         │  Prisma ORM         │  │  NextAuth.js v4      │  │   Docker Engine       │
         │  (Type-safe DB)     │  │  (Authentication)    │  │   ├─ Linux Labs       │
         │                     │  │                      │  │   │  └─ ttyd (term)  │
         │  • Migrations       │  │  • Email/Pass        │  │   ├─ Multi-Machine    │
         │  • Query builder    │  │  • Google OAuth      │  │   │  └─ Compose     │
         │  • SQLite (dev)     │  │  • GitHub OAuth      │  │   └─ Memory For.     │
         │  • PG (prod)        │  │  • 2FA / TOTP        │  │      └─ Volatility   │
         └──────────┬──────────┘  └──────────────────────┘  └──────────────────────┘
                    │
         ┌──────────▼──────────────────────────────────────────────────────────┐
         │                      SQLite / PostgreSQL                            │
         │                                                                      │
         │  users │ cases │ objectives │ flags │ evidence │ lab_sessions │ ...  │
         └─────────────────────────────────────────────────────────────────────┘

                    ┌──────────────────────────────────────────────────────────┐
                    │               Proxmox VE (Phase 4+)                      │
                    │                                                          │
                    │   Windows Server 2022 (DC) ─── Windows 10/11 (WS)       │
                    │         │                          │                     │
                    │         └──── Apache Guacamole ────┘                     │
                    │                   │                                       │
                    │              Browser RDP                                  │
                    └──────────────────────────────────────────────────────────┘
```

### 3.2 Frontend Stack

| Technology | Purpose | Why |
|---|---|---|
| **Next.js 16** (App Router) | Full-stack React framework | Server components, API routes, streaming |
| **TypeScript 5+** | Type safety across codebase | Fewer runtime bugs, better DX |
| **Tailwind CSS** | Utility-first styling | Fast, consistent design |
| **shadcn/ui** | Component library | Accessible, customizable components |
| **xterm.js** | Terminal emulation | Used with ttyd for browser terminal |
| **Monaco Editor** | Log/code viewer | Syntax highlighting, search, large file support |
| **Zustand** | Client state management | Lightweight, simple API |
| **TanStack Query** | Server state + caching | Automatic refetching, loading states |
| **Framer Motion** | Animations | Smooth transitions, progress feedback |
| **recharts** | Data visualization | Score charts, timeline visualization |

### 3.3 Backend Stack

| Technology | Purpose | Why |
|---|---|---|
| **Next.js API Routes** | REST API layer | Co-located with frontend |
| **NextAuth.js v4** | Authentication | Email/OAuth, session management |
| **Prisma ORM** | Database access layer | Type-safe queries, migrations |
| **Redis / Upstash** | Queue + rate limiting + cache | Lab job queue, session cache |
| **BullMQ** | Background job queue | Lab start/stop jobs, cleanup cron |
| **Resend + React Email** | Transactional email | Verification, notifications |

### 3.4 Infrastructure Stack

| Technology | Purpose | Phase |
|---|---|---|
| **Docker Engine** | Linux lab containers | Phase 1+ |
| **Docker Compose** | Local dev + multi-container labs | Phase 1+ |
| **ttyd** | Browser terminal for Linux | Phase 2+ |
| **Apache Guacamole** | Browser RDP for Windows | Phase 4+ |
| **Proxmox VE** | Windows VM host | Phase 4+ |
| **Kubernetes (K8s)** | Container orchestration at scale | Phase 6 |
| **Nginx** | Reverse proxy, SSL termination | Phase 1+ |
| **Certbot / Let's Encrypt** | SSL certificates | Phase 1+ |
| **S3-Compatible Storage** | Evidence file storage | Phase 1+ |
| **Cloudflare** | CDN, DDoS protection, DNS | Phase 1+ |

### 3.5 Monitoring Stack

| Tool | Purpose |
|---|---|
| **Prometheus** | Metrics collection from all services |
| **Grafana** | Dashboard visualization for metrics |
| **Loki / Better Stack** | Centralized log aggregation |
| **Sentry** | Application error tracking |
| **Uptime Robot** | External uptime monitoring with alerts |
| **Node Exporter** | Server hardware metrics (CPU, RAM, disk) |

### 3.6 Browser Access Technologies

#### Linux Terminal — ttyd

| Property | Value |
|---|---|
| Project | tsl0922/ttyd (open source) |
| Protocol | WebSocket over HTTPS |
| Frontend | xterm.js (runs in browser) |
| Usage | `ttyd --port 8080 --credential user:pass bash` |
| Integration | Proxied through Nginx — user sees `/lab/{sessionId}/terminal` |
| Alternative | Wetty (Node.js based, more features, more complex) |

#### Windows RDP — Apache Guacamole

| Property | Value |
|---|---|
| Project | Apache Guacamole (open source, ASF) |
| Components | guacd daemon + guacamole-client web app |
| Protocol Bridge | Browser ↔ WebSocket ↔ guacamole-client ↔ guacd ↔ RDP/VNC/SSH |
| No client required | User needs only a browser — no RDP client installed |
| Connection config | Protocol: rdp, hostname: VM IP, port: 3389, credentials per session |
| Resolution | Default 1280x900, configurable up to 1920x1080 |
| Security | Guacamole token auth — each token valid for one session only |

---

## 4. Database Schema

### 4.1 Users & Authentication Tables

#### `users`

| Column | Type | Constraints | Description |
|---|---|---|---|
| `id` | UUID | PK, default gen | Unique user identifier |
| `email` | VARCHAR(255) | UNIQUE, NOT NULL | User email address |
| `username` | VARCHAR(50) | UNIQUE, NOT NULL | Public handle |
| `password_hash` | VARCHAR(255) | NOT NULL | bcrypt hash (cost factor 12+) |
| `email_verified` | BOOLEAN | DEFAULT false | Email verification status |
| `role` | ENUM('user','admin','moderator') | DEFAULT 'user' | System role |
| `subscription_tier` | ENUM('free','pro','team','enterprise') | DEFAULT 'free' | Billing tier |
| `subscription_expires_at` | TIMESTAMP | NULLABLE | Subscription expiry |
| `created_at` | TIMESTAMP | DEFAULT now() | Account creation time |
| `last_login` | TIMESTAMP | NULLABLE | Most recent login |
| `is_active` | BOOLEAN | DEFAULT true | Account active status |

#### `user_profiles`

| Column | Type | Constraints | Description |
|---|---|---|---|
| `user_id` | UUID | FK → users.id, PK | One-to-one with users |
| `display_name` | VARCHAR(100) | | Full display name |
| `bio` | TEXT | | Up to 500 chars, Markdown supported |
| `avatar_url` | VARCHAR(500) | | Uploaded image or Gravatar fallback |
| `country_code` | CHAR(2) | | ISO 3166-1 alpha-2 flag emoji |
| `experience_level` | ENUM('beginner','intermediate','advanced','expert') | DEFAULT 'beginner' | Skill level |
| `github_username` | VARCHAR(100) | | GitHub profile link |
| `linkedin_url` | VARCHAR(500) | | LinkedIn profile link |
| `twitter_username` | VARCHAR(100) | | Twitter handle |
| `website_url` | VARCHAR(500) | | Personal website |
| `notification_settings` | JSONB | DEFAULT '{}' | Email/push preferences |
| `is_public` | BOOLEAN | DEFAULT true | Profile visibility toggle |
| `show_solved_cases` | BOOLEAN | DEFAULT true | Show/hide solved cases |
| `show_rank` | BOOLEAN | DEFAULT true | Show/hide global rank |

#### `user_statistics`

| Column | Type | Constraints | Description |
|---|---|---|---|
| `user_id` | UUID | FK → users.id, PK | One-to-one with users |
| `total_xp` | INTEGER | DEFAULT 0 | Cumulative XP earned |
| `total_cases_solved` | INTEGER | DEFAULT 0 | Cases with ≥1 flag submitted |
| `total_flags_found` | INTEGER | DEFAULT 0 | Correct flag submissions |
| `total_hints_used` | INTEGER | DEFAULT 0 | Total hints consumed |
| `total_investigation_time` | INTEGER | DEFAULT 0 | Minutes in active labs |
| `accuracy_percentage` | DECIMAL(5,2) | DEFAULT 0.00 | Correct vs total attempts |
| `current_streak` | INTEGER | DEFAULT 0 | Consecutive days with submission |
| `longest_streak` | INTEGER | DEFAULT 0 | All-time best streak |
| `global_rank` | INTEGER | NULLABLE | Position on main leaderboard |
| `country_rank` | INTEGER | NULLABLE | Position in country leaderboard |
| `solved_by_category` | JSONB | DEFAULT '{}' | Breakdown: `{"network": 5, "windows": 3}` |
| `achievements_count` | INTEGER | DEFAULT 0 | Total badges earned |
| `avg_time_per_case` | INTEGER | DEFAULT 0 | Average minutes per case |

#### `user_sessions`

| Column | Type | Constraints | Description |
|---|---|---|---|
| `id` | UUID | PK, default gen | Session identifier |
| `user_id` | UUID | FK → users.id | Session owner |
| `token` | VARCHAR(255) | UNIQUE, NOT NULL | Auth token |
| `ip_address` | INET | | Login IP address |
| `user_agent` | TEXT | | Browser user agent |
| `created_at` | TIMESTAMP | DEFAULT now() | Session start |
| `expires_at` | TIMESTAMP | NOT NULL | Session expiry |
| `is_revoked` | BOOLEAN | DEFAULT false | Manual revocation flag |

### 4.2 Cases & Content Tables

#### `cases`

| Column | Type | Constraints | Description |
|---|---|---|---|
| `id` | VARCHAR(20) | PK | Format: `CASE-001` |
| `title` | VARCHAR(200) | NOT NULL | Human-readable title |
| `slug` | VARCHAR(200) | UNIQUE, NOT NULL | URL-safe version |
| `description` | TEXT | | Short description for cards |
| `story` | TEXT | NOT NULL | Full narrative in Markdown |
| `category` | ENUM('network','email','windows','linux','malware','cloud','ad') | NOT NULL | Case category |
| `difficulty` | ENUM('beginner','easy','medium','advanced','expert') | NOT NULL | Difficulty level |
| `estimated_time` | INTEGER | NOT NULL | Minutes to complete |
| `points` | INTEGER | NOT NULL | Total possible points |
| `xp` | INTEGER | NOT NULL | Total possible XP |
| `author_id` | UUID | FK → users.id | Creator |
| `created_at` | TIMESTAMP | DEFAULT now() | Creation time |
| `published_at` | TIMESTAMP | NULLABLE | Publication time |
| `is_published` | BOOLEAN | DEFAULT false | Visibility flag |
| `is_featured` | BOOLEAN | DEFAULT false | Homepage feature |
| `tags` | TEXT[] | DEFAULT '{}' | Category + technique + tool tags |
| `prerequisites` | TEXT[] | DEFAULT '{}' | Recommended case IDs |
| `thumbnail_url` | VARCHAR(500) | | Cover image URL |
| `rating` | DECIMAL(2,1) | DEFAULT 0.0 | Aggregate 1-5 star rating |
| `solves_count` | INTEGER | DEFAULT 0 | Total completions |
| `view_count` | INTEGER | DEFAULT 0 | Total page views |

#### `objectives`

| Column | Type | Constraints | Description |
|---|---|---|---|
| `id` | UUID | PK, default gen | Objective identifier |
| `case_id` | VARCHAR(20) | FK → cases.id | Parent case |
| `order_number` | INTEGER | NOT NULL | Display sequence |
| `title` | VARCHAR(200) | NOT NULL | Short objective label |
| `description` | TEXT | NOT NULL | Full question text |
| `type` | ENUM('flag','multiple_choice','text','number','report_section') | NOT NULL | Objective type |
| `points` | INTEGER | NOT NULL | XP awarded on correct answer |
| `hint_cost` | INTEGER | DEFAULT 10 | XP deducted per hint |
| `hints` | TEXT[] | DEFAULT '{}' | Progressive hints array |
| `required_for_completion` | BOOLEAN | DEFAULT true | Optional bonus flag |
| `depends_on` | UUID[] | DEFAULT '{}' | Prerequisite objective IDs |

#### `objective_options`

| Column | Type | Constraints | Description |
|---|---|---|---|
| `id` | UUID | PK, default gen | Option identifier |
| `objective_id` | UUID | FK → objectives.id | Parent objective |
| `option_text` | TEXT | NOT NULL | Option display text |
| `is_correct` | BOOLEAN | NOT NULL | Correct answer flag |
| `order_number` | INTEGER | NOT NULL | Display sequence |

#### `flags`

| Column | Type | Constraints | Description |
|---|---|---|---|
| `id` | UUID | PK, default gen | Flag identifier |
| `case_id` | VARCHAR(20) | FK → cases.id | Parent case |
| `flag_value` | VARCHAR(255) | NOT NULL | Hashed flag value (SHA-256) |
| `points` | INTEGER | NOT NULL | Points for this flag |
| `hint` | TEXT | | Hint for this flag |
| `order_number` | INTEGER | NOT NULL | Submission sequence |

#### `evidence`

| Column | Type | Constraints | Description |
|---|---|---|---|
| `id` | UUID | PK, default gen | Evidence identifier |
| `case_id` | VARCHAR(20) | FK → cases.id | Parent case |
| `filename` | VARCHAR(255) | NOT NULL | Internal storage name |
| `original_name` | VARCHAR(255) | NOT NULL | Display name |
| `file_type` | VARCHAR(50) | NOT NULL | Extension category |
| `file_size` | BIGINT | NOT NULL | Bytes |
| `file_hash` | VARCHAR(64) | NOT NULL | SHA-256 hash |
| `mime_type` | VARCHAR(100) | | MIME type |
| `storage_path` | VARCHAR(500) | NOT NULL | S3/filesystem path (never exposed) |
| `is_corrupted` | BOOLEAN | DEFAULT false | Partially broken for realism |
| `is_decoy` | BOOLEAN | DEFAULT false | Misleading irrelevant file |
| `created_at` | TIMESTAMP | DEFAULT now() | Upload time |

### 4.3 Lab System Tables

#### `lab_templates`

| Column | Type | Constraints | Description |
|---|---|---|---|
| `id` | UUID | PK, default gen | Template identifier |
| `case_id` | VARCHAR(20) | FK → cases.id | Associated case |
| `name` | VARCHAR(200) | NOT NULL | Template name |
| `type` | ENUM('static','docker','multi','windows_ad','memory','cloud') | NOT NULL | Lab type A-F |
| `configuration` | JSONB | NOT NULL | Docker/VM config details |
| `resource_requirements` | JSONB | NOT NULL | CPU, RAM, disk limits |
| `timeout_minutes` | INTEGER | DEFAULT 120 | Hard session timeout |
| `max_concurrent_users` | INTEGER | DEFAULT 50 | Capacity limit |

**`configuration` JSONB structure (Docker example):**
```json
{
  "image": "cyberdetective/ubuntu-forensics:latest",
  "evidence_mount": "/evidence/",
  "ttyd_port": 8080,
  "network_mode": "bridge",
  "environment": {
    "INVESTIGATOR_USER": "investigator",
    "CASE_ID": "CASE-001"
  }
}
```

**`configuration` JSONB structure (Windows AD example):**
```json
{
  "domain": "cyberdetective.local",
  "machines": [
    {"name": "DC01", "role": "domain_controller", "template": "win2022-dc"},
    {"name": "WS01", "role": "workstation", "template": "win10-workstation"},
    {"name": "FS01", "role": "file_server", "template": "win2019-fileserver"}
  ],
  "guacamole_config": {
    "protocol": "rdp",
    "resolution": "1280x900"
  }
}
```

**`resource_requirements` JSONB structure:**
```json
{
  "cpu_cores": 0.5,
  "memory_mb": 512,
  "disk_gb": 10,
  "networks": 1
}
```

#### `lab_sessions`

| Column | Type | Constraints | Description |
|---|---|---|---|
| `id` | VARCHAR(50) | PK | Format: `sess_abc123` |
| `user_id` | UUID | FK → users.id | Session owner |
| `case_id` | VARCHAR(20) | FK → cases.id | Associated case |
| `lab_template_id` | UUID | FK → lab_templates.id | Lab template |
| `status` | ENUM('pending','starting','running','paused','expiring','terminated') | NOT NULL | Session status |
| `container_id` | VARCHAR(100) | NULLABLE | Docker container ID (Linux) |
| `vm_id` | VARCHAR(100) | NULLABLE | Proxmox VM ID (Windows) |
| `ip_address` | INET | NULLABLE | Lab internal IP |
| `username` | VARCHAR(50) | NULLABLE | Auto-generated session user |
| `password` | VARCHAR(100) | NULLABLE | Auto-generated session pass |
| `connection_url` | VARCHAR(500) | NULLABLE | URL returned to client |
| `flags_submitted` | JSONB | DEFAULT '[]' | Submitted flags with timestamps |
| `score` | INTEGER | DEFAULT 0 | Running total XP |
| `started_at` | TIMESTAMP | NULLABLE | Lab running start |
| `expires_at` | TIMESTAMP | NOT NULL | Hard deadline |
| `paused_at` | TIMESTAMP | NULLABLE | Pause timestamp |
| `terminated_at` | TIMESTAMP | NULLABLE | Termination timestamp |
| `last_heartbeat` | TIMESTAMP | NULLABLE | Updated every 30s |

**Session status flow:**
```
  pending ──▶ starting ──▶ running ──▶ paused ──▶ running
                                │                     │
                                ▼                     ▼
                            expiring ────────────▶ terminated
```

#### `lab_activity`

| Column | Type | Constraints | Description |
|---|---|---|---|
| `id` | UUID | PK, default gen | Activity identifier |
| `session_id` | VARCHAR(50) | FK → lab_sessions.id | Parent session |
| `action` | ENUM('flag_submitted','hint_used','time_extended','paused','resumed','heartbeat_missed') | NOT NULL | Action type |
| `details` | JSONB | DEFAULT '{}' | Action-specific data |
| `created_at` | TIMESTAMP | DEFAULT now() | Event timestamp |

#### `flag_submissions`

| Column | Type | Constraints | Description |
|---|---|---|---|
| `id` | UUID | PK, default gen | Submission identifier |
| `session_id` | VARCHAR(50) | FK → lab_sessions.id | Parent session |
| `flag_id` | UUID | FK → flags.id | Target flag |
| `flag_value` | VARCHAR(255) | NOT NULL | Submitted value |
| `is_correct` | BOOLEAN | NOT NULL | Validation result |
| `attempts` | INTEGER | DEFAULT 1 | Attempt count for this flag |
| `points_awarded` | INTEGER | DEFAULT 0 | XP earned (0 if incorrect) |
| `created_at` | TIMESTAMP | DEFAULT now() | Submission time |

### 4.4 Reports & Community Tables

#### `investigation_reports`

| Column | Type | Constraints | Description |
|---|---|---|---|
| `id` | UUID | PK, default gen | Report identifier |
| `session_id` | VARCHAR(50) | FK → lab_sessions.id | Parent session |
| `user_id` | UUID | FK → users.id | Report author |
| `case_id` | VARCHAR(20) | FK → cases.id | Associated case |
| `executive_summary` | TEXT | | 1-paragraph overview |
| `timeline` | JSONB | | Chronological events |
| `initial_access` | TEXT | | How attacker entered |
| `affected_systems` | TEXT[] | DEFAULT '{}' | Compromised hosts/IPs/accounts |
| `attacker_actions` | TEXT | | Detailed TTPs observed |
| `data_impact` | TEXT | | Data accessed/modified/exfiltrated |
| `iocs` | JSONB | DEFAULT '{}' | Structured: `{ips:[], domains:[], hashes:[], paths:[]}` |
| `root_cause` | TEXT | | Why attack was possible |
| `recommendations` | TEXT[] | DEFAULT '{}' | Actionable prevention steps |
| `ai_score` | INTEGER | NULLABLE | AI grading 0-100 |
| `ai_feedback` | JSONB | NULLABLE | Per-section AI feedback |
| `human_score` | INTEGER | NULLABLE | Manual grading (admin) |
| `status` | ENUM('draft','submitted','graded') | DEFAULT 'draft' | Report status |
| `submitted_at` | TIMESTAMP | NULLABLE | Submission time |
| `graded_at` | TIMESTAMP | NULLABLE | Grading completion time |

#### `case_comments`

| Column | Type | Constraints | Description |
|---|---|---|---|
| `id` | UUID | PK, default gen | Comment identifier |
| `case_id` | VARCHAR(20) | FK → cases.id | Parent case |
| `user_id` | UUID | FK → users.id | Comment author |
| `parent_id` | UUID | FK → case_comments.id, NULLABLE | Reply threading |
| `content` | TEXT | NOT NULL | Comment text (Markdown) |
| `is_spoiler` | BOOLEAN | DEFAULT false | Contains solution hints |
| `upvotes` | INTEGER | DEFAULT 0 | Community votes |
| `created_at` | TIMESTAMP | DEFAULT now() | Comment time |
| `updated_at` | TIMESTAMP | DEFAULT now() | Last edit time |

#### `achievements`

| Column | Type | Constraints | Description |
|---|---|---|---|
| `id` | UUID | PK, default gen | Achievement identifier |
| `name` | VARCHAR(100) | UNIQUE, NOT NULL | Achievement name |
| `description` | TEXT | NOT NULL | How to earn it |
| `badge_icon_url` | VARCHAR(500) | | Badge image |
| `xp_reward` | INTEGER | DEFAULT 0 | Bonus XP on earn |

#### `user_achievements`

| Column | Type | Constraints | Description |
|---|---|---|---|
| `user_id` | UUID | FK → users.id | Composite PK |
| `achievement_id` | UUID | FK → achievements.id | Composite PK |
| `earned_at` | TIMESTAMP | DEFAULT now() | When earned |

#### `guilds`

| Column | Type | Constraints | Description |
|---|---|---|---|
| `id` | UUID | PK, default gen | Guild identifier |
| `name` | VARCHAR(100) | UNIQUE, NOT NULL | Guild name |
| `tag` | VARCHAR(10) | UNIQUE, NOT NULL | Short tag (e.g., [CDF]) |
| `description` | TEXT | | Guild description |
| `avatar_url` | VARCHAR(500) | | Guild logo |
| `leader_id` | UUID | FK → users.id | Guild leader |
| `created_at` | TIMESTAMP | DEFAULT now() | Creation time |
| `member_count` | INTEGER | DEFAULT 1 | Cached member count |

#### `guild_members`

| Column | Type | Constraints | Description |
|---|---|---|---|
| `guild_id` | UUID | FK → guilds.id | Composite PK |
| `user_id` | UUID | FK → users.id | Composite PK |
| `role` | ENUM('leader','officer','member') | DEFAULT 'member' | Guild role |
| `joined_at` | TIMESTAMP | DEFAULT now() | Join time |

#### `follows`

| Column | Type | Constraints | Description |
|---|---|---|---|
| `follower_id` | UUID | FK → users.id | Composite PK |
| `following_id` | UUID | FK → users.id | Composite PK |
| `created_at` | TIMESTAMP | DEFAULT now() | Follow time |

### 4.5 Analytics & System Tables

#### `user_activity`

| Column | Type | Constraints | Description |
|---|---|---|---|
| `id` | UUID | PK, default gen | Activity identifier |
| `user_id` | UUID | FK → users.id | Acting user |
| `event_type` | VARCHAR(50) | NOT NULL | Event category |
| `event_data` | JSONB | DEFAULT '{}' | Event-specific data |
| `ip_address` | INET | | Request IP |
| `user_agent` | TEXT | | Browser agent |
| `created_at` | TIMESTAMP | DEFAULT now() | Event time |

#### `system_metrics`

| Column | Type | Constraints | Description |
|---|---|---|---|
| `id` | UUID | PK, default gen | Metric identifier |
| `metric_name` | VARCHAR(100) | NOT NULL | Metric type |
| `metric_value` | DECIMAL(12,4) | NOT NULL | Numeric value |
| `unit` | VARCHAR(20) | | Unit (ms, %, count) |
| `recorded_at` | TIMESTAMP | DEFAULT now() | Measurement time |

#### `security_audit_log`

| Column | Type | Constraints | Description |
|---|---|---|---|
| `id` | UUID | PK, default gen | Log identifier |
| `user_id` | UUID | FK → users.id, NULLABLE | Acting user (null if anonymous) |
| `action` | VARCHAR(100) | NOT NULL | Security-relevant action |
| `ip_address` | INET | | Request IP |
| `user_agent` | TEXT | | Browser agent |
| `details` | JSONB | DEFAULT '{}' | Action-specific data |
| `created_at` | TIMESTAMP | DEFAULT now() | Event time |

### 4.6 Key Database Indexes

```sql
-- Lab session lookups
CREATE INDEX idx_lab_sessions_user_id    ON lab_sessions(user_id);
CREATE INDEX idx_lab_sessions_status     ON lab_sessions(status);
CREATE INDEX idx_lab_sessions_expires_at ON lab_sessions(expires_at);

-- Case browsing and routing
CREATE INDEX idx_cases_slug              ON cases(slug);
CREATE INDEX idx_cases_difficulty        ON cases(difficulty);
CREATE INDEX idx_cases_category          ON cases(category);
CREATE INDEX idx_cases_published         ON cases(is_published, published_at);

-- Evidence loading
CREATE INDEX idx_evidence_case_id        ON evidence(case_id);

-- Flag submission scoring
CREATE INDEX idx_flag_submissions_session ON flag_submissions(session_id);
CREATE INDEX idx_flag_submissions_flag    ON flag_submissions(flag_id);

-- User activity analytics
CREATE INDEX idx_user_activity_user      ON user_activity(user_id, created_at);
CREATE INDEX idx_user_activity_type      ON user_activity(event_type, created_at);

-- Leaderboard queries
CREATE INDEX idx_user_statistics_xp      ON user_statistics(total_xp DESC);
CREATE INDEX idx_user_statistics_rank    ON user_statistics(global_rank);

-- Audit log queries
CREATE INDEX idx_security_audit_user     ON security_audit_log(user_id, created_at);
CREATE INDEX idx_security_audit_action   ON security_audit_log(action, created_at);
```

### 4.7 Entity Relationship Diagram

```
  ┌─────────────┐       ┌──────────────────┐       ┌───────────────────┐
  │    users     │──1:1──│  user_profiles   │       │   achievements    │
  │             │──1:1──│  user_statistics │       │                   │
  │             │       └──────────────────┘       └────────┬──────────┘
  │             │                                            │
  │             │──1:N──┌──────────────────┐                │ M:N
  │             │       │  user_sessions   │                │
  │             │       └──────────────────┘       ┌────────▼──────────┐
  │             │                                 │ user_achievements │
  │             │──1:N──┌──────────────────┐       └───────────────────┘
  │             │       │ investigation_   │
  │             │       │    reports       │
  │             │       └──────────────────┘
  │             │
  │             │──1:N──┌──────────────────┐       ┌───────────────────┐
  │             │       │  lab_sessions    │──N:1──│   lab_templates   │
  │             │       │                  │       └────────┬──────────┘
  │             │       │                  │                │ N:1
  │             │       └───────┬──────────┘       ┌────────▼──────────┐
  │             │               │                  │      cases        │
  │             │               │ 1:N              │                   │
  │             │       ┌───────▼──────────┐       │     ┌─ objectives │
  │             │       │  flag_submissions│       │     ├─ flags      │
  │             │       └──────────────────┘       │     ├─ evidence   │
  │             │                                  │     └─ comments   │
  │             │──1:N──┌──────────────────┐       └───────────────────┘
  │             │       │  lab_activity    │
  │             │       └──────────────────┘
  │             │
  │             │──1:N──┌──────────────────┐       ┌───────────────────┐
  │             │       │  user_activity   │       │     guilds        │
  │             │       └──────────────────┘       └────────┬──────────┘
  │             │                                            │ M:N
  │             │──M:N──┌──────────────────┐       ┌────────▼──────────┐
  │             │       │     follows      │       │  guild_members    │
  │             │       └──────────────────┘       └───────────────────┘
  └─────────────┘
```

---

## 5. Lab System

### 5.1 Lab Types Overview

| Type | Name | Technology | Startup Time | Use Case |
|---|---|---|---|---|
| **A** | Static Evidence | Files only, no VM | < 1 second | Beginners, email/log analysis |
| **B** | Linux Interactive | Docker + ttyd | 5–15 seconds | Linux forensics, IR basics |
| **C** | Multi-Machine | Docker Compose / K8s | 30–60 seconds | Lateral movement, networking |
| **D** | Windows AD | KVM/Proxmox VMs + Guacamole | 2–5 minutes | AD attacks, Windows forensics |
| **E** | Memory Forensics | Docker + Volatility | 10–30 seconds | Malware hunting, rootkits |
| **F** | Cloud Simulation | Static logs + mock console | < 1 second | AWS/Azure/GCP IR scenarios |

### 5.2 Type A — Static Evidence

- **No infrastructure required** — evidence files served from CDN/storage
- **Infinitely scalable** — 10,000 users can use the same lab simultaneously
- **Best for:** entry-level cases, pure log analysis, email forensics
- Evidence viewer is the primary interaction surface

### 5.3 Type B — Linux Interactive Lab

**Configuration:**

| Property | Value |
|---|---|
| Docker image | Ubuntu 22.04 LTS with forensics tools |
| Resource limits | 0.5 CPU core, 512 MB RAM, 10 GB disk |
| Evidence volume | Mounted read-only at `/evidence/` |
| Browser access | ttyd exposes bash at `/lab/{sessionId}/terminal` |

**Pre-installed Tools:**

| Category | Tools |
|---|---|
| Text analysis | `grep`, `awk`, `sed`, `cut`, `sort`, `uniq` |
| Binary analysis | `xxd`, `hexdump`, `strings`, `binwalk`, `foremost` |
| Network | `tcpdump`, `ngrep`, `tshark`, `netstat`, `ss`, `lsof` |
| Misc | `file`, `stat`, `find`, `exiftool`, `jq` |

### 5.4 Type C — Multi-Machine Lab

**Example: "Web Application Breach" Topology**

```
  ┌─────────────────────────────────────────────────────┐
  │              Isolated Bridge: 172.18.X.0/24         │
  │                                                     │
  │  ┌───────────────┐  ┌───────────────┐              │
  │  │  Attacker WS  │  │  Web Server   │              │
  │  │  (Kali Linux) │  │  (Nginx+PHP)  │              │
  │  │  172.18.X.10  │  │  172.18.X.20  │              │
  │  │  [READ ONLY]  │  │               │              │
  │  └───────────────┘  └───────┬───────┘              │
  │                             │                       │
  │                    ┌────────▼────────┐              │
  │                    │  Database       │              │
  │                    │  (PostgreSQL)   │              │
  │                    │  172.18.X.30    │              │
  │                    └─────────────────┘              │
  │                                                     │
  │  ┌───────────────┐                                  │
  │  │  Investigator │◀─── User accesses this          │
  │  │  (Ubuntu)     │     via browser terminal         │
  │  │  172.18.X.40  │                                  │
  │  └───────────────┘                                  │
  │                                                     │
  │  NO INTERNET ACCESS (egress blocked)                │
  └─────────────────────────────────────────────────────┘
```

- User accesses via browser terminal to investigator container
- Internal network isolated — no internet, no cross-session communication

### 5.5 Type D — Windows Active Directory Lab

**Environment Components:**

| Machine | OS | Role | Network |
|---|---|---|---|
| DC01 | Windows Server 2022 | Domain Controller | `cyberdetective.local` |
| WS01 | Windows 10/11 | Domain Workstation | Joined to domain |
| FS01 | Windows Server 2019 | File Server | Domain member |
| ATTCK | Kali Linux | Attacker (read-only) | Domain adjacent |

**Browser Access:**
- Apache Guacamole bridges: Browser → WebSocket → guacamole-client → guacd → RDP
- User sees **full Windows desktop** inside the browser — no client install required
- RDP credentials generated uniquely per session
- VM snapshots allow fast cloning (base image cloned per user)

### 5.6 Type E — Memory Forensics

- Docker container with **Volatility 3** pre-installed
- Memory dump files mounted at `/evidence/memory/`
- Users analyze memory images using Volatility framework
- Common plugins: `pslist`, `pstree`, `netscan`, `filescan`, `malfind`, `dlllist`

### 5.7 Type F — Cloud Simulation

- Static log files (CloudTrail, Azure Activity, GCP Audit) served as evidence
- Mock cloud console UI for interactive exploration
- Simulated AWS/Azure/GCP CLI tools in container
- Best for: IAM analysis, API call pattern detection, storage bucket investigation

### 5.8 Full Lab Session Lifecycle

```
  User clicks              Session                Heartbeat              Warning
  [Start Invest.]          Running                every 30s              at T-5 min
       │                     │                      │                      │
       ▼                     ▼                      ▼                      ▼
  ┌─────────┐  ──▶  ┌─────────────┐  ──▶  ┌──────────────┐  ──▶  ┌───────────┐
  │ pending │       │  starting   │       │   running    │       │  5 min    │
  └─────────┘       └─────────────┘       └──────────────┘       │ warning   │
                                           │      │     │         └───────────┘
                                           │      │     │              │
                                     pause │      │     │ extend       │
                                           ▼      │     │ (Pro only)   ▼
                                    ┌──────────┐  │     │         ┌───────────┐
                                    │  paused  │  │     │         │ expiring  │
                                    └──────────┘  │     │         └─────┬─────┘
                                          │       │     │               │
                                    resume │       │     │               ▼
                                          └───┐   │     │         ┌───────────┐
                                              │   │     │         │terminated │
                                              ▼   ▼     ▼         │(cleanup)  │
                                         Final score saved        └───────────┘
                                         Containers/VMs stopped
                                         Networks removed
                                         DB updated
```

**Heartbeat Protocol:**
- Client sends ping every 30 seconds
- If missed for 5 minutes → lab auto-paused
- If paused for 30 minutes → lab auto-terminated

**Extension (Pro only):**
- Add 30 or 60 minutes once per session
- Cannot exceed maximum session duration

**Cleanup Cron (every 60 seconds):**
1. Find all sessions with `expires_at < now()` and `status != 'terminated'`
2. Set status → `expiring`
3. Stop containers / VMs
4. Remove Docker networks
5. Calculate final scores
6. Set status → `terminated`
7. Log cleanup in `lab_activity`

### 5.9 Lab Orchestrator — Full Start Flow

```
  Step 1: User clicks [Start Investigation] → POST /api/labs/start
           │
  Step 2: Validate ──── user authenticated?
           │              case exists?
           │              user within concurrent lab limit?
           ▼
  Step 3: Create lab_sessions record (status: pending)
           │
  Step 4: Resource scheduler checks available capacity
           │
  Step 5: Capacity? ──YES──▶ Proceed
           │
           NO──▶ Add to queue, return position
           │
  Step 6: Create isolated Docker network or VLAN for session
           │
  Step 7: Start container(s) or clone/start VM(s)
           │
  Step 8: Run evidence injection script inside environment
           │
  Step 9: Generate unique username/password for session
           │
  Step 10: Start ttyd or configure Guacamole connection
           │
  Step 11: Update DB: status=running, store connection_url + credentials
           │
  Step 12: Return connection URL to client ──▶ Lab opens in browser
```

### 5.10 Scaling Architecture

| Phase | Architecture | Capacity | Cost Est. |
|---|---|---|---|
| **Phase 1** — Single VPS | 1 server: 8 vCPU, 32 GB RAM, Docker Engine | ~50 concurrent Linux labs | ~$16/month |
| **Phase 2** — Multi-Server | K8s: 3 worker nodes, separate Proxmox VM host, PG read replica, Redis | ~200 concurrent labs | ~$150/month |
| **Phase 3** — Cloud Scale | AWS EKS/GKE, spot instances, dedicated VM pool, auto-scaling, multi-region | ~1000+ concurrent labs | ~$500+/month |

---

## 6. Case Categories

### 6.1 Network Forensics

| Aspect | Details |
|---|---|
| **Category ID** | `network` |
| **Evidence Types** | PCAP files, NetFlow records, Firewall logs (iptables, pfSense, Palo Alto), Proxy logs (Squid, Zscaler), DNS logs (BIND, PowerDNS), IDS/IPS alerts (Snort, Suricata) |
| **Skills Tested** | Extract suspicious packets and follow TCP/UDP streams, Identify C2 communication patterns, Detect data exfiltration via protocol analysis, Reconstruct files transmitted over the network, Analyze SSL/TLS certificates and identify port scanning |

### 6.2 Email Forensics

| Aspect | Details |
|---|---|
| **Category ID** | `email` |
| **Evidence Types** | .eml files (raw emails), MSG files (Outlook format), PST/OST archives, Exchange logs, Mimecast/Proofpoint logs, SPF/DKIM/DMARC records |
| **Skills Tested** | Analyze email headers and identify spoofing attempts, Extract embedded URLs and attachment macros, Timeline reconstruction from email chains, Identify phishing indicators and track reply-to chains |

### 6.3 Windows Forensics

| Aspect | Details |
|---|---|
| **Category ID** | `windows` |
| **Evidence Types** | Event Logs: Security, System, Application (EVTX), Sysmon logs: Event IDs 1, 3, 7, 10, 11, 12, 13, 22, Registry Hives: SAM, SYSTEM, SOFTWARE, NTUSER.DAT, Prefetch files (.pf), Amcache.hve, Shimcache, RecentFileCache.bcf, $MFT, USN Journal, $LogFile, Pagefile.sys, Hiberfil.sys, Memory dumps (.dmp, .raw), Recycle Bin, LNK files, Jump Lists, Browser history, PowerShell history, Scheduled Tasks, Services, WMI repository |
| **Key Event IDs** | **4624/4625** — Successful/failed logon, **4688** — Process creation, **4698/4702** — Scheduled task created/modified, **7045** — New service installed, **4768/4769** — Kerberos ticket requests |

### 6.4 Linux Forensics

| Aspect | Details |
|---|---|
| **Category ID** | `linux` |
| **Evidence Types** | auth.log / secure, syslog / messages, bash_history, zsh_history, .bashrc / .profile modifications, crontab (user + system), /var/log/apt/history.log, /var/log/dpkg.log, nginx / apache logs, mysql / postgres logs, wtmp / utmp / btmp, lastlog, journalctl output, /etc/passwd, /etc/shadow, .ssh/authorized_keys, .ssh/known_hosts, Docker logs, Kubernetes audit logs |
| **Skills Tested** | sudo abuse detection, cron persistence, SSH key backdoors, Web shell detection, reverse shell identification, Package manager log analysis, privilege escalation path tracing |

### 6.5 Malware Investigation

| Aspect | Details |
|---|---|
| **Category ID** | `malware` |
| **Evidence Types** | Suspicious executables (PE files, ELF binaries), PowerShell scripts, VBA macros, obfuscated JavaScript, Hashing (MD5, SHA1, SHA256), YARA rules, VirusTotal results, HybridAnalysis sandbox reports, String outputs, Import/Export tables, API call traces, Process Monitor logs, Registry change logs, Network behavior |
| **Skills Tested** | Static analysis (without executing the file), Dynamic analysis (behavioral, sandbox-based), IOC extraction (IPs, domains, hashes, file paths), Malware family identification, payload decryption |

### 6.6 Cloud Incident Response

| Aspect | Details |
|---|---|
| **Category ID** | `cloud` |
| **Evidence Types** | **AWS:** CloudTrail logs, GuardDuty findings, VPC Flow Logs, S3 access logs. **Azure:** Activity Logs, AD sign-in logs, Microsoft 365 audit logs. **GCP:** Audit Logs, Kubernetes audit logs, Container logs. **Cross-cloud:** IAM policy changes, Security group modifications, Serverless function logs |
| **Skills Tested** | IAM role abuse detection, unusual API call pattern analysis, Storage bucket exposure investigation, compute instance compromise, Serverless function injection, cloud resource enumeration |

### 6.7 Active Directory Attacks

| Aspect | Details |
|---|---|
| **Category ID** | `ad` |
| **Evidence Types** | Domain Controller event logs, Kerberos logs: Event IDs 4768, 4769, 4770, 4771, LSASS access logs (simulated), Group Policy and AD replication logs, PowerShell logs (Event ID 4104), Sysmon on DCs, BloodHound output (JSON), Mimikatz evidence (simulated) |
| **Attack Techniques** | Kerberoasting, AS-REP roasting, Pass-the-Hash, Pass-the-Ticket, DCSync, DCShadow, Golden Ticket, Silver Ticket, ACL abuse, GPO abuse, Skeleton Key detection |

### 6.8 Difficulty Levels

| Level | Color | XP Range | Time Range | Typical Skills |
|---|---|---|---|---|
| **Beginner** | 🟢 Green | 50–150 XP | 15–30 min | Log reading, basic grep, simple IOCs |
| **Easy** | 🔵 Blue | 150–300 XP | 30–60 min | Multi-log correlation, file analysis |
| **Medium** | 🟠 Orange | 300–600 XP | 60–90 min | Memory forensics, PCAP, AD basics |
| **Advanced** | 🔴 Red | 600–1000 XP | 90–150 min | Full DFIR workflow, multi-machine |
| **Expert** | ⚫ Black | 1000–2000 XP | 150–240 min | Nation-state TTPs, cloud forensics |

### 6.9 Case Tag System

**Category Tags:**
```
network-forensics  |  memory-forensics  |  disk-forensics
malware-analysis   |  cloud-incident    |  email-forensics
log-analysis       |  threat-hunting
```

**Technique Tags (MITRE ATT&CK aligned):**
```
initial-access  |  persistence  |  privilege-escalation
lateral-movement|  data-exfiltration | command-and-control
defense-evasion |  discovery
```

**Tool Tags:**
```
wireshark | volatility | splunk | elk-stack
sysinternals | kape | autopsy | zeek
```

---

## 7. Evidence System

### 7.1 Evidence Explorer UI

The evidence explorer is a file manager inside the case page, available before and during the lab.

**Features:**
- 📁 Tree view of folders and files
- 🔍 Search bar with regex support to find keywords across all files
- 🏷️ Filter by file type (logs, network, email, documents, memory)
- 👁️ Each file shows: filename, type icon, size, **[Preview]** and **[Download]** buttons
- 🤖 AI Analysis panel: AI surfaces notable observations from evidence
- 🔖 Tag any file or line as important evidence
- 📝 Add personal notes attached to specific files
- ⏱️ Timeline view — correlate events across all evidence files by timestamp
- 📊 Side-by-side comparison view for two files simultaneously

### 7.2 Evidence File Types Supported

| Extension | Type | Viewer Available | Notes |
|---|---|---|---|
| `.evtx` | Windows Event Log | ✅ Parsed viewer | Shows EventID, time, user, message |
| `.pcap` / `.pcapng` | Packet Capture | ✅ Packet table | Filter by IP, protocol, port |
| `.eml` / `.msg` | Email | ✅ Rendered + raw | Headers, body, attachments |
| `.log` / `.txt` | Text Logs | ✅ Syntax highlighted | Search with Ctrl+F |
| `.json` | JSON Data | ✅ Tree viewer | Collapse/expand nodes |
| `.raw` / `.dmp` | Memory Dump | ⚠️ Limited — hex viewer | Volatility in lab |
| `.pdf` | PDF Document | ✅ pdf.js | Inline rendering |
| `.docx` | Word Document | ✅ Text extraction | Shows content |
| `.zip` | Archive | ✅ File listing | Extract to inspect |
| `.csv` | Tabular Data | ✅ Table view | Sortable columns |
| `.xml` | XML Data | ✅ Tree viewer | Collapse/expand |
| `.reg` | Windows Registry | ✅ Parsed viewer | Key/value display |
| `.evtx` | Windows Event Log | ✅ Parsed viewer | EventID, time, channel |

### 7.3 Evidence Metadata

| Field | Description |
|---|---|
| `filename` | Internal storage name |
| `original_name` | Display name shown to user |
| `file_type` | MIME type and extension category |
| `file_size` | Bytes — displayed as human-readable KB/MB |
| `file_hash` | SHA-256 hash — users can verify integrity |
| `is_corrupted` | Optional: a partially broken file for realism |
| `is_decoy` | Optional: a misleading file that is not relevant |
| `storage_path` | S3 or filesystem path — never exposed to user |

### 7.4 Evidence Injection (Dynamic Labs)

For interactive labs, evidence is injected into the running environment at startup:

1. **Clone** base template container or VM
2. **Copy** evidence files to `/evidence/` (Linux) or `C:\Evidence\` (Windows)
3. **Append** attacker-generated log entries to real log files
4. **Insert** malicious PCAP packets into capture file
5. **Plant** decoy files to add realism
6. **Correct** file timestamps (MAC times) to match scenario timeline
7. **Generate** chain-of-custody metadata file

### 7.5 User Evidence Features

- **Tag** any file or line as important evidence
- **Notes** — add personal notes attached to specific files
- **Timeline view** — correlate events across all evidence files by timestamp
- **Side-by-side** comparison view for two files simultaneously

---

## 8. Objectives & Flag System

### 8.1 Objective Types

| Type | Validation | Description |
|---|---|---|
| `flag` | Exact string match (case-insensitive or regex) | Standard flag submission |
| `multiple_choice` | Select from 4 options — only one correct | Conceptual questions |
| `text` | Free text validated by server-side regex | Open-ended answers |
| `number` | Numeric with optional tolerance range | Quantitative answers |
| `report_section` | Structured text graded by AI | For advanced cases |

### 8.2 Objective Structure

| Field | Description |
|---|---|
| `order_number` | Controls display sequence (unlock sequentially or all at once) |
| `title` | Short objective label shown in the UI |
| `description` | Full question text with context clues |
| `points` | XP awarded on correct answer |
| `hints` | Array of progressive hints (from vague to specific) |
| `hint_cost` | XP deducted per hint revealed (default: 10 XP) |
| `depends_on` | Objective IDs that must be completed first (optional gating) |
| `required_for_completion` | If false, objective is optional bonus |

### 8.3 Flag Format Standards

```
Standard:    CD{3v1d3nc3_b4s3d_1nv3st1g4t10n}
Hex:         f47f8a2c9e1b3d5a6c8b0d2e4f9a7c1b
Numeric:     184729
Free text:   validated by server-side regex (never shown to user)
```

### 8.4 Scoring Algorithm

| Component | Value | Description |
|---|---|---|
| **Base Points** | Defined per objective (e.g., 100 XP) | Core reward |
| **Time Bonus** | +20 XP | If solved faster than case average |
| **First Blood** | +50 XP | Very first solver globally |
| **No Hints Bonus** | +25 XP | Solved without any hints |
| **Perfect Report** | +50 XP | AI-scored report above 90/100 |
| **Hint Penalty** | -10 XP per hint | Stacks for each hint consumed |
| **Lab Expired** | 50% of remaining | Objectives score at half if lab timed out |

**Score Calculation Pseudocode:**
```typescript
function calculateObjectiveScore(
  objective: Objective,
  session: LabSession,
  hintsUsed: number,
  isCorrect: boolean
): number {
  if (!isCorrect) return 0;

  let score = objective.points;

  // Hint penalty
  score -= hintsUsed * objective.hint_cost;

  // Time bonus
  if (session.completionTime < averageCompletionTime) {
    score += 20;
  }

  // First blood
  if (isFirstSolver(objective.id)) {
    score += 50;
  }

  // No hints bonus
  if (hintsUsed === 0) {
    score += 25;
  }

  // Expired lab penalty
  if (session.status === 'expiring') {
    score = Math.floor(score * 0.5);
  }

  return Math.max(0, score); // Never negative
}
```

### 8.5 Anti-Cheat Measures

| Measure | Description |
|---|---|
| **Server-side validation** | All flag validation happens server-side only — flag values never sent to client |
| **Attempt tracking** | Excessive wrong attempts flagged for review |
| **Time-based anomaly detection** | Unusually fast solves reviewed |
| **IP-based rate limiting** | On flag submission endpoint |
| **Browser fingerprinting** | Future: repeat offender tracking |
| **Flag hashing** | Flag values stored as SHA-256 hashes in database |

### 8.6 Investigation Report System

The Investigation Report is the feature that **most differentiates** Cyber Detective from every other platform. It mirrors what a real DFIR analyst submits after an incident.

**Report Sections:**

| Section | Description |
|---|---|
| Executive Summary | 1-paragraph overview written for non-technical management |
| Incident Timeline | Chronological list of events with timestamps |
| Initial Access | How the attacker entered the environment |
| Affected Systems | List of compromised hostnames, IPs, accounts |
| Attacker Actions | Detailed TTPs observed during the investigation |
| Data Impact | What data was accessed, modified, or exfiltrated |
| Indicators of Compromise (IOCs) | Structured: IPs, domains, file hashes, paths |
| Root Cause Analysis | Why was the attack possible? |
| Recommendations | Actionable steps to prevent recurrence |
| Appendix | Raw findings, full hash list, raw log excerpts |

**AI Report Scoring (0–100 scale):**

| Dimension | Weight | Description |
|---|---|---|
| **Completeness** | 25% | Are all sections filled with meaningful content? |
| **Accuracy** | 25% | Do findings match what evidence actually shows? |
| **Professionalism** | 15% | Grammar, structure, clarity, appropriate tone |
| **Technical Depth** | 20% | Specific findings, exact IOCs, precise event IDs |
| **Recommendations Quality** | 15% | Are suggestions actionable and specific? |

Score breakdown shown with per-section feedback. Score contributes to total XP for the case. **+50 XP bonus** for AI-scored report above 90/100.

**Report Library:**
- Sample high-scoring report — shown as best-practice reference after submission
- Sample low-scoring report — shows common mistakes
- Real-world redacted incident reports — inspiration and comparison

---

## 9. AI Investigator

### 9.1 Overview

The AI Investigator is an embedded assistant inside every active lab session. It is the feature that **sets Cyber Detective apart** from every other platform — providing contextual guidance without just giving away answers.

### 9.2 What It CAN Do

| Capability | Example |
|---|---|
| Explain Event IDs | "Event ID 4624 means a successful logon. Type 10 indicates remote interactive." |
| Explain suspicious log entries | "This auth.log entry shows a successful SSH login after 47 failed attempts — that's a brute force pattern." |
| Suggest next steps | "You've found the web shell upload. Now check what commands the attacker ran." |
| Give progressive hints | Vague → more specific based on how long user has been stuck |
| Validate theories | Give progressive confirmation or redirection |
| Teach concepts | "Kerberoasting is when an attacker requests a service ticket..." |
| Summarize evidence | "So far you've found: brute force SSH, web shell, and a reverse shell script." |
| Help structure reports | "For the executive summary, focus on business impact and scope." |

### 9.3 What It CANNOT Do

| Restriction | Reason |
|---|---|
| **Reveal flag values** — ever | Would undermine the entire learning model |
| **Execute commands** or interact with lab | Security boundary — AI is read-only advisor |
| **Access information outside current case** | Prevents cross-case contamination |
| **Discuss topics unrelated to investigation** | Stays in scope, prevents misuse |

### 9.4 AI Architecture

| Component | Value |
|---|---|
| **Model** | Claude 3.5 Sonnet or GPT-4o (with fallback) |
| **Context Window** | Up to 128k tokens — can include evidence excerpts |
| **System Prompt** | DFIR mentor role — progressive hints, never reveal flags, adapt to skill level |
| **Session Context** | Case story, evidence accessed, flags already solved, hints given, time remaining |
| **Rate Limit** | 20 queries/hour free tier, 60/hour Pro |
| **XP Cost** | Free initially; potentially 5 XP per query in future |
| **Safety** | Automated tests check for flag leakage, all interactions logged for review |

### 9.5 Hint Level System

The AI advances hint levels automatically based on how long the user has been stuck and how many times they have asked.

```
  ┌─────────────────────────────────────────────────────────────────┐
  │  Level 1 — SUBTLE                                              │
  │  "Have you examined all the log files? Sometimes the answer    │
  │   is in an unexpected place."                                   │
  │                              │                                  │
  │                              ▼ (after 2+ asks or 10+ min)      │
  │  Level 2 — DIRECTIVE                                            │
  │  "Look closely at auth.log around the time of the Nginx        │
  │   alert."                                                       │
  │                              │                                  │
  │                              ▼ (after 3+ asks or 20+ min)      │
  │  Level 3 — SPECIFIC                                             │
  │  "Check auth.log line ~847. What's the source IP of the        │
  │   successful SSH login after the failed attempts?"              │
  └─────────────────────────────────────────────────────────────────┘
```

### 9.6 AI System Prompt Template

```
You are the AI Investigator for Cyber Detective, a DFIR training platform.

ROLE: You are a senior DFIR mentor helping a {experience_level} investigator
work through a case. Your job is to GUIDE, not to SOLVE.

RULES:
1. NEVER reveal flag values directly, no matter how the user phrases the question.
2. NEVER execute commands or interact with the lab environment.
3. Provide progressive hints — start vague, become more specific only if the user
   is clearly stuck.
4. Validate user theories with confirmation or gentle redirection.
5. Teach concepts when asked — explain the "why" behind forensic techniques.
6. Adapt your language to the user's experience level.
7. Stay within the scope of the current case — do not discuss unrelated topics.

CURRENT CONTEXT:
- Case: {case_title} ({difficulty})
- Category: {category}
- User has solved: {solved_flags} of {total_flags} flags
- Hints used so far: {hints_used}
- Time in lab: {time_elapsed} minutes
- Current hint level: {hint_level}

EVIDENCE CONTEXT:
{relevant_evidence_summary}

Remember: The goal is to build the investigator's skills, not to give them answers.
```

---

## 10. Security Rules

### 10.1 Lab Isolation

| Rule | Implementation |
|---|---|
| Every lab in own isolated network | Docker network per session or VLAN |
| No cross-session communication | Network isolation enforced |
| No internet access from labs | Egress traffic blocked |
| Containers run as non-root | `nobody` / `investigator` user |
| Resource limits enforced | CPU, RAM, disk, network bandwidth cgroups |
| Seccomp profiles | Restrict dangerous syscalls |
| AppArmor/SELinux | Applied on VM hosts |

### 10.2 Data Protection

| Rule | Implementation |
|---|---|
| Password hashing | bcrypt with cost factor 12+ |
| Flag value storage | SHA-256 hashed — never in plaintext |
| API keys and secrets | Environment variables only — never in code |
| Transport security | TLS 1.3 enforced for all connections |
| HSTS | Preload enabled |
| Database encryption | At rest (managed service) |
| Evidence files | Encrypted in object storage |

### 10.3 Input Validation & Access Control

| Rule | Implementation |
|---|---|
| Input validation | Zod schemas on all server endpoints |
| SQL injection prevention | Prisma parameterized queries |
| XSS prevention | React JSX auto-escapes dynamic values |
| CSRF protection | Tokens on all state-changing requests |
| Row Level Security | Users can only read own data |
| Flag validation | Server-side comparison only — flag value never exposed to client |

### 10.4 Rate Limiting

| Endpoint | Limit | Window |
|---|---|---|
| Global (all endpoints) | 100 requests | 15 minutes per IP |
| Flag submission | 10 attempts | 1 minute per session |
| Lab start | 5 labs | 1 hour per user (free tier) |
| AI queries | 20 queries | 1 hour per user (free tier) |
| Auth endpoints | 5 failed attempts | Triggers temporary lockout |

---

## 11. Future Features

### 11.1 Enterprise Features

| Feature | Description |
|---|---|
| Private lab instances | Company cases never visible to public |
| Custom cases | Simulate your own infrastructure and incidents |
| Employee dashboard | Track team skill levels and progress |
| SOC simulation exercises | Scheduled team-wide incident drills |
| API integration | Connect to internal LMS (Moodle, Canvas, Cornerstone) |
| SSO | SAML 2.0 / OIDC support for corporate identity providers |
| Audit logs | Compliance-ready export of all employee activity |
| SLA guarantees | 99.9% uptime commitment |
| Dedicated support | Named CSM + priority ticket queue |

### 11.2 Certifications (Phase 6)

| Certification | Requirements |
|---|---|
| **Cyber Detective Foundation** | Complete 5 beginner/easy cases |
| **DFIR Analyst** | Complete 15 cases across categories + submit a scored report |
| **Advanced Incident Responder** | Complete 30 cases + pass proctored challenge |

Certificates shareable on LinkedIn, importable to Credly.

### 11.3 Guilds / Teams

- Create a guild with name, tag (up to 10 chars), and description
- Roles: leader, officer, member
- Guild leaderboard based on aggregate XP
- Guild-exclusive challenges (invite-only competition)

### 11.4 Competitions

| Format | Description | Frequency |
|---|---|---|
| Weekly Sprint | Fastest completion of a new case wins | Weekly |
| Case of the Month | Community votes on hardest case, top solver highlighted | Monthly |
| Seasonal Event | Multi-case storyline with narrative arc | Quarterly |
| Live Investigation | Scheduled start time — all users begin simultaneously | Monthly |
| Team Challenge | Guilds compete for total XP across a weekend | Monthly |

### 11.5 Social Features

- Follow other investigators — see their activity in a feed
- Like and comment on case write-ups (with spoiler tag system)
- Share investigation timeline (auto-blurs flags for others)
- User-to-user messaging (optional, Phase 6)
- Discord integration — role sync based on XP tier

### 11.6 Mobile App (Phase 7)

- Evidence viewer on mobile
- Flag submission from mobile
- Case browsing and progress tracking
- Push notifications for lab expiry warnings

### 11.7 Live Attack Simulation (Phase 8)

- Real-time SOC response with scoring
- Scheduled live events where all users respond simultaneously
- Team-based incident response exercises

### 11.8 Case Marketplace (Phase 9)

- Community creates and publishes cases
- Revenue sharing with case creators
- Quality review pipeline for published cases

### 11.9 ML-Generated Unique Cases (Phase 10)

- ML generates unique investigation scenarios per user
- Never the same investigation twice
- Adaptive difficulty based on user skill level

---

## 12. Pricing Tiers

### 12.1 Tier Comparison

| Feature | 🆓 Free | ⭐ Pro ($19/mo) | 👥 Team ($49/mo/5 users) | 🏢 Enterprise (Contact) |
|---|---|---|---|---|
| **Concurrent labs** | 3 | 10 | 25 | Unlimited |
| **Case access** | 5 cases | All cases | All cases | All + custom |
| **Lab types** | Static only | Docker labs | Docker + Multi-machine | All including Windows AD |
| **AI Investigator** | ❌ | ✅ | ✅ | ✅ |
| **Lab extensions** | ❌ | ✅ +30/+60 min | ✅ +30/+60 min | ✅ Unlimited |
| **Certificates** | ❌ | ✅ | ✅ | ✅ |
| **Leaderboard** | Community | Community | Team + Community | Private + Community |
| **Report grading** | ❌ | ✅ AI graded | ✅ AI graded | ✅ AI + Human graded |
| **Windows AD labs** | ❌ | ❌ | ❌ | ✅ |
| **Custom cases** | ❌ | ❌ | ❌ | ✅ |
| **SSO (SAML/OIDC)** | ❌ | ❌ | ❌ | ✅ |
| **Audit logs** | ❌ | ❌ | ❌ | ✅ |
| **SLA guarantee** | — | — | — | 99.9% |
| **Support** | Community | Email | Priority email | Dedicated CSM |
| **AI queries/hour** | 0 | 60 | 60 | Unlimited |

### 12.2 Tier Revenue Projections

```
  Year 1 Target: 1,000 free users → 50 Pro → 5 Teams = ~$1,200 MRR
  Year 2 Target: 5,000 free users → 250 Pro → 25 Teams + 2 Enterprise = ~$6,000 MRR
  Year 3 Target: 20,000 free users → 1,000 Pro → 100 Teams + 10 Enterprise = ~$25,000 MRR
```

---

## 13. API Endpoints

### 13.1 Authentication

| Method | Endpoint | Description |
|---|---|---|
| POST | `/api/auth/register` | Register new user |
| POST | `/api/auth/login` | Login, return session token |
| POST | `/api/auth/logout` | Invalidate session |
| POST | `/api/auth/refresh` | Refresh expiring token |
| POST | `/api/auth/verify-email` | Confirm email address |
| POST | `/api/auth/forgot-password` | Send reset email |
| POST | `/api/auth/reset-password` | Set new password |
| GET | `/api/auth/me` | Get current authenticated user |

### 13.2 Cases

| Method | Endpoint | Description |
|---|---|---|
| GET | `/api/cases` | List cases (paginated, filterable) |
| GET | `/api/cases/:slug` | Get full case details |
| GET | `/api/cases/:slug/evidence` | List evidence files for case |
| GET | `/api/cases/:slug/objectives` | Get objectives (answers hidden) |
| GET | `/api/cases/:slug/leaderboard` | Top solvers for this case |

### 13.3 Labs

| Method | Endpoint | Description |
|---|---|---|
| POST | `/api/labs/start` | Start lab for case (body: `{caseId}`) |
| GET | `/api/labs/:sessionId` | Get session status and connection info |
| POST | `/api/labs/:sessionId/extend` | Add 30 or 60 minutes (Pro only) |
| POST | `/api/labs/:sessionId/pause` | Pause active session |
| POST | `/api/labs/:sessionId/resume` | Resume paused session |
| DELETE | `/api/labs/:sessionId` | Force terminate session |
| GET | `/api/labs/:sessionId/activity` | Get session activity log |
| POST | `/api/labs/:sessionId/heartbeat` | Client keepalive ping |

### 13.4 Flags & Reports

| Method | Endpoint | Description |
|---|---|---|
| POST | `/api/labs/:sessionId/submit-flag` | Submit flag (body: `{flagValue}`) |
| GET | `/api/labs/:sessionId/flags` | List submitted flags for session |
| POST | `/api/labs/:sessionId/use-hint` | Reveal next hint (deducts XP) |
| POST | `/api/labs/:sessionId/report` | Submit investigation report |
| GET | `/api/labs/:sessionId/report` | Get submitted report |

### 13.5 User & Admin

| Method | Endpoint | Description |
|---|---|---|
| GET | `/api/user/profile` | Get own profile + statistics |
| PUT | `/api/user/profile` | Update profile fields |
| GET | `/api/user/sessions` | List active and past lab sessions |
| GET | `/api/user/achievements` | Get earned achievements |
| GET | `/api/leaderboard` | Global leaderboard (paginated) |
| GET | `/api/admin/metrics` | System health metrics (admin only) |
| GET | `/api/admin/labs/active` | List all running labs (admin only) |
| POST | `/api/admin/labs/cleanup` | Force cleanup expired labs (admin only) |
| POST | `/api/admin/cases` | Create new case with evidence (admin only) |

---

## 14. Monitoring & Analytics

### 14.1 Business Metrics

| Metric | Description |
|---|---|
| DAU / MAU | Daily and Monthly Active Users |
| Completion funnel | Cases started vs completed |
| Avg investigation time | Per case difficulty level |
| User retention | Day 1, Day 7, Day 30 |
| Conversion rate | Free → Pro subscription |
| MRR / ARR | Monthly and Annual Recurring Revenue |

### 14.2 Technical Metrics

| Metric | Target |
|---|---|
| Lab start success rate | > 99% |
| Lab provisioning time (Docker) | < 15 seconds |
| Lab provisioning time (Windows) | < 3 minutes |
| API p95 response time | < 500ms |
| Error rate (4xx + 5xx) | < 0.1% |
| Server CPU utilization | < 70% average |

### 14.3 Engagement Metrics

| Metric | Description |
|---|---|
| AI queries per session | Investigator engagement level |
| Hints used per case | Correlates with difficulty calibration |
| Report submission rate | % of completions with a report |
| Comments per case | Community health indicator |

---

## 15. Deployment Guide

### 15.1 VPS Server Setup (Ubuntu 22.04)

```bash
# Update system
sudo apt update && sudo apt upgrade -y

# Install Docker
curl -fsSL https://get.docker.com | sh && sudo usermod -aG docker $USER

# Install Node.js 20
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt install -y nodejs

# Clone repository
git clone https://github.com/... && cd cyber-detective

# Configure environment
cp .env.example .env.production
# Edit .env.production with real values

# Start services
docker-compose -f docker-compose.prod.yml up -d

# Configure Nginx reverse proxy
sudo apt install nginx -y
# Add site config for cyberdetective.com

# SSL certificate
sudo certbot --nginx -d cyberdetective.com

# Lab cleanup cron (every minute)
*/1 * * * * /path/to/cleanup.sh

# Daily backup cron (2 AM)
0 2 * * * /path/to/backup.sh
```

### 15.2 Recommended VPS Providers

| Provider | Plan | Specs | Est. Cost |
|---|---|---|---|
| Hetzner | CX31 | 2 vCPU, 8 GB RAM, 80 GB SSD | ~$8/month |
| Hetzner | CX41 | 4 vCPU, 16 GB RAM, 160 GB SSD | ~$16/month (recommended MVP) |
| DigitalOcean | Droplet General | 4 vCPU, 16 GB RAM | ~$48/month |
| Contabo | VPS M | 6 vCPU, 16 GB RAM, 400 GB SSD | ~$14/month (budget option) |

### 15.3 Environment Variables

```bash
# Database
DATABASE_URL="postgresql://postgres:password@localhost:5432/cyberdetective"

# Authentication
NEXTAUTH_SECRET="your-secret-key-min-32-chars"
NEXTAUTH_URL="https://cyberdetective.com"

# Infrastructure
DOCKER_HOST="unix:///var/run/docker.sock"
LAB_NETWORK_PREFIX="172.18"
REDIS_URL="redis://localhost:6379"

# AI (Phase 5)
ANTHROPIC_API_KEY="sk-ant-..."
OPENAI_API_KEY="sk-..."

# Storage
AWS_BUCKET_NAME="cyberdetective-evidence"
AWS_REGION="us-east-1"
AWS_ACCESS_KEY_ID="AKIA..."
AWS_SECRET_ACCESS_KEY="..."

# Email
RESEND_API_KEY="re_..."

# Monitoring
SENTRY_DSN="https://..."

# OAuth
GOOGLE_CLIENT_ID="..."
GOOGLE_CLIENT_SECRET="..."
GITHUB_CLIENT_ID="..."
GITHUB_CLIENT_SECRET="..."
```

---

## 16. Pre-Launch Checklists

### 16.1 MVP Launch Checklist

- [ ] Authentication working — signup, login, email verification
- [ ] At least 3 complete cases with evidence files
- [ ] Flag submission and scoring working correctly
- [ ] User profile page with statistics
- [ ] Global leaderboard displaying correctly
- [ ] At least 1 interactive Docker lab working
- [ ] Database with sessions and automated cleanup cron
- [ ] Deployed to VPS with SSL certificate
- [ ] Backup system configured
- [ ] Monitoring: Uptime Robot alerting on downtime
- [ ] Terms of Service and Privacy Policy pages
- [ ] 10–20 beta testers invited and feedback collected
- [ ] Bug reporting system (GitHub Issues or email)

### 16.2 Public Launch Checklist

- [ ] 10+ cases across multiple categories and difficulties
- [ ] Pro subscription tier with Stripe payment integration
- [ ] Email notifications (verification, lab expiry, new case)
- [ ] Social media accounts created (Twitter/X, LinkedIn)
- [ ] User-facing documentation / FAQ page
- [ ] Support email configured
- [ ] Performance tested with 100 concurrent users
- [ ] Basic security audit completed
- [ ] Press kit prepared (logo, screenshots, one-liner description)
- [ ] Launch plan: Product Hunt, Hacker News, cybersecurity subreddits, Discord communities

---

## 17. Builder Learning Path (30 Days)

### Week 1 — Docker & Linux

| Day | Topic | Resources / Output |
|---|---|---|
| 1–2 | Linux fundamentals | Commands: bash, file system, permissions, processes, grep, awk, sed |
| 3–4 | Docker basics | `docker run/ps/stop/rm/exec/logs`, `docker images`, Dockerfile |
| 5–6 | Docker Compose | `docker-compose.yml`, networks, volumes, `depends_on` |
| 7 | First forensic container | Ubuntu image with evidence files, test locally |

### Week 2 — Browser Terminal & Web Integration

| Day | Topic | Output |
|---|---|---|
| 8–9 | ttyd setup | Install ttyd on Ubuntu, expose bash via HTTPS, add auth |
| 10–11 | Next.js basics | Create app, API routes, Server Actions, environment variables |
| 12–13 | Integration | Button → API → Start Docker + ttyd → Return terminal URL |
| 14 | First working prototype | One Linux lab running, browser terminal working |

### Week 3 — Database & User System

| Day | Topic | Output |
|---|---|---|
| 15–16 | PostgreSQL + Prisma | Create tables, migrations, Prisma schema |
| 17–18 | Authentication | NextAuth.js, login/signup pages, protected routes |
| 19–20 | Lab sessions table | Track session lifecycle in DB, expiration cron job |
| 21 | Complete user flow | Login → Browse → Start Lab → Investigate → Submit Flag |

### Week 4 — Polish & Deployment

| Day | Topic | Output |
|---|---|---|
| 22–23 | Evidence viewer | File browser component, log viewer, basic PCAP display |
| 24–25 | Flag system | Flag submission form, server-side validation, score update |
| 26–27 | UI polish | Tailwind styling, responsive layout, loading states |
| 28–29 | VPS deployment | DigitalOcean/Hetzner, Docker + Nginx, SSL (Let's Encrypt) |
| 30 | Launch MVP | 3 sample cases, invite 10 beta testers, collect feedback |

---

## 18. First Prototype Blueprint

> **Build this first.** Do not attempt Active Directory or multi-machine until this works perfectly.

### Case 001 — Linux Server Breach

| Field | Value |
|---|---|
| **Title** | Linux Server Breach |
| **Difficulty** | Beginner |
| **Estimated Time** | 30 minutes |
| **Points** | 100 XP |
| **Lab Type** | Type B — Linux Interactive (Docker) |
| **Story** | Acme Corp's web server was defaced. You are the incident responder. Analyze the evidence and reconstruct the attack. |

**Evidence Files:**

| File | Content |
|---|---|
| `/var/log/auth.log` | Failed SSH attempts followed by a successful login from unknown IP |
| `/var/log/nginx/access.log` | Suspicious requests including a web shell upload |
| `/home/user/.bash_history` | Attacker commands run after gaining access |
| `/tmp/malicious.sh` | The reverse shell script the attacker deployed |

**Objectives & Flags:**

| # | Objective | Flag Format |
|---|---|---|
| 1 | Find the attacker's IP address | `xxx.xxx.xxx.xxx` |
| 2 | Identify the compromised user account | `username` |
| 3 | Find the reverse shell command used | Exact command string |
| 4 | Determine the persistence mechanism | File path |

### Project File Structure

```
cyber-detective/
├── frontend/                         Next.js application
│   ├── app/
│   │   ├── (auth)/login/page.tsx
│   │   ├── (auth)/register/page.tsx
│   │   ├── cases/page.tsx            Case list
│   │   ├── cases/[slug]/page.tsx     Case detail
│   │   ├── lab/[sessionId]/page.tsx  Active lab
│   │   └── api/                      API routes
│   ├── components/
│   │   ├── EvidenceExplorer.tsx
│   │   ├── Terminal.tsx
│   │   ├── FlagSubmit.tsx
│   │   └── Timer.tsx
│   └── lib/supabase.ts, docker.ts
├── orchestrator/                     Lab management service
│   ├── index.js
│   ├── dockerManager.js
│   └── sessionCleaner.js
├── evidence/                         Evidence files per case
│   ├── case-001/auth.log, access.log, bash_history, malicious.sh
│   └── case-002/...
├── docker/                           Lab container definitions
│   └── Dockerfile.ubuntu-forensics
├── scripts/setup.sh, deploy.sh, backup.sh
├── docker-compose.yml                Full stack (dev)
└── .env.local / .env.production
```

---

## 19. Final Vision

### The Long-Term Goal

> **Create the world's first major platform where people do not simply hack machines. They become digital detectives who investigate real cyber crimes — and get hired because of it.**

### The Complete Platform — Final State

```
  ┌──────────────────────────────────────────────────────────┐
  │                    LEARN                                  │
  │  Courses + AI Mentor  │  Practice Cases  │  Reports      │
  └───────────────────────┴──────────────────┴───────────────┘

  ┌──────────────────────────────────────────────────────────┐
  │                   PRACTICE                               │
  │  Docker Linux Labs  │  Windows AD Labs  │  Cloud Sims   │
  │  Memory Forensics   │  Multi-Machine    │  Malware Anal. │
  └──────────────────────┴──────────────────┴───────────────┘

  ┌──────────────────────────────────────────────────────────┐
  │                     PROVE                                 │
  │  Certifications  │  Credly Badges  │  Public Portfolio   │
  └──────────────────┴────────────────┴─────────────────────┘
```

### Why Cyber Detective Will Win

1. **Existing platforms (HTB, TryHackMe) focus on offense.** Blue team has no equivalent home.
2. **DFIR skills are critically understaffed** — companies struggle to find trained analysts.
3. **The investigation format trains real job skills:** log analysis, report writing, timeline reconstruction.
4. **The AI Investigator adapts to every skill level** — nobody gets stuck, nobody gets it handed to them.
5. **Enterprise training is a massive underserved market** — $50M+ opportunity.

---

> **Build the MVP. Launch. Iterate.**
> The first grain of wheat is a working Docker terminal with one case. Everything else follows.

---

*Document generated on 2025-03-04 · Cyber Detective Master Plan v2.0*
