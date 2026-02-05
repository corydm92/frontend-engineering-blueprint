# Coercion and Defaults 🔁

## Goal

Normalize string inputs and apply safe defaults.

## What you learn

- `z.coerce` converts strings into numbers/booleans.
- Defaults stabilize missing values.
- Validation still matters after coercion.

## Explanation

User input often arrives as strings (URL params, form fields). `z.coerce` lets you
convert those into the correct type without manual parsing. After coercion, you
should still apply constraints (`min`, `max`, `int`) to prevent invalid values.

Defaults are a **contract decision**: they define what your system assumes when a
value is missing. Use them when you want predictable behavior and document them
clearly in shared contracts.

## Example

Frontend example — File: `@app/src/schemas/query.ts`

```ts
import { z } from 'zod';

export const QuerySchema = z.object({
  page: z.coerce.number().int().min(1).default(1),
  pageSize: z.coerce.number().int().max(100).default(20),
  sort: z.enum(['new', 'top']).default('new'),
});
```

## Pitfalls

- Coercion can hide invalid input if you skip validation.
- Defaults can mask missing data if overused.
