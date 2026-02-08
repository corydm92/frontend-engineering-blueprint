# Extend and Merge Schemas 🧩

## Goal

Compose schemas without duplicating fields.

## What you learn

- `.extend()` adds new fields to a base schema.
- `.merge()` combines two object schemas.

## Explanation

`.extend()` is ideal when you have a base schema and want to add **new fields**.
`.merge()` is best when combining two related schemas (e.g., profile + settings).
Both approaches preserve the original schema’s validation rules.

Use composition to keep contracts DRY and to avoid subtle drift between similar
shapes.

## Example

Backend example — File: `@api/src/schemas/account.ts`

```ts
import { z } from "zod";

const ProfileSchema = z.object({
  id: z.string(),
  name: z.string(),
});

const SettingsSchema = z.object({
  theme: z.enum(["light", "dark"]),
});

export const AccountSchema = ProfileSchema.merge(SettingsSchema);
```

## Pitfalls

- Merging schemas with conflicting keys can override validation.
- Extending when you meant to restrict (use `pick`/`omit`).
