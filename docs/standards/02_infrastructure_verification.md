# Standard 02: Infrastructure Verification & Deployment

This document outlines the procedures for running the stack locally, verifying connectivity, and deploying to the Home Lab Server (Proxmox).

## 1. Local Development Verification (The "Works on My Machine" Check)

Before pushing any code, engineers must verify the stack runs locally.

### Start-Up Command
Run the following from the project root:
```bash
docker compose up --build
```

### Health Check Checklist
1.  **Container Status:**
    Run `docker compose ps` and ensure `frontend`, `backend`, `db`, and `redis` state is `Up`.

2.  **Frontend Accessibility:**
    *   Open `http://localhost:3000`.
    *   Verify the Next.js welcome page or Dashboard loads without console errors.

3.  **Backend Connectivity:**
    *   Open `http://localhost:8000/api/health/` (or equivalent endpoint).
    *   **DB Check:** Ensure the backend logs show "Connected to PostgreSQL".

4.  **Frontend-Backend Bridge:**
    *   The browser (Frontend) must be able to fetch data from the API.
    *   *Common Issue:* Ensure CORS is configured in Django `settings.py` to allow `http://localhost:3000`.

## 2. Home Lab Deployment (Proxmox/Production)

For the shared server environment (The PC Server), we follow a GitOps-lite approach.

### Deployment Environment
*   **Host:** Ubuntu VM on Proxmox
*   **Path:** `/opt/owner-saas-platform`

### Deployment Steps
1.  **SSH into Server:**
    ```bash
    ssh user@192.168.x.x
    ```
2.  **Pull Latest Changes:**
    ```bash
    cd /opt/owner-saas-platform
    git pull origin main
    ```
3.  **Rebuild & Restart:**
    ```bash
    # Rebuilds only changed layers, minimizes downtime
    docker compose up -d --build
    ```
4.  **Run Migrations (Crucial):**
    Never assume migrations run automatically.
    ```bash
    docker compose exec backend python manage.py migrate
    ```

## 3. Network Verification (Cloudflare Tunnel)

After deployment, verify external access:
1.  Visit `https://ownersaas-dev.com` (Frontend).
2.  Visit `https://api.ownersaas-dev.com/admin` (Django Admin).
3.  **Troubleshooting:**
    *   If 502 Bad Gateway: Check if Docker container is running.
    *   If 404 Not Found: Check Cloudflare Tunnel config rules.
