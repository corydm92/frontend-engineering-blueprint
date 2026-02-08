# Composition and Reuse 🔁

## Goal

Reuse base schemas to build feature‑specific variants.

## What you learn

- Base schemas capture shared fields.
- Variants use `extend`, `pick`, or `partial`.

## Explanation

Shared contracts grow quickly. Start with a **base schema** and create variants for
different use cases (create vs update, list vs detail). This keeps logic consistent
and prevents drift.

## Example

Frontend example — File: `@app/src/schemas/post.ts`

```ts
import { z } from "zod";

const PostBase = z.object({
  id: z.string(),
  title: z.string(),
  body: z.string(),
});

export const PostCreate = PostBase.omit({ id: true });
export const PostUpdate = PostBase.partial();
```

## Pitfalls

- Copy‑pasting schemas instead of composing them.
- Forgetting to update all variants when base changes.
