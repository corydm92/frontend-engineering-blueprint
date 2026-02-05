# Contract Testing and CI Gates 🧪

## Goal

Verify contracts in CI to prevent drift.

## What you learn

- Validate schemas against fixtures.
- Fail CI on breaking schema changes.

## Explanation

Contracts drift when changes are invisible. CI gates make drift obvious by turning contract violations into failing checks.
The simplest useful gate is: “schemas must still parse known-good fixtures.” That catches accidental breakage immediately.

For larger systems, add a second layer: “breaking changes require explicit approval.” This can be a schema diff check, a version bump requirement, or a migration file.
The point is not perfect automation; it’s making breaking changes intentional and reviewable.

## Example

Backend example — File: `@app/src/tests/contracts/user.test.ts`

```ts
import { z } from "zod";

const UserSchema = z.object({ id: z.string(), email: z.string().email() });

expect(UserSchema.safeParse({ id: "1", email: "a@b.com" }).success).toBe(true);
```

## Pitfalls

- Tests that only check “success” without asserting the parsed shape can miss meaning changes.
- Skipping CI gates forces consumers to discover breakage in production.
