# 5.2 — CI/CD with Docker, Vercel, and npm

Updated by Cory Morrissey: 1/29/2026

This section defines a **single, deterministic CI/CD path** for projects that deploy via:
- Vercel (web apps)
- Docker/containers (services)
- npm (libraries)

The goal is consistency: one artifact promoted from dev → staging → prod, with CI gates that never get skipped.

## What this section covers
- A baseline CI gate (format, lint, type-check, test)
- Gitflow-style CD triggers per environment
- Artifact promotion rules (no rebuilds after dev)
- Release tagging for production

## Section structure
- Base Project Rules and Tooling
  - __Initialization
- Core Sequential Subsections
- Supporting Atomic Notes

## How to use
1) Read Base Project Rules and Tooling first (non-negotiable rules).
2) Follow Core Sequential Subsections in order to understand the flow.
3) Use Supporting Atomic Notes for quick decisions and edge cases.
