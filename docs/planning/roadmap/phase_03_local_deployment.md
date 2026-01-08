# Phase 3: Local Server Deployment (Home Lab / Proxmox)

## 1. Objective
Deploy the working application to the high-performance Home Lab Server (16-Core/64GB PC). This simulates a production environment deployment but keeps costs zero. It validates the "portability" of our Docker strategy.

## 2. Infrastructure Setup (Proxmox)

### 2.1. Virtualization Layer
*   **Host OS:** Proxmox VE.
*   **Guest VM:** Debian 12 or Ubuntu 24.04 LTS.
*   **Resources:** Assign 16GB RAM, 4 vCPUs to the Docker Host VM.

### 2.2. Deployment Workflow
*   **Method:** GitOps-Lite / Docker Compose.
*   **Steps:**
    1.  SSH into the VM.
    2.  Clone the repository.
    3.  Set production environment variables (`PROD=True`, `DEBUG=False`).
    4.  Run `docker-compose -f docker-compose.prod.yml up -d`.

### 2.3. Network & Security
*   **Access Control:** Use **Cloudflare Tunnel** (`cloudflared`) to expose the service.
    *   *Benefit:* No open ports on the router, DDOS protection, SSL handled automatically.
*   **Domain:** Connect a custom domain (e.g., `app.myrealestatesaas.com`).

## 3. Implementation Steps
- [ ] Install Proxmox on the Home PC.
- [ ] Create a Linux VM and install Docker Engine & Docker Compose.
- [ ] Configure Cloudflare Tunnel on the VM.
- [ ] create a `docker-compose.prod.yml` (e.g. using Nginx as reverse proxy).
- [ ] Perform a full deployment test.

## 4. Definition of Done (DoD)
1.  Application is accessible via public URL (https).
2.  Application runs independently of the developer's laptop.
3.  Server auto-restarts containers after reboot.
