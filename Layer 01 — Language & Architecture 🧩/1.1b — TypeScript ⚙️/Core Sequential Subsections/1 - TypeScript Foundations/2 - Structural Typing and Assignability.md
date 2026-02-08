# Structural Typing and Assignability

## Goal

Use structural typing intentionally so you don’t accidentally weaken contracts.

## What you learn

- What “structural typing” means in practice.
- How assignability works for objects and functions.
- When to introduce branding.

## Explanation

TypeScript is structurally typed: if two values have the same shape, they are compatible.
This is flexible but can be dangerous when two concepts share a shape but should not be
interchangeable (e.g. `UserId` vs `OrderId`).

Branding a primitive is a lightweight way to prevent accidental mixing without changing
runtime representation.

## Example

Frontend example — File: `@app/src/domain/ids.ts`

```ts
type Brand<K, T> = K & { readonly __brand: T };

export type UserId = Brand<string, "UserId">;
export type OrderId = Brand<string, "OrderId">;

export function asUserId(value: string): UserId {
  return value as UserId;
}
```

## Pitfalls

- Branding without validation (you can still brand garbage).
- Over-branding everything (adds friction without benefit).
