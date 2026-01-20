# 2 — Project Stack Summary (`/docs/_project`)

## Goal
Create a human-readable snapshot of the project’s current technical foundation.

This step answers:
- What tools are we using?
- What problem does each tool solve?
- Why was it chosen at a high level?

This is not an Architecture Decision Record and is not immutable.  
It is explanatory, current-state documentation meant for onboarding and shared understanding.

Formal decisions and change control come later (Steps 3–4).

## Template

<details>
<summary><strong>Project Stack Summary (click to expand)</strong></summary>

```md
# Project Stack Summary

## Purpose
Provide a human-readable overview of the project’s technical stack.
Explain what tools are in use, what problems they solve, and why they were chosen.

This is not an Architecture Decision Record.
Formal decisions and changes are documented separately in ADRs.

---

## System Overview
Project: Project Name  
Primary Use Case: What this system does  
Runtime Environment: browser / server / hybrid  

---

## Layer 1 — Language & Architecture

### Language
TypeScript (version + config, e.g. strict)

Why:
- type safety and correctness
- shared contracts across the system
- safer refactors over time

How it’s enforced:
- strict compiler options
- shared base config
- typecheck in CI

---

### Framework / Application Architecture
Framework name + version (e.g. Next.js App Router)

Why:
- defines routing, rendering, and data boundaries
- reduces custom infrastructure overhead

How it’s used:
- routing model
- rendering approach (SSR / SSG / streaming)
- server vs client boundaries

---

## Layer 2 — State & Framework

### State Management
Library (e.g. Redux Toolkit)

Why:
- predictable state transitions
- centralized ownership for cross-cutting UI state

How it’s used:
- store structure
- ownership rules
- update patterns

---

### Data Fetching
Library or approach (e.g. TanStack Query, framework fetch)

Why:
- caching, deduplication, and background updates
- consistent async data handling

How data flows:
- where data is fetched
- how it’s cached
- how it’s invalidated

---

## Layer 3 — Quality & Stability

### Testing

Unit / Integration
Vitest (runner + assertions + mocking)

Why:
- fast feedback loop for behavior-level tests
- modern DX with strong TypeScript support

React Rendering
React Testing Library (render + query utilities)

Why:
- tests align with user-visible behavior
- avoids implementation-detail coupling

E2E
Playwright Test

Why:
- real browser confidence for critical flows
- covers end-to-end behavior across routing, auth, and data

Testing strategy:
- unit: pure logic, reducers, utilities
- integration: component behavior with RTL
- E2E: critical user journeys and async server-rendered flows

Notes:
- if async server component coverage is needed, prefer E2E coverage for those paths

---

### Linting & Formatting
Tools (e.g. ESLint, Prettier)

Why:
- consistent code style
- early error detection

How it’s enforced:
- local tooling
- pre-commit hooks
- CI gates

---

## Layer 4 — UI & Experience

### Styling System
Tools (e.g. Tailwind CSS, CSS Modules)

Why:
- consistency across UI
- scalability as features grow

How it’s structured:
- tokens (color, spacing, typography)
- component-level styles

---

### Component Strategy
Approach (e.g. design system, primitives)

Why:
- reuse and composability
- accessibility by default

How components are built:
- ownership rules
- composition patterns

---

## Layer 5 — Build & Delivery

### Package Manager
Tool + version (e.g. pnpm 10+)

Why:
- deterministic installs
- performance
- workspace support

---

### Build System
Tool (e.g. Turbopack, Vite)

Why:
- fast local feedback
- predictable production output

How it’s used:
- dev vs prod builds
- caching strategy

---

### CI/CD
Platform (e.g. GitHub Actions, Vercel)

Why:
- automated validation
- consistent deployments

Pipeline stages:
- build
- lint
- typecheck
- test
- deploy

---

## Layer 6 — Security & Observability

### Authentication & Authorization
Approach or provider

Why:
- protect user data
- enforce access control

How it’s implemented:
- session handling
- protected routes
- role checks

---

### Environment & Secrets
Tooling or strategy

Why:
- prevent credential leaks
- environment parity

How it’s enforced:
- env validation
- CI/CD secret management

---

### Logging & Monitoring
Tools (e.g. logging, error tracking, RUM)

Why:
- visibility into failures
- production diagnostics

What’s monitored:
- errors
- performance
- critical user flows

---

## Documentation & Governance
- Documentation lives in /docs
- ADRs record architectural decisions
- This file reflects current stack reality, not decision history

---

## Review Notes
Last reviewed: date  
Next review: cadence  
Owner: person or team
```
</details> 

## Real Example

<details>
<summary><strong>Project Stack Summary — Synct (click to expand)</strong></summary>

