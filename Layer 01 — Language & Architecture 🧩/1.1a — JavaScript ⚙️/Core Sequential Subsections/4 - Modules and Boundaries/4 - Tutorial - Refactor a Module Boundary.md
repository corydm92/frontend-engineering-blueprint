# Tutorial — Refactor a Module Boundary 🧪

## Scenario

Your domain logic imports a UI helper because it was convenient. Now you can’t reuse the
logic in a worker without pulling in React.

## Task

- Move formatting logic into a domain module.
- Update the UI module to depend on the domain module.
- Ensure no domain file imports UI.

## Hints

- Domain modules should be environment-agnostic.
- UI modules should depend on domain, not the other way around.

## Starter

Frontend example — File: `@app/src/domain/price.ts`

```ts
// TODO: move shared logic here
```

Frontend example — File: `@app/src/ui/Price.tsx`

```tsx
// TODO: import from @app/src/domain/price.ts
export function Price({ cents }: { cents: number }) {
  return <span>{cents}</span>;
}
```

## Answer

Frontend example — File: `@app/src/domain/price.ts`

```ts
export function formatCents(value: number): string {
  return `$${(value / 100).toFixed(2)}`;
}
```

Frontend example — File: `@app/src/ui/Price.tsx`

```tsx
import { formatCents } from "@app/domain/price";

export function Price({ cents }: { cents: number }) {
  return <span>{formatCents(cents)}</span>;
}
```
