# 3 - Frontend Integration (Contract Consumption) 🎨

## Goal

Consume contracts on the frontend without redefining shapes.

## Architecture decisions

- Frontend models live under `@app/src/schemas`.
- API responses are validated at the client boundary.

## Steps

1. Define or import schemas used by the client.
2. Validate API responses before use in UI.

## Example

Frontend example — File: `@app/src/schemas/project.ts`

```ts
import { z } from 'zod';

export const ProjectSchema = z.object({
  id: z.string(),
  name: z.string(),
});

export type Project = z.infer<typeof ProjectSchema>;
```

Frontend example — File: `@app/src/api/projects.ts`

```ts
import { ProjectSchema } from '../schemas/project';

export async function fetchProjects() {
  const res = await fetch('/api/projects');
  const json = await res.json();
  const parsed = ProjectSchema.array().safeParse(json);
  if (!parsed.success) throw new Error('Invalid project payload');
  return parsed.data;
}
```

## Validation

- Frontend rejects invalid responses.
- UI uses validated data only.
