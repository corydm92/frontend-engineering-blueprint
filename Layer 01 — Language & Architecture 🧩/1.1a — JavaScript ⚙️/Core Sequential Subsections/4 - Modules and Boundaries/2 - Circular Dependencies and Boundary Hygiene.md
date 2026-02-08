# Circular Dependencies and Boundary Hygiene

## Goal

Keep dependencies flowing in one direction so modules stay easy to change.

## What you learn

- How cycles form and why they’re hard to debug.
- How to create adapter layers.
- How to keep “shared” from becoming a dumping ground.

## Explanation

Circular dependencies create fragile initialization order and implicit coupling. A good
rule is: core logic should not import UI or platform wiring.

When you need cross-layer collaboration, add an adapter or boundary module instead of
letting dependencies flow both ways.

## Example

Frontend example — File: `@app/src/domain/currency.ts`

```ts
export function formatCents(value: number): string {
  return `$${(value / 100).toFixed(2)}`;
}
```

Frontend example — File: `@app/src/ui/Price.tsx`

```tsx
import { formatCents } from "@app/domain/currency";

export function Price({ cents }: { cents: number }) {
  return <span>{formatCents(cents)}</span>;
}
```

## Pitfalls

- Importing UI into domain “just once” (it spreads quickly).
- Duplicating domain rules in multiple UI modules.
