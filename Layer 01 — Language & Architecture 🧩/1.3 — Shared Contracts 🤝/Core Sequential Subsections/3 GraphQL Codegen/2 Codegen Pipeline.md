# Codegen Pipeline 🧬

## Goal

Generate types from schema into client code.

## What you learn

- Codegen output should be stable.
- Generated types are used in client code.

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
