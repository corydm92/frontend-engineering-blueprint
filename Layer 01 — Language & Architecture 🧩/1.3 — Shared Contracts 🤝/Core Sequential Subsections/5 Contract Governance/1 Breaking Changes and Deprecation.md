# Breaking Changes and Deprecation 🚧

## Goal

Define how breaking changes are introduced safely.

## What you learn

- Deprecation windows reduce breakage.
- Breaking changes require explicit migration paths.

## Explanation

Breaking changes are unavoidable over the lifetime of a system, but surprise breaking changes are optional.
Deprecation is how you turn a break into a planned migration: you keep the old behavior working for a window, mark it as legacy, and provide a clear path forward.

A safe breaking change process usually includes:

1. Deprecate (add warnings, docs, and migration guidance).
2. Provide a compatibility window (dates or versions).
3. Remove in a major version (or after the removal date).

The key is that consumers can predict when they must act, and they have enough information to act quickly.

## Example

Backend example — File: `@app/src/contracts/user.ts`

```ts
import { z } from "zod";

export const UserSchema = z.object({
  id: z.string(),
  email: z.string().email(),
  role: z.string().optional(),
});
```

## Pitfalls

- Deprecating without a migration path turns the removal into a fire drill.
- Keeping deprecated behavior forever creates permanent complexity and prevents cleanup.
