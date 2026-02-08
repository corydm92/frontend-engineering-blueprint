# Type Aliases vs Interfaces

## Goal

Pick the right construct and keep your model easy to extend.

## What you learn

- The practical differences between `type` and `interface`.
- When declaration merging matters.
- How to compose types safely.

## Explanation

Both `type` and `interface` can describe object shapes. Use `interface` when you expect
consumers to extend a public contract. Use `type` when you need unions, intersections,
or type-level composition.

## Example

Frontend example — File: `@app/src/domain/user.ts`

```ts
export interface UserBase {
  id: string;
  email: string;
}

export interface AdminUser extends UserBase {
  role: "admin";
  permissions: string[];
}

export type UserState =
  | { status: "loading" }
  | { status: "error"; message: string }
  | { status: "ready"; user: UserBase };
```

## Pitfalls

- Mixing `type` and `interface` without conventions.
- Overusing intersections to patch incompatible models.
