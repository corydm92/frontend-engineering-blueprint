# Type‑Driven Schemas with `satisfies` 🧷

## Goal

Enforce that a schema matches an existing TypeScript type.

## What you learn

- `satisfies z.ZodType<T>` validates schema‑to‑type alignment.
- The runtime schema still controls validation logic.

## Explanation

Sometimes you already have a type (from a design doc or contract) and want to
ensure the Zod schema stays aligned. `satisfies z.ZodType<T>` gives you compile‑time
checks without changing runtime behavior.

## Example

Frontend example — File: `@app/src/schemas/post.ts`

```ts
import { z } from 'zod';

type Post = {
  id: string;
  title: string;
  body: string;
};

export const PostSchema = z
  .object({
    id: z.string(),
    title: z.string(),
    body: z.string(),
  })
  satisfies z.ZodType<Post>;
```

## Pitfalls

- Using `satisfies` without keeping the runtime schema accurate.
- Forgetting that transforms change output types.
