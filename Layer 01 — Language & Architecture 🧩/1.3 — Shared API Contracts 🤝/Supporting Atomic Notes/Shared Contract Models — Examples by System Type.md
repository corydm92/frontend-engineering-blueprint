Shared Contract Models — Examples by System Type

⸻

🧩 Same-Language Monorepo (e.g., TypeScript full-stack with tRPC or Next.js API)

Goal: zero drift between client and server — one type system, one runtime.

Pattern:
• Define contracts directly in code (/packages/api or /contracts workspace).
• Export type definitions or procedures that both front- and backend import.
• Use tRPC / Zod / TypeBox for schema + runtime validation.
• CI enforces shared build — any breaking change fails dependent builds.

Example structure:

/packages
/contracts
index.ts // shared Zod schemas + types
/frontend
/backend

Result: full type inference; no serialization mismatch.
Trade-off: tightly coupled — upgrades ripple instantly through all packages.

⸻

🔗 Different-Language Monorepo (e.g., Java + TypeScript in one repo)

Goal: maintain language autonomy but shared contract source.

Pattern:
• Keep schema in a neutral format (OpenAPI YAML, GraphQL SDL, Protobuf).
• Generate language-specific clients in CI.
• Commit generated clients under /generated or build on-demand.
• Use schema-linting + diff-tools to detect drift (spectral, graphql-inspector).

Example structure:

/contracts
openapi.yaml
/backend-java
src/main/java/... // generates models via openapi-generator
/frontend-ts
/generated // types from openapi-typescript

Result: consistent API across languages; one schema as the truth.
Trade-off: slower iteration — schema change → regen → rebuild both sides.

⸻

⚙️ Same-Language Microservices (e.g., multiple Node services + TS frontend)

Goal: enforce consistency without central monolith.

Pattern:
• Publish shared contract package to internal registry (@org/contracts).
• Version semantically; dependent services pin to version.
• Changes require bump + changelog.
• CI verifies consumer services use compatible contract versions.

Example:

npm publish @org/contracts@1.2.0
frontend → ^1.2.0
orders-service → ^1.2.0

Result: modular but type-safe network.
Trade-off: version churn — consumers must upgrade intentionally.

⸻

🌐 Different-Language Microservices (e.g., Java API ↔ TypeScript frontend ↔ Python analytics)

Goal: language-agnostic interoperability.

Pattern:
• Define schema once (OpenAPI, GraphQL, or gRPC Protobuf).
• Store it in a central “API-contracts” repo.
• Each service generates its stubs/types during build.
• CI enforces backward compatibility via schema diff checks.

Example:

/api-contracts
graphql/
schema.graphql
fragments/
openapi/
v1.yaml

Tooling: graphql-codegen, openapi-generator, buf (for gRPC).

Result: fully decoupled polyglot system with strict interface governance.
Trade-off: extra pipeline complexity — contracts behave like versioned APIs, not inline types.

⸻

Summary

Scenario Contract Medium Type Safety Coupling Typical Tools
Same-Lang Monorepo In-code (Zod/tRPC) Direct inference Tight tRPC, Zod
Diff-Lang Monorepo Schema file + codegen Generated Moderate OpenAPI, GraphQL
Same-Lang Microservice Published package Strong Moderate npm pkg + CI gates
Diff-Lang Microservice Schema repo + codegen Generated Loose OpenAPI, GraphQL, gRPC

⸻

These notes plug neatly under your Blueprint’s “Shared API Contracts 🤝” section and clarify which model to choose based on team topology and language boundary.