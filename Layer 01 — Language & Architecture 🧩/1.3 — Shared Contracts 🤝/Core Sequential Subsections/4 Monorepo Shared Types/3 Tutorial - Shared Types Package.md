# Tutorial — Shared Types Package 📦

## Scenario

You want multiple apps to import the same contract package.

## Task

- Add the contracts package as a dependency.
- Import a shared type.

## Hints

- Use workspace version ranges.
- Import types from `@app/contracts`.

## Starter

Monorepo example — File: `@app/apps/web/package.json`

```json
{
  "dependencies": {
    "@app/contracts": "*"
  }
}
```

## Answer

Monorepo example — File: `@app/packages/contracts/src/user.ts`

```ts
export type User = { id: string; email: string };
```

Monorepo example — File: `@app/apps/web/src/types.ts`

```ts
import type { User } from "@app/contracts";
```
