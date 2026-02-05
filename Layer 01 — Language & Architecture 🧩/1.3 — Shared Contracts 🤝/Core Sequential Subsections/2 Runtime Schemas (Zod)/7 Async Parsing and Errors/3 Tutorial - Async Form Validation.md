# Tutorial — Async Form Validation 🧪

## Scenario

Your signup form needs to verify a username is available.

## Task

- Add an async refinement for username availability.
- Use `safeParseAsync` to validate input.
- Return `{ ok, data | errors }`.

## Hints

- `refine` can return a Promise.
- Use `safeParseAsync` instead of `safeParse`.

## Starter

Frontend example — File: `@app/src/lib/validateSignup.ts`

```ts
import { z } from 'zod';

async function isUsernameAvailable(value: string) {
  return value !== 'admin';
}

const SignupSchema = z.object({
  username: z.string().min(3),
  email: z.string().email(),
});

export async function validateSignup(input: unknown) {
  // TODO: add async refinement for username availability
  // TODO: safeParseAsync input
  // TODO: return { ok: true, data } or { ok: false, errors }
}
```

## Answer

Frontend example — File: `@app/src/lib/validateSignup.ts`

```ts
import { z } from 'zod';

async function isUsernameAvailable(value: string) {
  return value !== 'admin';
}

const SignupSchema = z
  .object({
    username: z.string().min(3),
    email: z.string().email(),
  })
  .superRefine(async (val, ctx) => {
    const ok = await isUsernameAvailable(val.username);
    if (!ok) {
      ctx.addIssue({
        code: z.ZodIssueCode.custom,
        path: ['username'],
        message: 'Username is taken',
      });
    }
  });

export async function validateSignup(input: unknown) {
  const parsed = await SignupSchema.safeParseAsync(input);
  if (!parsed.success) return { ok: false, errors: parsed.error.flatten() };
  return { ok: true, data: parsed.data };
}
```
