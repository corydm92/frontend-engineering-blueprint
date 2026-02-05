# Error Formatting and Mapping 🧭

## Goal

Convert Zod errors into API‑friendly payloads.

## What you learn

- `issues` gives you paths + codes you can map.
- A simple mapper keeps API responses consistent.

## Explanation

APIs often need a **flat list** of field errors rather than nested objects. Mapping
`ZodError.issues` into a consistent shape keeps clients stable and simplifies UI
handling. Treat this as a contract — once published, keep it stable.

## Example

Backend example — File: `@api/src/lib/zodErrorMap.ts`

```ts
import { z } from 'zod';

export function mapZodError(error: z.ZodError) {
  return error.issues.map((issue) => ({
    field: issue.path.join('.'),
    code: issue.code,
    message: issue.message,
  }));
}
```

## Pitfalls

- Dropping `path` information loses field attribution.
- Changing error shapes without versioning breaks clients.
