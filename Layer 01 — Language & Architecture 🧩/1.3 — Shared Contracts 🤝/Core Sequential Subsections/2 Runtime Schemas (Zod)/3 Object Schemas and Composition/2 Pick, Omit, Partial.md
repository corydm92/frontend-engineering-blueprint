# Pick, Omit, and Partial ✂️

## Goal

Derive new object schemas from a base contract.

## What you learn

- `pick` selects a subset of keys.
- `omit` removes keys.
- `partial` makes all fields optional.

## Explanation

A single base schema can generate multiple **view‑specific** schemas. Use `pick`
for card or list views, `omit` to hide private fields, and `partial` for update
forms or PATCH endpoints. This keeps contracts consistent while avoiding
duplication.

## Example

Frontend example — File: `@app/src/schemas/user.ts`

```ts
import { z } from 'zod';

const UserSchema = z.object({
  id: z.string(),
  email: z.string().email(),
  name: z.string(),
  bio: z.string().optional(),
});

export const UserCardSchema = UserSchema.pick({ id: true, name: true });
export const UserUpdateSchema = UserSchema.partial();
```

## Pitfalls

- Using `partial` for create flows (it can hide missing required fields).
- Over‑picking fields and losing important validation rules.
