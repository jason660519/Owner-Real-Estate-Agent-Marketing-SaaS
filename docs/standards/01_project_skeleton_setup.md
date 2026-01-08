# Standard 01: Project Skeleton & Codebase Setup

This document defines the standard procedure for initializing and maintaining the project structure. All engineers must adhere to this layout to ensure containerization works seamlessly across Local, Home Lab, and Cloud environments.

## 1. Directory Structure Standard

The project root must act as a monorepo containing distinct services.

```text
Owner_Real_Estate_SaaS/
├── backend/                # Django REST Framework (Python)
│   ├── core/               # Main settings & config
│   ├── apps/               # Business logic apps (owners, listings, etc.)
│   ├── requirements.txt    # Python dependencies
│   ├── Dockerfile          # Production Dockerfile
│   └── manage.py
├── frontend/               # Next.js (TypeScript)
│   ├── src/
│   │   ├── app/            # App Router pages
│   │   ├── components/     # Shadcn & Shared components
│   │   └── lib/            # API clients & utilities
│   ├── package.json
│   └── Dockerfile          # Production Dockerfile
├── docker-compose.yml      # Main orchestration file for Dev/HomeLab
├── .env.example            # Template for environment variables
└── .gitignore
```

## 2. Technology Standards

### Backend (API Service)
*   **Language:** Python 3.11+
*   **Framework:** Django 5.x + Django REST Framework 3.14+
*   **Database Client:** `psycopg2-binary` (for PostgreSQL)
*   **Task Queue:** Celery 5+ (connected to Redis)

### Frontend (User Interface)
*   **Framework:** Next.js 14+ (App Router)
*   **Language:** TypeScript
*   **Styling:** Tailwind CSS + Shadcn/ui
*   **State/Data Fetching:** TanStack Query (React Query)

## 3. Docker Configuration Standards

Every service must have a multi-stage `Dockerfile` to support both lightweight production builds and hot-reloading development modes.

### Standard `docker-compose.yml` Structure
The orchestration file must define the following services:

1.  **db**: PostgreSQL 16 image.
    *   Must use named volumes for data persistence: `postgres_data:/var/lib/postgresql/data`.
2.  **redis**: Redis 7-alpine image.
3.  **backend**:
    *   Depends on `db` and `redis`.
    *   Volume mount: `./backend:/app` (to enable live code reloading).
4.  **frontend**:
    *   Depends on `backend`.
    *   Volume mount: `./frontend:/app` (to enable HMR).

## 4. Initialization Steps

To bootstrap the skeleton from scratch:

1.  **Backend Init:**
    ```bash
    mkdir backend && cd backend
    # Run in python container to avoid local pollution
    python -m django startproject core .
    ```

2.  **Frontend Init:**
    ```bash
    npx create-next-app@latest frontend --typescript --tailwind --eslint
    ```

3.  **Environment Setup:**
    Duplicate `.env.example` to `.env` and fill in local secrets (DB credentials, Secret Keys). **NEVER commit .env to Git.** 
