# Codegen Pipeline 🧬

## Goal

Generate types from schema into client code.

## What you learn

- Codegen output should be stable.
- Generated types are used in client code.

## Explanation

The codegen pipeline turns two inputs into code: the GraphQL schema and the operations (queries/mutations) your client writes.
If either input changes, the generated output should change in a predictable way, in a predictable location.

“Stable output” is an architecture decision: pick one generated file (or folder) and treat it as an artifact.
Consumers should import from the generated surface, not from schema internals or ad-hoc handwritten types.

The simplest reliable pipeline is:

1. Point codegen at the canonical schema.
2. Point codegen at the set of client operations.
3. Generate types to a single file path and commit or cache it according to your workflow.

## Example

Frontend example — File: `@app/src/graphql/codegen.yml`

```yml
schema: ./src/graphql/schema.graphql
generates:
  ./src/generated/graphql.ts:
    plugins:
      - typescript
      - typescript-operations
```

## Pitfalls

- Generating to multiple locations makes imports inconsistent and refactors painful.
- Handwriting types alongside generated code reintroduces drift.
