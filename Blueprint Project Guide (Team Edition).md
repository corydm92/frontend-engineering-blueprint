The Frontend Engineering Blueprint (Team Edition)
Team Edition — Derived from Master Blueprint v1.15 by Cory Morrissey

An adaptable, full-lifecycle framework for frontend teams to define, scale, and maintain predictable engineering systems.

Organized into seven interconnected layers forming a complete, repeatable model —
from code fundamentals to production observability.

---

## Introduction: Purpose and Application

The Frontend Engineering Blueprint defines how your team builds and evolves frontend
systems with consistent quality and pace.

It is modular, progressive, and opinionated —
designed to adapt to your project’s scale and maturity.

Use this document to:

• Establish a shared language for frontend quality and decision-making  
• Map every engineering concern to one of seven defined layers  
• Create a living technical contract your entire team can maintain

---

## How to Apply This Framework

If starting fresh:
Move through layers sequentially (L0 → L6).
Don’t optimize what isn’t stable.

If joining or refactoring:
Reorder pragmatically.
Fix what blocks progress first (for example, stabilize state before polishing UI).

If scaling a mature project:
Treat each layer as a quarterly audit checklist for technical health.

If a small or startup team:
Begin with Layers 0–3 and expand structure as maturity increases.

---

## Guiding Principle

Fix what’s broken at each layer before moving down the list.
Don’t build polish on shaky foundations.

---

## Core Engineering Principles

These principles apply across all layers.
They are non-negotiable rules of engineering discipline and the backbone of
predictable, maintainable systems.

1. DRY — Don’t Repeat Yourself

DO:
• Centralize repeated utilities or constants  
• Abstract duplicate API logic into reusable modules  
• Document common patterns so reuse is intentional

DON’T:
• Copy-paste functions across files  
• Duplicate configuration or environment logic  
• Fork codebases for minor feature differences

2. KISS — Keep It Stupid Simple

DO:
• Favor readable, linear code over nested complexity  
• Use small, explicit functions that do one thing well  
• Remove unnecessary abstractions until proven useful

DON’T:
• Add layers “just in case”  
• Hide complexity behind confusing naming or wrappers  
• Build over-generalized systems early

3. YAGNI — You Aren’t Gonna Need It

DO:
• Build minimal viable features first  
• Refactor reactively based on usage or data  
• Continuously prune unused code and dead modules

DON’T:
• Create extensibility layers without demand  
• Implement unused APIs or hooks  
• Delay delivery for theoretical scaling

4. SoC — Separation of Concerns

DO:
• Split UI, logic, and data into distinct modules  
• Isolate configuration, constants, and environment logic  
• Keep side effects out of pure functions

DON’T:
• Mix rendering, data fetching, and mutation logic in one component  
• Cross-import between unrelated feature modules  
• Store domain logic in the UI layer

5. Fail Fast, Learn Faster

DO:
• Throw explicit errors with clear context  
• Use runtime and type validation early  
• Automate alerts and logs to catch regressions immediately

DON’T:
• Ignore test or build warnings  
• Swallow exceptions without reporting  
• Wait for production to reveal broken states

---

## Layer 0 — System Initialization

Purpose:
Establish the baseline environment, toolchain, and governance model
before writing production code.

This layer defines the technical contract for the entire system.

Discussion & Decision Phase:
Each topic below should be discussed and documented by the team
before implementation.

Decisions are captured in a Project Setup Contract ADR.

Topics to Decide:
• Framework selection  
• Runtime strategy (SSR, CSR, SSG, ISR)  
• TypeScript strictness and linting rules  
• Build tool and bundler  
• Testing stack and CI thresholds  
• Design system approach  
• Shared registry strategy  
• API contract strategy  
• Authentication and session model  
• Feature flag provider and evaluation model  
• Analytics schema ownership  
• Error and logging schema  
• CI/CD platform and gates  
• Code quality and commit discipline  
• Package manager and lockfile policy

Once finalized, record:
• Tool or standard  
• Reason for choice  
• Owner / reviewer  
• Date and review cadence

---

## Initialization Checklist

Critical — Initialize First:
• Runtime baseline installed  
• Framework scaffold created  
• TypeScript strict configuration  
• Deterministic package manager setup  
• Version control with protected main branch  
• ESLint + Prettier enforced via CI  
• Commit discipline enforced  
• Design system baseline chosen  
• State management and async layer defined  
• API contract ownership established  
• Auth model defined  
• CI/CD workflow created

Recommended — Initialize Early:
• Environment variable schema  
• Feature flag provider  
• Analytics ownership  
• Testing pyramid defined  
• Dependency auditing  
• Preview deployments

Optional — Add as Project Scales:
• Monorepo tooling  
• Component library  
• Observability tooling  
• Security scanning

Completion Verification:
All Critical tasks must be complete before starting Layer 1.

Governance:
• Checklist and ADR must remain in sync  
• Major changes require ADR updates  
• Review cadence: quarterly or per major release

---

## Layer 1 — Language & Architecture

DO:
• Use strict typing and shared configurations  
• Enforce consistent imports and code style  
• Record design choices as lightweight ADRs

DON’T:
• Mix module systems  
• Bypass lint rules for speed  
• Store configuration or domain logic in UI files

---

## Layer 2 — State & Framework

DO:
• Use one predictable global state system  
• Normalize async state patterns  
• Keep local state local when possible

DON’T:
• Mutate state directly  
• Duplicate API calls across components  
• Mix view logic and data logic

---

## Layer 3 — Quality & Stability

DO:
• Follow the testing pyramid  
• Enforce Core Web Vitals budgets  
• Include accessibility audits in releases

DON’T:
• Ignore failing or flaky tests  
• Ship regressions without alerting  
• Skip quality gates for speed

---

## Layer 4 — UI & Experience

DO:
• Use design tokens  
• Build accessible, reusable components  
• Standardize layout and spacing primitives

DON’T:
• Hardcode inline styles  
• Duplicate design logic  
• Introduce inconsistent motion or color systems

---

## Layer 5 — Build & Delivery

DO:
• Automate lint, test, and build checks  
• Maintain semantic versioning  
• Keep lockfiles reproducible

DON’T:
• Deploy manually  
• Bypass CI  
• Ignore dependency vulnerabilities

---

## Layer 6 — Security & Observability

DO:
• Enforce security headers and CSP  
• Add structured logs and RUM metrics  
• Monitor Core Web Vitals with budgets

DON’T:
• Log user PII  
• Disable alerts  
• Ignore audit findings

---

## Team Dynamics and Collaboration

DO:
• Enforce reviews and CI checks  
• Rotate reviewers  
• Document recurring issues

DON’T:
• Merge unreviewed code  
• Accumulate ignored failures  
• Rely on undocumented tribal knowledge

---

## Blueprint Governance

DO:
• Assign a small working group  
• Version the blueprint quarterly  
• Use RFCs for changes

DON’T:
• Let versions drift  
• Allow permanent waivers  
• Disable compliance gates

---

## Blueprint Summary

Layer 0 chooses the constraints.
Layer 1 makes code predictable.
Layer 2 makes behavior stable.
Layer 3 makes it safe.
Layer 4 makes it usable.
Layer 5 makes it shippable.
Layer 6 makes it trustworthy.

The Blueprint is not a checklist.
It is a living engineering framework.

When applied with discipline,
it turns teams into predictable, high-velocity systems.
