# Standard 04: Project Structure & Naming Conventions

This document establishes the naming conventions and directory structure standards for the "Owner Real Estate Agent SaaS" project. The goal is to maintain a clean, navigable, and predictable codebase.

## 1. General Naming Conventions

### 1.1. Casing
| Type | Convention | Example |
| :--- | :--- | :--- |
| **Directories** | `snake_case` | `project_roadmap/`, `backend/`, `ui_specs/` |
| **Files (General)** | `snake_case` | `docker_compose.yml`, `readme.md`, `meeting_minutes.md` |
| **Files (Documentation)** | `snake_case` | `01_project_skeleton.md`, `agent_ui.md` |
| **Code Classes (Python)**| `PascalCase` | `PropertyManager` |
| **Code Variables** | `snake_case` | `user_id`, `is_active` |
| **React Components** | `PascalCase` | `PropertyCard.tsx`, `LoginForm.tsx` |

### 1.2. Numbering
For files that require a specific reading or execution order (e.g., standards, roadmap phases), use a zero-padded prefix.
*   **Format:** `NN_Description.md`
*   **Example:** `01_project_setup.md`, `02_mvp_development.md`

## 2. Directory Structure Standards

The project root should remain minimal. Most documentation and creative work should be categorized into `docs/`.

### 2.1. Recommended Layout
```text
Owner_Real_Estate_SaaS/
├── backend/                # API Source (Django)
├── frontend/               # UI Source (Next.js)
├── docs/                   # All project documentation
│   ├── planning/           # High-level plans, roadmaps, architecture
│   ├── meetings/           # Meeting minutes
│   ├── ui_designs/         # UI Mockups, wireframes, descriptions
│   └── standards/          # Coding standards (moved from root /Standards)
├── README.md               # Main entry point (was "Owner Real Estate Agent...md")
├── docker-compose.yml
└── requirements.txt        # (If applicable to root scripts)
```

## 3. Migration Plan (Current to Standard)

If you see files violating these rules, please rename them using the `mv` command.

*   `Standards/` -> `docs/standards/`
*   `UI/` -> `docs/ui_designs/`
*   `Project_Roadmap/` -> `docs/planning/roadmap/`
*   Low-level plans (root MD files) -> `docs/planning/`
*   `Owner Real Estate Agent Marketing SaaS.md` -> `README.md` (or `project_overview.md`)

## 4. Specific File Grouping

*   **Meeting Minutes**: Store in `docs/meetings/` with format `YYYYMMDD_topic_summary.md`.
    *   Example: `20260108_kickoff.md`
*   **Roadmaps**: Store in `docs/planning/`
