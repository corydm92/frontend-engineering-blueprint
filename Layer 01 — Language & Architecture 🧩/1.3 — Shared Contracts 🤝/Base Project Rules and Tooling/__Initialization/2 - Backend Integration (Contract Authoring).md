# 2 - Backend Integration (Contract Authoring) 🧠

## Goal

Author contracts on the backend and enforce them at API boundaries.

## Architecture decisions

- Backend owns schemas in `@app/src/contracts`.
- Validation happens before business logic executes.

## Steps

1. Define Zod schemas in the contracts folder.
2. Validate incoming payloads in route handlers.

## Example

Backend example — File: `@app/src/contracts/user.ts`

```ts
import { z } from "zod";

export const UserSchema = z.object({
  id: z.string(),
  email: z.string().email(),
  role: z.enum(["admin", "member"]),
});

export type User = z.infer<typeof UserSchema>;
```

Backend example — File: `@app/src/routes/users.ts`

```ts
import { UserSchema } from "../contracts/user";

app.post("/users", (req, res) => {
  const parsed = UserSchema.safeParse(req.body);
  if (!parsed.success) return res.status(400).json(parsed.error);
  return res.json(parsed.data);
});
```

## Validation

- Backend rejects invalid input at the boundary.
- Schema and type stay in sync.
