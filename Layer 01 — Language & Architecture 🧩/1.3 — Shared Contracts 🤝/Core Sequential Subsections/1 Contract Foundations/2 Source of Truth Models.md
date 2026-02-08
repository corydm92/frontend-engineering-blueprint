# Source of Truth Models 🧭

## Goal

Choose how contracts are shared across systems.

## What you learn

- Backend‑authored schemas
- Monorepo shared packages
- Schema‑first workflows (GraphQL/OpenAPI)

## Explanation

“Source of truth” answers a practical question: where do contract changes start, and how do they propagate to consumers?
You want one place where the contract is authored and reviewed, and a predictable mechanism for distributing updates.

Common models:

- Backend-authored schemas: the backend defines the contract (often as runtime schemas), and clients consume the exported types.
  Use this when the backend is the primary producer and you want runtime validation close to the network boundary.
- Monorepo shared packages: contracts live in a shared package that both backend and frontend import.
  Use this when you control a monorepo and want a single dependency that keeps multiple apps aligned.
- Schema-first workflows (GraphQL/OpenAPI): the schema is the canonical artifact, and codegen produces types/clients.
  Use this when the schema itself is the contract and you want strong tooling support for diffing and generation.

Pick the model that matches your organizational ownership and your release process. The “best” model is the one you can enforce.

## Example

Backend doc example — File: `@app/src/contracts/MODEL.md`

```md
Model: Backend‑authored Zod schemas
Consumers: Frontend and services
```

## Pitfalls

- Having multiple “sources of truth” creates subtle drift and inconsistent types.
- Picking a model you can’t enforce (no ownership, no CI checks) leads to contracts that rot over time.
