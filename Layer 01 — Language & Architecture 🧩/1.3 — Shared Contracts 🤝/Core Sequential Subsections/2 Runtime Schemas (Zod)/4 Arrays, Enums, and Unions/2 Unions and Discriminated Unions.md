# Unions and Discriminated Unions 🔀

## Goal

Model variant shapes cleanly and safely.

## What you learn

- `z.union` allows multiple possible shapes.
- `z.discriminatedUnion` selects by a shared field.

## Explanation

Unions let a value be one of several shapes. When all variants share a `type` (or
similar) field, `z.discriminatedUnion` is safer and faster — it picks the schema
based on that discriminator and gives better errors.

Use discriminated unions for API responses that have success/error branches or
variant payloads.

## Example

Backend example — File: `@api/src/schemas/response.ts`

```ts
import { z } from 'zod';

const Success = z.object({
  type: z.literal('success'),
  data: z.object({ id: z.string() }),
});

const Failure = z.object({
  type: z.literal('error'),
  message: z.string(),
});

export const ResponseSchema = z.discriminatedUnion('type', [Success, Failure]);
```

## Pitfalls

- Using `z.union` when a discriminator exists.
- Forgetting to keep discriminator values unique.
