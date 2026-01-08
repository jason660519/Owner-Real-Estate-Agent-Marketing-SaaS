# Phase 1: Containerization Core Architecture (The Foundation)

## 1. Objective
Establish a standardized, containerized development environment where the entire application stack runs with a single command. This decouples the development process from the underlying hardware, ensuring consistency across macOS (Local), Proxmox (Home Lab), and AWS (Cloud).

## 2. Key Components & Technologies
*   **Orchestration:** Docker Compose
*   **Backend:** Python 3.12+ (Django 5 + Django REST Framework)
*   **Frontend:** Node.js 20+ (Next.js 14+ with App Router)
*   **Database:** PostgreSQL 16 (Alpine image)
*   **Cache:** Redis 7 (Alpine image)

## 3. Implementation Steps

### 3.1. Infrastructure as Code (Docker)
- [ ] **Refine `docker-compose.yml`:**
    - Configure stable networking (`owner_net`).
    - Set up persistent volumes for PostgreSQL (`postgres_data`).
    - Define environment variables structure (`.env` file).
- [ ] **Backend Containerization:**
    - Create `backend/Dockerfile`.
    - Install dependencies (`requirements.txt` with Gunicorn, Psycopg2).
    - Create `entrypoint.sh` for database waiting and migration checks.
- [ ] **Frontend Containerization:**
    - Create `frontend/Dockerfile` (Multi-stage build for optimization).
    - Configure hot-reloading for local development.

### 3.2. Connectivity Verification
- [ ] Ensure Backend can connect to PostgreSQL (`db:5432`).
- [ ] Ensure Backend can connect to Redis (`redis:6379`).
- [ ] Ensure Frontend can talk to Backend API (CORS & Proxy settings).

## 4. Definition of Done (DoD)
1.  Running `docker-compose up --build` launches all 4 services without errors.
2.  Modifying code in `frontend/` or `backend/` reflects immediately (Hot Reload).
3.  Database data persists even after container restarts.
