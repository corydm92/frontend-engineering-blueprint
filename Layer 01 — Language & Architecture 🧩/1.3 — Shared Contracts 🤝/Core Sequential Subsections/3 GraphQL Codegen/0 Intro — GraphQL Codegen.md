# GraphQL Codegen — Summary

This subsection covers schema‑first contract generation with GraphQL.

## Intro Note — What This Tool Is For

GraphQL Codegen is the “type factory” for GraphQL systems. It generates
types, hooks, and operation artifacts directly from your GraphQL schema.

**Use it when you have a GraphQL API** and want type safety without manual
duplication:

- Frontend operations stay in sync with the backend schema
- Queries and mutations get strongly typed inputs and outputs
- API changes surface at build time instead of runtime

**What it solves**: prevents drift between your schema and client code.

**How it solves it**: codegen reads the schema and your operations, then emits
TypeScript types (and optionally hooks or SDKs) that match exactly.
