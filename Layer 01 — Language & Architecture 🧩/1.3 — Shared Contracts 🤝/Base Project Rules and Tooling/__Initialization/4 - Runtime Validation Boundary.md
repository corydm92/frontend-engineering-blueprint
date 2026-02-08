# 4 - Runtime Validation Boundary ✅

## Goal

Ensure all untrusted inputs are validated before use.

## Architecture decisions

- Validation helpers live in `@app/src/validation/`.
- Boundary validation runs before business logic.

## Steps

1. Validate request payloads at API entry.
2. Validate responses from third‑party services.

## Example

Backend example — File: `@app/src/validation/requests.ts`

```ts
import { z } from "zod";

export const CreateProjectSchema = z.object({
  name: z.string().min(1),
  ownerId: z.string(),
});
```

Backend example — File: `@app/src/routes/projects.ts`

```ts
import { CreateProjectSchema } from "../validation/requests";

app.post("/projects", (req, res) => {
  const parsed = CreateProjectSchema.safeParse(req.body);
  if (!parsed.success) return res.status(400).json(parsed.error);
  return res.json({ ok: true });
});
```

## Validation

- Invalid requests fail before business logic.
- Errors are consistent and structured.
