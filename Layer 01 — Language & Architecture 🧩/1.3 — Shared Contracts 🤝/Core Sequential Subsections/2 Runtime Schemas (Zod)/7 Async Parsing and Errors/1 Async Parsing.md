# Async Parsing ⏳

## Goal

Validate input with asynchronous checks.

## What you learn

- `parseAsync` / `safeParseAsync` await async refinements.
- Async checks are required for uniqueness or external lookups.

## Explanation

Some validation depends on I/O — for example, checking whether a username is
available or verifying a record exists. In these cases, your schema should include
async refinements and you must use `parseAsync` or `safeParseAsync` so those checks
are awaited.

## Example

Backend example — File: `@api/src/schemas/username.ts`

```ts
import { z } from "zod";

async function isUsernameAvailable(value: string) {
  return value !== "admin";
}

const UsernameSchema = z
  .string()
  .min(3)
  .refine(async (val) => isUsernameAvailable(val), {
    message: "Username is taken",
  });

export async function validateUsername(input: unknown) {
  return UsernameSchema.safeParseAsync(input);
}
```

## Pitfalls

- Calling `parse` instead of `parseAsync` when refinements are async.
- Forgetting to handle promise rejections in the caller.
