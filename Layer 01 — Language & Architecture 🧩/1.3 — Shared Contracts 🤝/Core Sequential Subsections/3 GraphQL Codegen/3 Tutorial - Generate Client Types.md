# Tutorial — Generate Client Types 🧪

## Scenario

You need typed operations from a GraphQL schema.

## Task

- Configure codegen.
- Run generation.
- Import generated types.

## Hints

- The output file should live in `src/generated`.
- Import types, not runtime values.

## Starter

Frontend example — File: `@app/src/graphql/codegen.yml`

```yml
schema: ./src/graphql/schema.graphql
generates:
  ./src/generated/graphql.ts:
    plugins:
      - typescript
      - typescript-operations
```

## Answer

Frontend example — File: `@app/src/graphql/queries/getUser.ts`

```ts
import type { GetUserQuery } from '../generated/graphql';
```

Frontend example — File: `@app/src/generated/graphql.ts`

```ts
export type GetUserQuery = {
  user: { id: string; email: string };
};
```
