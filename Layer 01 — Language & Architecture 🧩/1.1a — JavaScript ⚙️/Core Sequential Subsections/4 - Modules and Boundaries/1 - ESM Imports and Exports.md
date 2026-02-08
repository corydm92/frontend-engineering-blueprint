# ESM Imports and Exports

## Goal

Use ESM module syntax predictably across a codebase.

## What you learn

- When to use named exports vs default exports.
- How re-exports affect dependency graphs.
- How to avoid accidental coupling.

## Explanation

Named exports scale better in large codebases: they’re easier to refactor and grep, and
avoid “what is the default?” ambiguity.

Default exports are fine for small, single-purpose modules, but mixed patterns become
confusing. Standardize your approach.

## Example

Frontend example — File: `@app/src/ui/Button.tsx`

```tsx
export type ButtonProps = {
  label: string;
  onClick: () => void;
};

export function Button({ label, onClick }: ButtonProps) {
  return <button onClick={onClick}>{label}</button>;
}
```

Frontend example — File: `@app/src/ui/index.ts`

```ts
export { Button } from "@app/ui/Button";
export type { ButtonProps } from "@app/ui/Button";
```

## Pitfalls

- Barrel files everywhere (hidden coupling, more cycles).
- Mixing default and named exports without conventions.
