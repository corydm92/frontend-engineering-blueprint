2 - Project Setup Contract ADR Template + Example
Version: v1.4
Last Updated: 10/28/25

Purpose
Define the foundational setup and baseline technical contract for new projects.
This ADR establishes the Layer 0 foundation Ñ documenting framework, language, runtime, and tooling versions that all contributors must follow.
It ensures consistency, scalability, and maintainability across every environment and repository that derives from this setup.

Motivations
- Align new projects with the organizationÕs Frontend Engineering Blueprint.
- Prevent environment drift through explicit version control.
- Simplify onboarding and reduce ambiguity in setup steps.
- Serve as a single source of truth for the projectÕs technical foundation.

---

Template

Title
Project Setup Contract (<Project Name> v<version>)
Status: Proposed | Accepted
Date: <date>
Version: v<version>

Context
Describe why this setup exists and what gaps or problems it solves.
Explain how it connects to organizational standards or blueprint layers.

Decision
Define the Layer 0 foundation Ñ all frameworks, runtimes, and tools chosen for this project.

Framework
- <Framework Name> v<version>
- Reason: <why chosen and what problem it solves>

React
- <React Version>
- Reason: <compatibility, features, and performance notes>

Language
- <Language Version>
- Reason: <type-safety, consistency, or interoperability rationale>

Runtime / Node
- <Node Version>
- Reason: <performance, stability, compatibility notes>

Package Manager
- <Manager Name> v<version>
- Reason: <deterministic installs, workspace support, etc.>

Build Tool
- <Tool Name> v<version>
- Reason: <why this tool fits the runtime and performance goals>

Linting and Formatting
- <Tools>
- Reason: <how they enforce code quality and consistency>

Styling
- <Tools / Framework>
- Reason: <why this supports design-system or accessibility goals>

State Management
- <Tools / Libraries>
- Reason: <predictable state handling and scalability alignment>

Testing Stack
- <Tools>
- Reason: <coverage philosophy, speed, and ecosystem alignment>

CI/CD Platform
- <Platform>
- Reason: <automation strategy and deployment rationale>

Documentation
- /docs directory aligned with the Frontend Engineering Blueprint (Layers 0<ETH>6).
- Includes: /adr, /process, and /blueprint sections for traceability.

Version Control Discipline
- Conventional Commits enforced through Husky + Commitlint.
- PR titles must follow Conventional Commit syntax and reference ADR IDs when applicable.

Governance
- All major version or foundational tool changes require a new ADR revision.
- Each revision must cross-reference this baseline.

---

Alternatives Considered
Option 1: <description> Ñ rejected because <reason>.
Option 2: <description> Ñ rejected because <reason>.
Option 3: <description> Ñ rejected because <reason>.

If none, note ÒNo viable alternatives at time of decision.Ó

---

Version Governance
All language, framework, and runtime versions must be explicitly recorded at the time of approval.

Minor or patch updates may proceed through PR review if non-breaking.
Major or structural changes require:
- A new ADR revision.
- Updates to:
¥ /docs/architecture/stack.md
¥ /docs/layers/00-system-initialization/full-initialization-order.md

Baseline Example:
- Node: v24 LTS
- TypeScript: v5.6
- React: v19.0.0
- Next.js: v16.0.0 (App Router)
- pnpm: v10+

---

Consequences

Positive Outcomes
- Establishes reproducible, traceable environments across all contributors.
- Reduces onboarding friction and enforces version alignment.
- Provides historical clarity for future upgrades and refactors.

Risks / Tradeoffs
- Introduces governance overhead for version control.
- Slows rapid experimentation without ADR review.
- Requires maintenance to ensure documentation parity with actual stack.

---

References
- /docs/architecture/stack.md
- /docs/layers/00-system-initialization/full-initialization-order.md
- /docs/layers/00-system-initialization/documentation-setup.md
- /docs/process/adr-template.md
- /docs/blueprint/<current-blueprint-version>.md

---

Full Example

Project Setup Contract (Synct v0.2)
Status: Accepted
Date: 10/28/25
Version: v0.2

Context
Synct requires a defined and enforceable foundation for all new repositories to maintain predictability, alignment, and scalability across environments.
This contract revises the original v0.1 baseline to align with Next.js 16, Node 24 LTS, and pnpm 10+, integrating the latest architectural and build-system improvements.
It replaces the v15 foundation with modern caching, bundling, and runtime primitives Ñ ensuring long-term maintainability and MAANG-level performance parity.

