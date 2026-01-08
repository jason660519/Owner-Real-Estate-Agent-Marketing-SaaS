# Phase 2: Business Logic Construction (MVP Development)

## 1. Objective
Develop the core "Minimum Viable Product" (MVP) features required for the Real Estate SaaS. This phase focuses on coding logic, API design, and data modeling, leveraging the stable Docker environment established in Phase 1.

## 2. Core Functional Requirements

### 2.1. Data Modeling (Odoo-Inspired)
*   **Objective:** Translate Odoo's robust enterprise logic into efficient Django models.
*   **Key Models:**
    - **Users:** Custom User Model (Email login), Roles (Owner, Agent, Tenant, Buyer).
    - **Properties:** Address, Type, Features, Photos, Status (Draft, Public, Sold, Rented).
    - **Contracts:** Leases, Sales Agreements, Commission Structures.
    - **Partners:** Contact directory inspired by `res.partner`.

### 2.2. API Development (Django REST Framework)
*   **Authentication:** JWT (JSON Web Tokens) or Session-based auth.
*   **Permissions:** Role-based access control (RBAC). e.g., Only "Owners" can edit their own properties.
*   **Endpoints:** RESTful API design (mostly CRUD operations + Business Actions).

### 2.3. Frontend Implementation (Next.js)
*   **UI/UX:** Implement Shadcn/ui components.
*   **Dashboards:**
    - **Owner Dashboard:** View property stats, income reports.
    - **Agent Dashboard:** Lead management, showing schedules.
    - **Public Site:** Property listing search and filtering.

## 3. Implementation Steps
- [ ] **Database Schema Design:** Create Django Models.
- [ ] **API Logic:** Write Serializers and Views.
- [ ] **Frontend Integration:** Fetch data from API and render pages.
- [ ] **Testing:** Unit tests for critical business logic (e.g., commission calculation).

## 4. Definition of Done (DoD)
1.  Users can Sign Up/Login.
2.  Owners can create and list properties.
3.  Agents can view assigned leads.
4.  Data integrity is enforced (Foreign Keys, Constraints).
