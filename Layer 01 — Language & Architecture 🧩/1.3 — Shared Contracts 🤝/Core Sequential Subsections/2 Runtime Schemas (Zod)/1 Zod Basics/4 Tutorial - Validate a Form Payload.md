# Tutorial — Validate a Form Payload 🧪

## Scenario

You have a post creation form and need to validate user input before submit.

## Task

- Define a post schema.
- Validate values with `safeParse`.
- Return `error.flatten()` on failure.
- Return `null` on success.

## Hints

- Use `z.object(...)` for the schema.
- `safeParse` returns `{ success, data, error }`.
- `flatten()` is built for form errors.

## Starter

Frontend example — File: `@app/src/forms/usePostForm.ts`

```ts
import { z } from 'zod';

const PostSchema = z.object({
  id: z.number(),
  title: z.string(),
  body: z.string(),
});

export function validateForm(values: unknown) {
  // TODO: safeParse values
  // TODO: return parsed.error.flatten() on failure
  // TODO: return null on success
}
```

## Answer

Frontend example — File: `@app/src/forms/usePostForm.ts`

```ts
import { z } from 'zod';

const PostSchema = z.object({
  id: z.number(),
  title: z.string(),
  body: z.string(),
});

export function validateForm(values: unknown) {
  const parsed = PostSchema.safeParse(values);
  if (!parsed.success) return parsed.error.flatten();
  return null;
}
```
