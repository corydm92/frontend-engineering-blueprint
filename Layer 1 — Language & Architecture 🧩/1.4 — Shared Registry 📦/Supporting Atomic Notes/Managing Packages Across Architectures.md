Managing Packages Across Architectures


1. Mental Model

A shared registry synchronizes reusable assets (types, utilities, SDKs) across systems.
Its goal is versioned reuse with automation, visibility, and ownership.
Without governance, shared code becomes duplication.

------------------------------------------------------------

2. Same Language „ Monorepo (Frontend + Node API)

Structure:
repo-root/
?? apps/
? ?? web/ ? React app
?
??
api/ ? Node.js / Express service
?? packages/
? ?? ui/ ? shared component library
? ?? utils/ ? shared logic and helpers
? ?? types/ ? shared TypeScript contracts (frontend + API)
?
??
config/ ? shared runtime/env config loader
?? pnpm-workspace.yaml

??
tsconfig.base.json

Mechanics:
- The entire sy
stem shares one workspace and one lockfile.
- Packages under /packages are symlinked automatically by pnpm or Nx.
- Both frontend and API consume shared code directly:
import { validateUser } from "@org/utils"
import { UserDTO } from "@org/types"
- Each package defines its own name and version but doesnÍt need to publish to a registry.
- CI detects affected graphs to rebuild only impacted apps.
- Optionally, publish selected packages to an internal registry if other repos will consume them.

Why it works:
- Unified dependency graph across frontend and API.
- Shared TypeScript config ensures type safety across boundaries.
- Immediate local feedback with zero publish overhead.
- Optional publishing for teams or services outside the monorepo.

Reference:
(monorepo nodejs react shared packages pnpm workspaces)

------------------------------------------------------------

3. Same Language „ Split Repo

Structure:
shared-libs/ ? publishes shared packages
frontend-app/ ? consumes versioned packages
backend-services/ ? optional consumer

Mechanics:
- Shared code lives in a dedicated repo, published to an internal registry.
- CI automates test ? build ? semantic version ? publish.
- Downstream repos install fixed versions (e.g., "@org/shared-libs@1.4.2").
- Renovate or Dependabot update dependencies automatically.

Why it works:
- Explicit version contracts between repos.
- Decoupled pipelines with visible semver bumps.
- Rollbacks and auditability through registry history.

Reference:
(split repo internal npm registry setup)

------------------------------------------------------------

4. Different Language „ Monorepo

Structure:
repo-root/
?? frontend/ ? React + TypeScript
?? backend/ ? Java, Go, or Python service
?? contracts/ ? OpenAPI / GraphQL schemas

??
ci.yml

Mechanics:
- Backend defines source-of-truth schema in /contracts.
- CI generates TypeScript SDK (openapi-generator, protobuf, etc.).
- Frontend imports generated client from local path.
- Shared CI ensures synchronized schema versioning.

Why it works:
- Single repo = unified truth for contracts.
- Atomic commits sync schema and code.
- No registry required unless consumed externally.

Reference:
(monorepo openapi codegen workflow frontend backend)

------------------------------------------------------------

5. Different Language „ Split Repo

Structure:
backend-service/ ? owns OpenAPI spec
frontend-app/ ? consumes generated SDK
internal-registry/ ? hosts published SDK

Mechanics:
- Backend CI generates TypeScript SDK and publishes to internal npm registry.
- Frontend depends on versioned SDK (e.g., "@org/contracts@1.2.0").
- Frontend CI validates schema drift automatically.
- Changes trigger coordinated pipeline (backend ? registry ? frontend).

Why it works:
- Cross-language boundaries with explicit ownership.
- Automated SDK generation and version control.
- Consistent, reproducible contract validation across repos.

Reference:
(cross language api contract codegen npm maven pipeline)

------------------------------------------------------------

6. Key Takeaways

- Monorepo: share everything locally; publish only when others depend on it.
- Split Repo: publish to internal registry for versioned reuse.
- Different Language: rely on schema codegen and CI validation.
- CI + semantic versioning keep shared systems stable and observable.

One-liner summary:
A shared registry turns internal code into a governed ecosystem „
local for iteration, published for scale, automated for safety.
