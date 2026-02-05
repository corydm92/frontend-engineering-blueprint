# Parsing and Safe Parsing ✅

## Goal

Learn when to use `parse` vs `safeParse`.

## What you learn

- `parse` throws on invalid input (fail‑fast).
- `safeParse` returns a result object (UI‑friendly).
- Both paths run the same validation + transforms.

## Explanation

`parse` is the strict path: it throws a `ZodError` immediately when input is
invalid. Use it in backend or batch flows where you want failures to stop
execution and bubble up to monitoring.

`safeParse` is the tolerant path: it returns `{ success, data, error }`. Use it
when you need to **render** errors (forms, client validation, API responses) and
keep the application running.

## Example — `parse` (throws)

Backend example — File: `@api/src/lib/validation.ts`

```ts
import { z } from 'zod';

const PostSchema = z.object({
  id: z.number(),
  title: z.string(),
  body: z.string(),
});

export function parsePostOrThrow(input: unknown) {
  return PostSchema.parse(input);
}
```

## Example — `safeParse` (result object)

Frontend example — File: `@app/src/lib/validation.ts`

```ts
import { z } from 'zod';

const PostSchema = z.object({
  id: z.number(),
  title: z.string(),
  body: z.string(),
});

export function validatePost(input: unknown) {
  const parsed = PostSchema.safeParse(input);
  if (!parsed.success) {
    return { ok: false, errors: parsed.error.format() };
  }
  return { ok: true, data: parsed.data };
}
```

## Pitfalls

- Using `parse` in UI flows can crash rendering.
- Swallowing `safeParse` errors hides invalid data.
