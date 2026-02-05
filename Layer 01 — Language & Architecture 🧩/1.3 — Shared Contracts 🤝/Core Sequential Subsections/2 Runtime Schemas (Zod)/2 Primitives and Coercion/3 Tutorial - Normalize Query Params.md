# Tutorial — Normalize Query Params 🧪

## Scenario

Your list page reads query params from the URL and needs consistent types.

## Task

- Define a schema that coerces `page` and `pageSize` to numbers.
- Provide defaults for `page`, `pageSize`, and `sort`.
- Return `{ ok: true, data }` on success and `{ ok: false, errors }` on failure.

## Hints

- Use `z.coerce.number()` for string inputs.
- Use `.default(...)` for missing values.
- `safeParse` gives you `{ success, data, error }`.

## Starter

Frontend example — File: `@app/src/lib/normalizeQuery.ts`

```ts
import { z } from "zod";

const QuerySchema = z.object({
  page: z.coerce.number().int().min(1).default(1),
  pageSize: z.coerce.number().int().max(100).default(20),
  sort: z.enum(["new", "top"]).default("new"),
});

export function normalizeQuery(input: unknown) {
  // TODO: safeParse input
  // TODO: return { ok: true, data } on success
  // TODO: return { ok: false, errors } on failure
}
```

## Answer

Frontend example — File: `@app/src/lib/normalizeQuery.ts`

```ts
import { z } from "zod";

const QuerySchema = z.object({
  page: z.coerce.number().int().min(1).default(1),
  pageSize: z.coerce.number().int().max(100).default(20),
  sort: z.enum(["new", "top"]).default("new"),
});

export function normalizeQuery(input: unknown) {
  const parsed = QuerySchema.safeParse(input);
  if (!parsed.success) return { ok: false, errors: parsed.error.flatten() };
  return { ok: true, data: parsed.data };
}
```
