# Tutorial — Contract Registry 🧪

## Scenario

You want a single place to access input/output schemas for endpoints.

## Task

- Define `createPost` and `updatePost` input schemas.
- Define their output schemas.
- Export a typed registry object.

## Hints

- Use `as const` to keep registry keys literal.
- Use `partial()` for update inputs.

## Starter

Backend example — File: `@api/src/contracts/registry.ts`

```ts
import { z } from 'zod';

const PostBase = z.object({
  id: z.string(),
  title: z.string(),
  body: z.string(),
});

// TODO: create CreatePostInput and UpdatePostInput
// TODO: create CreatePostOutput and UpdatePostOutput

// TODO: export ContractRegistry with createPost/updatePost entries
```

## Answer

Backend example — File: `@api/src/contracts/registry.ts`

```ts
import { z } from 'zod';

const PostBase = z.object({
  id: z.string(),
  title: z.string(),
  body: z.string(),
});

const CreatePostInput = PostBase.omit({ id: true });
const UpdatePostInput = PostBase.partial();

const CreatePostOutput = PostBase.pick({ id: true, title: true });
const UpdatePostOutput = PostBase.pick({ id: true, title: true, body: true });

export const ContractRegistry = {
  createPost: { input: CreatePostInput, output: CreatePostOutput },
  updatePost: { input: UpdatePostInput, output: UpdatePostOutput },
} as const;
```
