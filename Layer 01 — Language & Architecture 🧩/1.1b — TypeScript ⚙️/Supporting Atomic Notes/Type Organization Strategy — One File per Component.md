# Type Organization Strategy — One File per Component

## Rules

- Keep component props types adjacent to components.
- Promote types to shared modules only when reused across boundaries.
- Avoid a single “types.ts” dumping ground.

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

## Gotchas

- Centralized type files become unmaintainable quickly.
- Moving types too early creates unnecessary coupling.
