# Tutorial — Normalize and Validate Input 🧪

## Scenario

Your search form sends raw strings and you want normalized output for the app.

## Task

- Trim and lowercase the search query.
- Coerce `page` into a number with a default.
- Return `{ ok, data | errors }` using `safeParse`.

## Hints

- Use `.transform(...)` to normalize a string.
- Use `z.preprocess(...)` to coerce raw input.

## Starter

Frontend example — File: `@app/src/lib/normalizeSearch.ts`

```ts
import { z } from "zod";

const SearchSchema = z.object({
  query: z.string().min(1),
  page: z.number().int().min(1).default(1),
});

export function normalizeSearch(input: unknown) {
  // TODO: update schema to transform + preprocess
  // TODO: safeParse input
  // TODO: return { ok: true, data } or { ok: false, errors }
}
```

## Answer

Frontend example — File: `@app/src/lib/normalizeSearch.ts`

```ts
import { z } from "zod";

const SearchSchema = z.object({
  query: z
    .string()
    .min(1)
    .transform((value) => value.trim().toLowerCase()),
  page: z.preprocess((val) => Number(val), z.number().int().min(1).default(1)),
});

export function normalizeSearch(input: unknown) {
  const parsed = SearchSchema.safeParse(input);
  if (!parsed.success) return { ok: false, errors: parsed.error.flatten() };
  return { ok: true, data: parsed.data };
}
```
