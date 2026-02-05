# Tutorial — Compose Profile Schema 🧪

## Scenario

You want one base profile schema and two smaller variants for UI use.

## Task

- Define a base profile schema.
- Create a card version with `pick`.
- Create a form version with `partial`.

## Hints

- Start with `z.object(...)` for the base.
- `pick` selects a subset of keys.
- `partial` makes fields optional.

## Starter

Frontend example — File: `@app/src/schemas/profile.ts`

```ts
import { z } from "zod";

const Base = z.object({
  id: z.string(),
  name: z.string(),
  bio: z.string(),
});

// TODO: create ProfileCard with pick
// TODO: create ProfileForm with partial
```

## Answer

Frontend example — File: `@app/src/schemas/profile.ts`

```ts
import { z } from "zod";

const Base = z.object({
  id: z.string(),
  name: z.string(),
  bio: z.string(),
});

export const ProfileCard = Base.pick({ id: true, name: true });
export const ProfileForm = Base.partial();
```
