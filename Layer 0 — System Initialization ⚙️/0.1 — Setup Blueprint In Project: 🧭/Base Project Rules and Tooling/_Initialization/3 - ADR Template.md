# 3 — Architecture Decision Record (ADR) Template

## 🎯 Goal

Establish a single, enforceable template for recording **all architectural and foundational decisions** in the project, before any decisions are made.

This ensures decisions are explicit, reviewable, and historically traceable instead of living in PR comments, Slack threads, or tribal memory.

## 📦 What This Step Produces

This step produces **one artifact**:

- An ADR template that will be copied and filled in for every architectural decision going forward

No decisions are recorded yet  
No tools are chosen yet  
This step only defines the structure that decisions must follow

## 🔍 ADR Scope

ADRs are **required** for:

- framework changes
- adding / removing dependencies
- build system changes
- language or runtime changes
- dependency major upgrades
- large state or data-layer changes
- testing strategy changes
- CI/CD or deployment model changes
- security or authentication/authorization model changes
- observability stack changes

ADRs are **not required** for:

- normal feature development
- refactors with no architectural impact
- dependency patch or minor upgrades
- internal implementation details

## 📜 ADR Rules

- Status must be one of: `Proposed`, `Accepted`, `Rejected`, `Superseded`
- ADRs may be edited while `Proposed` (until accepted or rejected)
- Once `Accepted`, the decision is immutable (no decision changes in-place)
- A decision change requires a new ADR; the old ADR becomes `Superseded`
- `Superseded` ADRs must reference the ADR that replaces them
- When moving to `Accepted` or `Rejected`, record the final approval context (PR, issue, or date) in Notes

## 🧩 ADR Template

<details>
<summary><strong>ADR Template (click to expand)</strong></summary>

```md
# Architecture Decision Record

Title: ADR-XXXX — Short, Descriptive Title  
Status: Proposed | Accepted | Rejected | Superseded

Proposed Date: YYYY-MM-DD  
Accepted Date: YYYY-MM-DD (if applicable)

Owner: Person or Team responsible for the decision  
Approver(s): Person or group granting final sign-off

---

## Context

Describe the problem or situation that requires a decision.

Include:

- what triggered this decision
- relevant constraints (technical, organizational, timing)
- why this decision needs to exist now

This section explains why a decision is required, not what the decision is.

---

## Decision

State the decision clearly and unambiguously.

Include:

- what is being chosen
- what is explicitly not being chosen

This section should stand alone as the authoritative statement of intent.

---

## Rationale

Explain why this decision was selected.

Include:

- key tradeoffs considered
- benefits gained
- downsides or risks that are being accepted

The goal is future clarity, not persuasion.

---

## Alternatives Considered

List realistic alternatives and why they were not chosen.

Each alternative should include:

- brief description
- primary reason for rejection

If no viable alternatives existed, state that explicitly.

---

## Consequences

Describe the impact of this decision.

Include:

- immediate effects
- long-term implications
- areas that may require migration or review later

This section answers: what does this decision force us to live with?

---

## Supersedes

Only include if applicable.

- ADR-XXXX — Title of superseded decision

---

## Notes

Optional clarifications, approval context, follow-ups, or review signals.

Examples:

- Link to discussion PR or RFC
- Reason for rejection
- Planned review window
```

</details>

## 🧪 ADR Example

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

## ✅ Verification

docs/process/adr-template.md exists

The template matches the structure above

Team agrees this is the required format for architectural decisions
