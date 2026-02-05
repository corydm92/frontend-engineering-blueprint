# Refinements and Custom Errors 🧪

## Goal

Enforce rules that go beyond built‑in validators.

## What you learn

- `refine` handles single‑value validation.
- `superRefine` handles cross‑field validation and custom paths.

## Explanation

Built‑in validators handle most constraints, but business rules often require
**custom logic**. Use `refine` for simple checks (e.g., “must include @”). Use
`superRefine` when you need to compare multiple fields or attach errors to a
specific path.

## Example

Backend example — File: `@api/src/schemas/password.ts`

```ts
import { z } from 'zod';

export const PasswordSchema = z
  .object({
    password: z.string().min(8),
    confirm: z.string().min(8),
  })
  .superRefine((val, ctx) => {
    if (val.password !== val.confirm) {
      ctx.addIssue({
        code: z.ZodIssueCode.custom,
        path: ['confirm'],
        message: 'Passwords must match',
      });
    }
  });
```

## Pitfalls

- Using `refine` when you need access to multiple fields.
- Forgetting to set `path` leads to unhelpful errors.
