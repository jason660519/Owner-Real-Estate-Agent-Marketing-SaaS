# Standard 03: Development Workflow & Contributing

This document defines the rules of engagement for developing features. Following this workflow minimizes merge conflicts and ensures code quality.

## 1. Branching Strategy (Git Flow)

We use a simplified Git Flow.

*   `main`: **Production Ready.** Deployed to the Home Lab Server automatically (eventually).
*   `develop` (Optional): Integration branch.
*   `feat/<name>`: Feature branches. (e.g., `feat/login-page`, `feat/property-crud`)
*   `fix/<issue>`: Bug fix branches.

**Rule:** Never push directly to `main`. Create a Pull Request (PR).

## 2. Backend Development Guidelines (Django)

### Model Changes
*   **Always** create a migration file immediately after changing `models.py`.
*   Command: `docker compose exec backend python manage.py makemigrations`

### API Design
*   Use **Django REST Framework (DRF)** ViewSets where possible.
*   **URL Naming:** Plural resources (e.g., `/api/properties/`, `/api/tenants/`).
*   **Response Format:** Standardize JSON responses.
    ```json
    {
      "data": { ... },
      "meta": { "page": 1, "total": 50 }
    }
    ```

### Testing
*   Write at least one "Happy Path" test for new API endpoints.
*   Run tests: `docker compose exec backend python manage.py test`

## 3. Frontend Development Guidelines (Next.js)

### Component Structure
*   Atomic Design-ish:
    *   `src/components/ui`: Shadcn/Primitive components (Button, Input).
    *   `src/components/features`: Complex, domain-specific blocks (PropertyCard, LeaseForm).

### Data Fetching
*   **Do NOT** use `useEffect` for data fetching.
*   **USE** TanStack Query (React Query) hooks.
    ```tsx
    // Good
    const { data, isLoading } = useQuery({ queryKey: ['properties'], queryFn: fetchProperties })
    ```

### Environment Variables
*   Access public vars via `process.env.NEXT_PUBLIC_...`
*   Never expose secrets (DB passwords) in Frontend code.

## 4. The definition of "Done"

A feature is considered "Done" when:
1.  Code is pushed to a feature branch.
2.  `docker compose up` runs without errors locally.
3.  New functionality works in the browser.
4.  No linting errors (Run `npm run lint` or `flake8`).
