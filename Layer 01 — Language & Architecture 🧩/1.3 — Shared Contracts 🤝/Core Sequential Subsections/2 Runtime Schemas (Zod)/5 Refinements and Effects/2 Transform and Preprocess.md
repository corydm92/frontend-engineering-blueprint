# Transform and Preprocess 🔧

## Goal

Normalize or reshape data as part of validation.

## What you learn

- `transform` changes the output after validation.
- `preprocess` normalizes raw input before validation.

## Explanation

Use `transform` when you want to **derive** new output (e.g., trimming or
lowercasing). Use `preprocess` when the raw input isn’t the correct type (e.g.,
parsing a string into a number before validating it).

These are contracts too — by defining them in the schema, every consumer gets the
same normalized behavior.

## Example

Frontend example — File: `@app/src/schemas/search.ts`

```ts
import { z } from "zod";

export const SearchSchema = z.object({
  query: z
    .string()
    .min(1)
    .transform((value) => value.trim().toLowerCase()),
  page: z.preprocess((val) => Number(val), z.number().int().min(1).default(1)),
});
```

## Pitfalls

- Transforming data without documenting the new shape.
- Using `preprocess` without guarding against invalid input.
