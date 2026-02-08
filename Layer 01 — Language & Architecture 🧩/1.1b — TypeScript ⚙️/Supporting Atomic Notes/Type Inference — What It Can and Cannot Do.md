# Type Inference — What It Can and Cannot Do

## Rules

- Inference is strongest at the declaration site.
- Inference weakens across `any` and untyped boundaries.
- Explicit annotations are best for public APIs.

## Example

Frontend example — File: `@app/src/utils/infer.ts`

```ts
export const flags = {
  enableCheckout: true,
  enableNewNav: false,
};

export type FlagKey = keyof typeof flags;
```

## Gotchas

- Inference does not validate runtime data.
- Inferred unions can become too wide if you mutate objects.
