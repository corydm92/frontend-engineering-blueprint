# Error Shapes and Formatting 🧯

## Goal

Turn Zod errors into shapes your UI or API can use.

## What you learn

- `error.issues` is a flat list of failures with paths.
- `format()` produces a nested object mirroring your schema.
- `flatten()` produces field/form error maps for UI forms.

## Explanation

Zod errors are structured data. Each issue contains a `path`, a `code`, and a
message. `format()` is ideal for nested forms because it mirrors the shape of the
schema. `flatten()` is ideal for flat UIs because it returns `fieldErrors` and
`formErrors` in a single object.

Consistent error shaping is a big part of shared contracts: it ensures your UI or
API consumers get predictable failure formats.

## Example — `format()` (nested)

Frontend example — File: `@app/src/lib/zodErrors.ts`

```ts
import { z } from "zod";

const PostSchema = z.object({
  meta: z.object({
    title: z.string().min(1),
    slug: z.string().min(1),
  }),
  body: z.string().min(1),
});

export function toNestedErrors(input: unknown) {
  const parsed = PostSchema.safeParse(input);
  if (!parsed.success) return parsed.error.format();
  return null;
}
```

## Example — `flatten()` (field errors)

Frontend example — File: `@app/src/lib/zodErrors.ts`

```ts
import { z } from "zod";

const PostSchema = z.object({
  title: z.string().min(1),
  body: z.string().min(1),
});

export function toFieldErrors(input: unknown) {
  const parsed = PostSchema.safeParse(input);
  if (!parsed.success) return parsed.error.flatten();
  return null;
}
```

## Pitfalls

- Rendering `issues` directly is noisy for end users.
- Dropping paths makes it hard to associate errors to fields.
