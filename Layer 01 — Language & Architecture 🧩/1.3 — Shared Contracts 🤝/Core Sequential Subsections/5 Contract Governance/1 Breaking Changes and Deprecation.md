# Breaking Changes and Deprecation 🚧

## Goal

Define how breaking changes are introduced safely.

## What you learn

- Deprecation windows reduce breakage.
- Breaking changes require explicit migration paths.

## Example

Backend example — File: `@app/src/contracts/user.ts`

```ts
import { z } from "zod";

export const UserSchema = z.object({
  id: z.string(),
  email: z.string().email(),
  role: z.string().optional(),
});
```
