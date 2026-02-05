# Tutorial — Schema and Type Alignment 🧪

## Scenario

You already have a TypeScript type and want your schema to guarantee alignment.

## Task

- Define a `User` type.
- Create a schema that matches it.
- Use `satisfies z.ZodType<User>` for compile‑time checks.

## Hints

- Use `z.object(...)` for the schema shape.
- `satisfies` sits after the schema definition.

## Starter

Frontend example — File: `@app/src/schemas/user.ts`

```ts
import { z } from "zod";

type User = {
  id: string;
  email: string;
  name: string;
};

const UserSchema = z.object({
  id: z.string(),
  email: z.string().email(),
  name: z.string(),
});

// TODO: add satisfies z.ZodType<User>
export { UserSchema };
```

## Answer

Frontend example — File: `@app/src/schemas/user.ts`

```ts
import { z } from 'zod';

type User = {
  id: string;
  email: string;
  name: string;
};

const UserSchema = z
  .object({
    id: z.string(),
    email: z.string().email(),
    name: z.string(),
  })
  satisfies z.ZodType<User>;

export { UserSchema };
```
