# 4 — ADR-0001: Initial Project Tools (Project Setup Contract)

## 🎯 Goal

Create the project’s first governed architectural decision: **the initial tools and baseline** the repo will follow.

By Step 4, we already have:

- Step 2: a human-readable **Project Stack Summary** (`/docs/__project`) describing the current stack truth
- Step 3: the **ADR Template** (`/docs/process`) defining how decisions must be recorded and governed

Now we convert that stack truth into an enforceable contract by writing **ADR-0001**.

This prevents the baseline from drifting via “silent defaults” or “tribal memory.”

---

## 📦 What This Step Produces

This step produces **one artifact**:

- `docs/adr/ADR-0001 — Project Setup Contract.md`

No new tools are chosen here  
No implementation steps are performed here  
This is the formal decision record for the baseline already described in Step 2

---

## 🧩 Inputs

This ADR should be derived directly from:

- Step 2: `/docs/_project/stack-summary.md` (the current stack truth)
- Step 3: `/docs/process/adr-template.md` (the enforced structure)

The ADR should **link to the Stack Summary** as supporting context, but the ADR remains the authoritative decision record.

---

## 🧪 ADR-0001 — Project Setup Contract Example

<details> <summary><strong>ADR-0001 — Project Setup Contract (Synct) (click to expand)</strong></summary>

```md
# Architecture Decision Record

Title: ADR-0001 — Project Setup Contract (Synct v0.2)  
Status: Accepted

Proposed Date: 2025-10-28  
Accepted Date: 2025-10-28

Owner: Cory Morrissey  
Approver(s): Cory Morrissey

---

## Context

Synct needs a consistent, enforceable baseline for all new development so the repo is predictable across local development, CI, and deployment.  
Prior iterations allowed drift in runtime versions, package manager behavior, and build defaults, which created avoidable failures and onboarding friction.  
This ADR defines the Layer 0 foundation (framework, language, runtime, tooling) so future changes can be reviewed as intentional decisions.

---

## Decision

Adopt the following baseline for Synct v0.2:

- Framework: Next.js 16 (App Router)
- React: 19
- Language: TypeScript 5.6 (strict)
- Runtime: Node 24 LTS
- Package Manager: pnpm 10+
- Build System: Next.js default bundler (Turbopack where applicable)
- Unit/Integration Testing: Vitest + React Testing Library
- E2E Testing: Playwright Test
- Linting/Formatting: ESLint + Prettier
- CI/CD: GitHub Actions + Vercel
- Documentation: `/docs` structure with `/docs/_project`, `/docs/adr`, `/docs/blueprint`, `/docs/process`, `/docs/references`

Explicitly not chosen:

- Next.js 15 baseline
- Node 20 baseline
- Cypress for E2E

---

## Rationale

- Next.js 16 + React 19 provide a modern foundation for hybrid rendering and future-facing patterns without custom infra.
- Node 24 LTS reduces environment drift and supports modern runtime APIs that simplify platform code.
- TypeScript strict mode forces correctness and prevents long-term type debt.
- pnpm improves install determinism and supports workspace scaling if the repo grows into a monorepo.
- Vitest + React Testing Library provides fast unit/integration feedback while keeping tests aligned to user-visible behavior.
- Playwright provides stable browser-level confidence for critical journeys, especially where server-rendered async flows are involved.
- GitHub Actions + Vercel standardizes validation and deployment with preview environments for PR review.

---

## Alternatives Considered

- Next.js 15 — rejected due to older baseline and weaker alignment with the intended Next 16 + React 19 foundation.
- Node 20 LTS — rejected to avoid lagging runtime capabilities and to reduce near-term upgrade churn.
- npm / yarn — rejected due to slower installs and weaker workspace ergonomics compared to pnpm.
- Jest — viable, but rejected for this baseline in favor of Vitest’s faster feedback and TypeScript ergonomics.
- Cypress — rejected in favor of Playwright for cross-browser coverage and modern tooling.

---

## Consequences

Positive:

- Predictable local/CI/deploy environments with reduced drift
- Faster dev/test loops and clearer enforcement of correctness
- Stronger long-term maintainability through explicit foundations

Tradeoffs / Risks:

- Requires intentional governance for major version upgrades
- Some async server-rendered behavior is best validated via E2E rather than unit tests
- Tooling changes become more process-driven (ADR required)

---

## Supersedes

None

---

## Notes

Approval context:

- Accepted as the Layer 0 baseline for Synct v0.2

Review cadence:

- Quarterly review of framework/runtime/tooling baseline
- New ADR required for major upgrades (e.g., Next 17, Node 26)
```

</details>

---

## ✅ Verification

- `docs/adr/ADR-0001 — Project Setup Contract.md` exists
- Status is `Accepted` once approved
- Proposed/Accepted dates are present
- Owner + Approver(s) are present
- ADR-0001 aligns with `/docs/_project/stack-summary.md`
- Future baseline changes require a new ADR
