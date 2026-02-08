# Type-only Imports and Module Boundaries

## Goal

Keep module boundaries clean by separating type dependencies from runtime dependencies.

## What you learn

- How `import type` affects emitted JS.
- Why type-only edges shouldn’t create runtime cycles.
- How to keep shared types from pulling in runtime code.

## Explanation

Type-only imports are erased in output, so they don’t create runtime dependencies. This is
critical when shared types live in large modules that you don’t want to load at runtime.

Use `import type` to keep boundaries explicit and avoid accidental cycles.

## Example

Frontend example — File: `@app/src/api/types.ts`

```ts
export type ApiUser = { id: string; name: string };
```

Frontend example — File: `@app/src/ui/UserCard.tsx`

```tsx
import type { ApiUser } from "@app/api/types";

export function UserCard({ user }: { user: ApiUser }) {
  return <div>{user.name}</div>;
}
```

## Pitfalls

- Using value imports for type-only usage (creates unnecessary runtime deps).
- Assuming type-only imports are safe if the type module has side effects.
