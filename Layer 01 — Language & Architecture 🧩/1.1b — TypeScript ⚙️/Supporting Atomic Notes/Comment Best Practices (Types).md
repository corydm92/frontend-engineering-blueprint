# Comment Best Practices (Types)

## Rules

- Comments should explain _why_, not restate the type.
- Document invariants and expectations at boundaries.
- Keep comments close to the type definition.

## Example

Frontend example — File: `@app/src/domain/money.ts`

```ts
// All money values are integer cents to avoid floating-point errors.
export type MoneyCents = number;
```

## Gotchas

- Redundant comments become stale quickly.
- Comments that describe runtime behavior on types can mislead.
