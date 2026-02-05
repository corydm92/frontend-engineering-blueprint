# Object Schemas and Unknown Keys 🧱

## Goal

Control how Zod handles extra fields on objects.

## What you learn

- `z.object` defines the allowed shape.
- Unknown keys are **stripped** by default.
- `.strict()` errors on unknown keys, `.passthrough()` keeps them.

## Explanation

Object schemas define **exact contracts** for input. By default, Zod strips unknown
keys, which is good for sanitizing input. If you need to **reject** unknown keys
(security, API validation), use `.strict()`. If you need to **preserve** unknown
keys (e.g., storing extra metadata), use `.passthrough()`.

These choices are architecture decisions — make them explicit in your contracts.

## Example

Backend example — File: `@api/src/schemas/profile.ts`

```ts
import { z } from "zod";

export const ProfileSchema = z
  .object({
    id: z.string(),
    name: z.string(),
  })
  .strict();
```

## Pitfalls

- Using `.passthrough()` when you meant strict validation.
- Relying on default strip behavior without documenting it.
