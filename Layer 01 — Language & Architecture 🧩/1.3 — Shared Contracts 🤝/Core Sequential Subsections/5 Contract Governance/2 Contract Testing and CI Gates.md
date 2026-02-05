# Contract Testing and CI Gates 🧪

## Goal

Verify contracts in CI to prevent drift.

## What you learn

- Validate schemas against fixtures.
- Fail CI on breaking schema changes.

## Example

Backend example — File: `@app/src/tests/contracts/user.test.ts`

```ts
import { z } from "zod";

const UserSchema = z.object({ id: z.string(), email: z.string().email() });

expect(UserSchema.safeParse({ id: "1", email: "a@b.com" }).success).toBe(true);
```
