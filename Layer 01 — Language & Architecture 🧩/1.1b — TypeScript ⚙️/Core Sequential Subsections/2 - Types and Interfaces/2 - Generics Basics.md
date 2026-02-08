# Generics Basics

## Goal

Use generics to model reusable, type-safe behavior.

## What you learn

- How to add type parameters to functions.
- How constraints prevent invalid calls.
- How generics preserve information.

## Explanation

Generics let you write code once while keeping the compiler aware of specific types.
Without generics, helpers often return `unknown` or `any`, forcing callers to re-cast.

## Example

Frontend example — File: `@app/src/utils/first.ts`

```ts
export function first<T>(items: readonly T[]): T | undefined {
  return items[0];
}

export function pluck<T extends Record<string, unknown>, K extends keyof T>(items: readonly T[], key: K): Array<T[K]> {
  return items.map((x) => x[key]);
}
```

## Pitfalls

- Over-abstracting simple code with generics.
- Forgetting constraints and relying on assertions.