Framework
- Next.js v16.0.0
- Uses stable Turbopack as the default bundler.
- Supports the "use cache" directive and refined hybrid rendering (SSR + ISR + PPR).
- Chosen for predictable scalability, faster builds, and React 19 compatibility.

React
- React v19.0.0
- Concurrent release supporting the React Compiler, Actions, and built-in Suspense.
- Enables modern async rendering boundaries and future concurrent features.

Runtime / Node
- Node v24 LTS
- Modern runtime providing fetch(), Web Streams, and enhanced diagnostics.
- Ensures full ESM compatibility and cross-environment consistency.

Language
- TypeScript v5.6 (strict mode)
- Enforces strong typing, zero any tolerance, and accurate async inference.
- Provides shared tsconfig inheritance for workspace consistency.

Package Manager
- pnpm v10+
- Deterministic, content-addressable installs with workspace isolation.
- Improves dependency management speed and reliability across CI/CD.

Build Tool
- Turbopack (Next.js native)
- Rust-based incremental bundler providing 2<ETH>5* faster build and refresh times.
- Fully integrated with Next.js 16 for predictable output.

Linting and Formatting
- ESLint + Prettier
- Shared configuration enforcing predictable formatting and consistent CI standards.
- Auto-fix on commit via Husky + lint-staged.

Styling
- TailwindCSS + shadcn/ui
- Accessible, design-system-ready primitives with full design token integration.
- Enables scalable UI consistency and theming flexibility.

State Management
- Redux Toolkit + TanStack Query
- Unified global and async state model aligned with Next 16Õs opt-in caching.
- Promotes predictable updates, normalized data, and efficient fetch handling.

Testing Stack
- Jest + React Testing Library + Cypress
- Stable, proven testing ecosystem for unit, integration, and end-to-end coverage.
- Maintained for compatibility with existing Jest infrastructure.

CI/CD Platform
- GitHub Actions + Vercel
- Automated build ? lint ? test ? deploy pipeline.
- Includes protected branches, preview environments, and environment-specific deploy hooks.

Documentation
- /docs directory aligned with Blueprint Layers 0<ETH>6.
- Organized into /adr, /process, and /blueprint sub-directories.
- Maintains traceability across all architectural layers.

Version Control Discipline
- Conventional Commits enforced via Husky + Commitlint.
- PR titles must follow Conventional Commit syntax and reference ADR IDs for cross-layer or breaking changes.

Governance
- All foundational or major version changes require a new ADR revision referencing this baseline.
- Reviewed quarterly as part of Layer 0 maintenance and upon major dependency upgrades.

Alternatives Considered
- Next.js 15 Ñ rejected for deprecated caching defaults and partial Turbopack support.
- Node 20 LTS Ñ rejected due to missing Web Streams and diagnostic channel improvements.
- pnpm 9.x Ñ rejected for slower lifecycle scripts and weaker workspace handling.
- Vitest Ñ rejected to maintain Jest stability and alignment with existing test infrastructure.

Version Governance
Baseline versions enforced for Synct v0.2:
- Node: v24 LTS
- TypeScript: v5.6
- React: v19.0.0
- Next.js: v16.0.0
- pnpm: v10+

These baselines apply across all development, CI, and deployment environments.
Patch or minor upgrades may merge through PR review if non-breaking.
Major upgrades (e.g., Next 17 or Node 26) require a new ADR revision.

Consequences

Positive Outcomes
- Modernized runtime and caching alignment with React 19 + Next 16.
- Predictable build pipeline through stable Turbopack.
- Faster CI and local dev cycles with pnpm 10 and Jest optimizations.
- Explicit caching control via "use cache" and PPR semantics.
- Future-proof Node 24 LTS baseline ensures consistent ESM behavior.

Risks / Tradeoffs
- Requires re-validation of existing caching logic and SSR assumptions.
- Turbopack plugin ecosystem still maturing.
- Migration effort for integrating Jest coverage with Turbopack-based builds.

References
- /docs/architecture/stack.md
- /docs/layers/00-system-initialization/full-initialization-order.md
- /docs/process/adr-template.md
- /docs/blueprint/blueprint-v1.13.md
- Next.js 16 Release Notes
- Node 24 LTS Changelog
- pnpm v10 Release Notes
