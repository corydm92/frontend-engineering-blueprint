# Zod Setup and First Schema 🧰

## Goal

Create your first schema and understand runtime validation.

## What you learn

- Zod schemas validate **unknown input at runtime**.
- Types can be derived from schemas to stay aligned.
- Schemas belong at **system boundaries** (forms, APIs, webhooks).

## Explanation

A Zod schema is both a **validator** and a **type source**. It lives at runtime and
can accept unknown values, then either parse them into a safe shape or explain
exactly why they’re invalid. This is the safest way to prevent untrusted input from
leaking into application logic.

Start by defining schemas for the data you receive most often (forms, API payloads).
Keep them in a dedicated `schemas/` module so validation stays discoverable and
re‑usable.

## Architecture Notes

- Store schemas in a single place: `@app/src/schemas/`.
- Export from a barrel (`@app/src/schemas/index.ts`) to keep imports clean.

## Example

Frontend example — File: `@app/src/schemas/post.ts`

```ts
import { z } from 'zod';

export const PostSchema = z.object({
  id: z.number(),
  title: z.string(),
  body: z.string(),
});

export type Post = z.infer<typeof PostSchema>;
```

## Pitfalls

- Using TypeScript types **without** runtime validation defeats the purpose.
- Defining schemas far from boundaries increases drift and duplication.
