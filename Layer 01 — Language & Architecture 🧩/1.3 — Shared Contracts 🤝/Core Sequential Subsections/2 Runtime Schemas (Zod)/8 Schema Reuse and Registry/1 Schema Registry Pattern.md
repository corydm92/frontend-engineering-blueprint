# Schema Registry Pattern 🗂️

## Goal

Centralize contracts so they are discoverable and reusable.

## What you learn

- A registry groups related input/output schemas.
- `as const` keeps registry keys type‑safe.

## Explanation

A registry is a single export that **names and groups** schemas by purpose
(endpoints, features, or modules). This reduces hunting for definitions and makes
contract usage explicit across the codebase.

## Example

Backend example — File: `@api/src/contracts/registry.ts`

```ts
import { z } from 'zod';

const CreatePostInput = z.object({
  title: z.string(),
  body: z.string(),
});

const CreatePostOutput = z.object({
  id: z.string(),
  title: z.string(),
});

export const ContractRegistry = {
  createPost: {
    input: CreatePostInput,
    output: CreatePostOutput,
  },
} as const;
```

## Pitfalls

- Spreading schemas across files without a clear index.
- Renaming registry keys without updating consumers.
