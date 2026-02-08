# Type vs Value Namespaces

## Goal

Avoid confusion between type-level names and runtime values.

## What you learn

- Why types and values are separate namespaces.
- How to use `typeof` at the type level.
- When to use `import type`.

## Explanation

TypeScript has two namespaces: **types** and **values**. A name can exist in one or both,
and the compiler resolves them differently.

`import type` makes the boundary explicit and prevents runtime side effects. It also helps
bundlers tree-shake correctly.

## Example

Frontend example — File: `@app/src/domain/user.ts`

```ts
export type User = { id: string; name: string };

export function formatUser(user: User): string {
  return `${user.name} (${user.id})`;
}
```

Frontend example — File: `@app/src/ui/UserCard.tsx`

```tsx
import type { User } from "@app/domain/user";
import { formatUser } from "@app/domain/user";

export function UserCard({ user }: { user: User }) {
  return <div>{formatUser(user)}</div>;
}
```

## Pitfalls

- Importing types without `import type` in build systems that preserve imports.
- Assuming a type alias exists at runtime.
