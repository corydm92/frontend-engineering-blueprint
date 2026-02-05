# Zod vs GraphQL Codegen ⚖️

## Rules

- Use Zod when runtime validation is required at boundaries.
- Use GraphQL codegen when schema‑first workflows drive contracts.

## Example

Frontend example — File: `@app/src/schemas/user.ts`

```ts
import { z } from "zod";

export const UserSchema = z.object({ id: z.string() });
```

## Gotchas

- Codegen types do not validate at runtime by themselves.
