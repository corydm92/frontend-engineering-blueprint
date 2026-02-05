# Tutorial — Safe Contract Migration 🧪

## Scenario

You need to add a required field without breaking clients.

## Task

- Introduce the field as optional.
- Release and update consumers.
- Make it required in the next major version.

## Hints

- Optional first, required later.
- Document the migration window.

## Starter

Backend example — File: `@app/src/contracts/user.ts`

```ts
import { z } from 'zod';

// TODO: add optional role in v1
export const UserSchema = z.object({
  id: z.string(),
  email: z.string().email(),
});
```

## Answer

Backend example — File: `@app/src/contracts/user.ts`

```ts
import { z } from 'zod';

export const UserSchema = z.object({
  id: z.string(),
  email: z.string().email(),
  role: z.string().optional(),
});
```
