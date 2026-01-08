# Phase 1: Home Lab Infrastructure Plan (Proxmox + Docker + Cloudflare)

This document outlines the architecture and steps to set up the "Owner Real Estate Agent SaaS" on a local home PC, simulating a cloud environment for development and limited external testing.

## 1. Architecture Overview (The Stack)

Instead of the complex OpenStack, we will use **Proxmox VE** to manage resources (like EC2) and **Docker Compose** to orchestrate the application services. **Cloudflare Tunnel** will act as our secure gateway (like a VPC Internet Gateway + Load Balancer).

```mermaid
graph TD
    User((Public User)) -->|HTTPS| CloudflareEdges[Cloudflare Global Network]
    CloudflareEdges -->|Tunnel| HomeRouter[Home Router]
    HomeRouter -->|Internal Network| HomePC[Home PC / Proxmox Node]
    
    subgraph "Home PC (Proxmox VE)"
        subgraph "VM: App-Server (Ubuntu LTS)"
            Docker[Docker Engine]
            
            subgraph "Docker Compose Network"
                CFT[Cloudflared Daemon]
                Nginx[Nginx Reverse Proxy (Optional)]
                NextJS[Frontend: Next.js]
                Django[Backend: Django REST]
                Postgres[(DB: PostgreSQL)]
                Redis[(Cache: Redis)]
            end
        end
    end

    CFT -->|Local Traffic| NextJS
    CFT -->|Local Traffic| Django
    NextJS -->|API Calls| Django
    Django -->|Queries| Postgres
    Django -->|Tasks| Redis
```

## 2. Hardware Application Layer
**Goal:** Transform the PC into a hypervisor.

1.  **Base OS:** Proxmox VE (Virtual Environment).
    *   *Why:* Allows you to snapshot the entire server before making big changes (disaster recovery), and monitor CPU/RAM usage visually.
2.  **Virtual Machine (The "Instance"):**
    *   OS: Ubuntu Server 24.04 LTS.
    *   Specs: Assign 4-8 vCPU, 8GB+ RAM (depending on PC specs).
    *   Role: This VM acts as your "Production Server".

## 3. Application Deployment Layer (Docker Strategy)

We will use a single `docker-compose.yml` file to define the entire infrastructure. This makes it easy to migrate to AWS/GCP later (just copy the file).

### Service Definitions

| Service | Container Name | Port Mapping | Description |
| :--- | :--- | :--- | :--- |
| **Proxy/Tunnel** | `cloudflared` | - | Connects securely to Cloudflare. No open ports on router needed. |
| **Frontend** | `frontend_nextjs` | 3000 | The React/Next.js Marketing & Dashboard UI. |
| **Backend** | `backend_api` | 8000 | Django / Python API Server. |
| **Database** | `db_postgres` | 5432 | Main relational database. |
| **Cache** | `cache_redis` | 6379 | Session storage and background tasks queue. |

## 4. Networking & Domain (Cloudflare Tunnel)

This is the key to safety. We will NOT open ports (Port Forwarding) on your router.

1.  **Domain:** You need a domain name (e.g., `ownersaas-dev.com`).
2.  **Tunnel Configuration:**
    *   `api.ownersaas-dev.com` -> points to `http://backend_api:8000`
    *   `ownersaas-dev.com` -> points to `http://frontend_nextjs:3000`
    *   `admin.ownersaas-dev.com` -> points to `http://backend_api:8000/admin` (Optional security)

## 5. Security Checklist

- [ ] **Firewall (UFW)**: Enable on Ubuntu VM, allow only SSH (22) from internal IP.
- [ ] **Backups**: Set up Proxmox weekly backup schedule.
- [ ] **Secrets Management**: Do not hardcode API keys. Use `.env` file blocked from Git.
- [ ] **Zero Trust Access**: Configure Cloudflare Access to require an email login before accessing the Admin Panel or Swagger Docs remotely.

## 6. Execution Roadmap

### Step A: Physical Setup (User Action Required)
1.  Download Proxmox VE ISO.
2.  Flash to USB.
3.  Install on Home PC (Note: This wipes the disk!).
4.  Create an Ubuntu VM inside Proxmox's web interface.

### Step B: Codebase Preparation (AI Assisted)
1.  Initialize Next.js Project.
2.  Initialize Django Project.
3.  Create `Dockerfile` for Frontend.
4.  Create `Dockerfile` for Backend.
5.  Create `docker-compose.yml`.

### Step C: Deployment
1.  SSH into Ubuntu VM.
2.  `git pull` the repo.
3.  `docker compose up -d`.
4.  Authenticate Cloudflare Tunnel.

---
**Next Step Recommendation:**
Shall I start establishing the folder structure and generating the `docker-compose.yml` and `Dockerfile` configurations so your code is ready for the server?
