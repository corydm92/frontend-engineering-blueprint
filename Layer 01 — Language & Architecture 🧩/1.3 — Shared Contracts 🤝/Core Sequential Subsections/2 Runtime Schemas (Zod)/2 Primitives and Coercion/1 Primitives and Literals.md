# Primitives and Literals 🧱

## Goal

Model primitive data and exact literal values.

## What you learn

- Primitives (`string`, `number`, `boolean`) are the base of all schemas.
- Literals and enums restrict values to known sets.

## Explanation

Use primitives for general data and literals for **fixed values** such as status
flags, modes, or feature toggles. When you need a **finite set** of allowed values,
use `z.enum` (or `z.nativeEnum` if you already have a TypeScript enum).

Literals are especially useful in unions and discriminated unions because they let
you branch safely by value.

## Example

Frontend example — File: `@app/src/schemas/filters.ts`

```ts
import { z } from 'zod';

export const SortSchema = z.object({
  order: z.enum(['asc', 'desc']),
  includeArchived: z.boolean(),
  mode: z.literal('compact'),
});
```

## Pitfalls

- Over‑using enums can make schemas rigid.
- Using `z.string()` for a finite set weakens validation.
