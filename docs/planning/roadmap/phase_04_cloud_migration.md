# Phase 4: Cloud Migration (AWS Production)

## 1. Objective
Migrate the workload from the Home Lab to a globally scalable Public Cloud (AWS) when business needs dictate (e.g., paying customers, need for 99.99% uptime, investor demo).

## 2. Architecture Shift

### 2.1. From "Monolithic Docker" to "Managed Services"
To leverage the cloud fully, we stop managing stateful containers ourselves.

*   **Database:** Migrate local Postgres container -> **AWS RDS (Relational Database Service)**.
    *   *Why:* Automated backups, Multi-AZ high availability.
*   **Storage:** Migrate local media folder -> **AWS S3**.
    *   *Why:* Infinite storage for property photos, faster delivery via CDN.
*   **Compute:** Migrate Docker Compose -> **AWS ECS (Elastic Container Service)** (Fargate or EC2).
    *   *Why:* Auto-scaling, zero-downtime deployments.

## 3. Implementation Steps
- [ ] **Data Migration:** Dump local DB and restore to RDS instance.
- [ ] **Asset Migration:** Upload user-uploaded media to S3 bucket.
- [ ] **Infrastructure Provisioning:** Use Terraform or AWS Console to set up VPC, Security Groups, ECR (Regsitry).
- [ ] **CI/CD Pipeline:** Set up GitHub Actions to auto-deploy to ECS on push to `main`.

## 4. Definition of Done (DoD)
1.  Home Lab can be turned off, and the site remains online.
2.  Database is automatically backed up by AWS.
3.  System can handle auto-scaling based on traffic load.
