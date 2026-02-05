# Tutorial — Model API Response Variants 🧪

## Scenario

Your API returns either a success payload or an error payload.

## Task

- Define `Success` and `Error` schemas with a `type` discriminator.
- Combine them with `z.discriminatedUnion`.
- Parse input and return `{ ok, data | error }`.

## Hints

- Use `z.literal('success')` and `z.literal('error')`.
- `safeParse` gives a result object you can branch on.

## Starter

Backend example — File: `@api/src/lib/parseResponse.ts`

```ts
import { z } from 'zod';

const Success = z.object({
  type: z.literal('success'),
  data: z.object({
    id: z.string(),
    title: z.string(),
  }),
});

const Failure = z.object({
  type: z.literal('error'),
  message: z.string(),
});

// TODO: create ResponseSchema with z.discriminatedUnion

export function parseResponse(input: unknown) {
  // TODO: safeParse input
  // TODO: return { ok: true, data } or { ok: false, error }
}
```

## Answer

Backend example — File: `@api/src/lib/parseResponse.ts`

```ts
import { z } from 'zod';

const Success = z.object({
  type: z.literal('success'),
  data: z.object({
    id: z.string(),
    title: z.string(),
  }),
});

const Failure = z.object({
  type: z.literal('error'),
  message: z.string(),
});

const ResponseSchema = z.discriminatedUnion('type', [Success, Failure]);

export function parseResponse(input: unknown) {
  const parsed = ResponseSchema.safeParse(input);
  if (!parsed.success) return { ok: false, error: parsed.error.flatten() };
  return { ok: true, data: parsed.data };
}
```