```md
# Project Stack Summary

## Purpose
Provide a human-readable overview of the project’s technical stack.
Explain what tools are in use, what problems they solve, and why they were chosen.

This is not an Architecture Decision Record.
Formal decisions and changes are documented separately in ADRs.

---

## System Overview
Project: Synct  
Primary Use Case: Collaborative data synchronization and workflow management  
Runtime Environment: hybrid (server + browser)  

---

## Layer 1 — Language & Architecture

### Language
TypeScript 5.6 (strict)

Why:
- strong compile-time guarantees across a growing codebase
- shared contracts between server and client
- safer refactors with reduced runtime risk

How it’s enforced:
- strict compiler options enabled
- shared base tsconfig extended repo-wide
- typecheck required in CI

---

### Framework / Application Architecture
Next.js 16 (App Router)

Why:
- unified solution for routing, rendering, and data access
- supports hybrid rendering patterns without custom infra
- clean server/client boundaries for performance and correctness

How it’s used:
- App Router for routing
- server components for data access and mutations
- client components for interactive UI
- Suspense/streaming for async boundaries

---

## Layer 2 — State & Framework

### State Management
Redux Toolkit

Why:
- predictable state transitions for cross-cutting UI state
- clear ownership boundaries via slices

How it’s used:
- global store for UI/session-level state
- feature slices own their state shape
- explicit reducers/actions enforce predictable updates

---

### Data Fetching
TanStack Query + Next.js fetch

Why:
- consistent async data handling and cache behavior
- request deduplication, invalidation, background refetching

How data flows:
- server components fetch initial data
- TanStack Query hydrates and manages client cache
- mutations invalidate affected queries and refetch as needed

---

## Layer 3 — Quality & Stability

### Testing

Unit / Integration
Vitest

Why:
- fast, modern runner with strong TypeScript support
- good ergonomics for mocking and assertions

React Rendering
React Testing Library

Why:
- tests focus on user-visible behavior (not implementation details)
- stable patterns for component and hook integration tests

E2E
Playwright Test

Why:
- real browser confidence for critical workflows
- resilient cross-browser automation and debugging tools

Testing strategy:
- unit: pure logic, utilities, reducers
- integration: component behavior with RTL + Vitest
- E2E: critical user journeys (routing, auth, data mutation flows)

Notes:
- async server-component flows are validated via E2E where unit testing isn’t a good fit

---

### Linting & Formatting
ESLint + Prettier

Why:
- consistent code style across contributors
- early detection of common errors

How it’s enforced:
- shared repo config
- pre-commit hooks for auto-fix
- CI fails on lint violations

---

## Layer 4 — UI & Experience

### Styling System
Tailwind CSS

Why:
- consistent tokens and styling patterns across the app
- scales well with component-based UI
- predictable output with minimal custom CSS drift

How it’s structured:
- centralized theme configuration
- utility-first styles at component level
- minimal custom CSS

---

### Component Strategy
Composable primitives + feature-level components

Why:
- promotes reuse without premature abstraction
- accessibility handled at the primitive level

How components are built:
- primitives handle semantics and accessibility
- feature components compose primitives near domain logic
- clear ownership and reuse rules prevent component sprawl

---

## Layer 5 — Build & Delivery

### Package Manager
pnpm 10+

Why:
- deterministic installs
- faster installs locally and in CI
- strong workspace support

---

### Build System
Turbopack (Next.js native)

Why:
- fast incremental builds for development
- tight integration with Next.js runtime model

How it’s used:
- Turbopack for local dev/build
- framework-native output for production
- caching handled through Next.js defaults and CI cache configuration

---

### CI/CD
GitHub Actions + Vercel

Why:
- automated validation on every PR
- consistent preview + production deployments

Pipeline stages:
- install dependencies
- lint
- typecheck
- test
- build and deploy

---

## Layer 6 — Security & Observability

### Authentication & Authorization
OAuth-based authentication (session-based)

Why:
- standardized identity management
- secure access control for user data

How it’s implemented:
- session handling via secure cookies/tokens
- protected routes enforced at routing boundary
- role checks at application boundaries

---

### Environment & Secrets
Environment variables managed via CI/CD + hosting platform

Why:
- prevent secret leakage
- consistent environment parity across dev/stage/prod

How it’s enforced:
- `.env.example` for documentation
- secrets injected via CI/CD and hosting platform
- runtime validation on startup

---

### Logging & Monitoring
Centralized logging + error tracking

Why:
- visibility into failures
- faster diagnosis of production issues

What’s monitored:
- application errors
- request failures
- key performance signals for critical flows

---

## Documentation & Governance
- Documentation lives in /docs
- ADRs capture architectural decisions and changes
- This file reflects the current stack state, not decision history

---

## Review Notes
Last reviewed: 2026-01-20  
Next review: Quarterly  
Owner: Frontend Engineering
```
</details>

## Setup Steps

1. Create the stack summary file  
Create:  
`docs/_project/stack-summary.md`

2. Populate it using the template above  
Focus on clarity and intent, not exhaustiveness.

3. Link it from:
- `docs/README.md`
- `docs/_project/README.md`

## Verification

- `/docs/_project/stack-summary.md` exists
- File explains why each major tool exists
- No ADR language (status, alternatives, approvals)
- A new engineer can understand the stack without reading code

## Commit

Commit message:  
`docs(project): add project stack summary`
