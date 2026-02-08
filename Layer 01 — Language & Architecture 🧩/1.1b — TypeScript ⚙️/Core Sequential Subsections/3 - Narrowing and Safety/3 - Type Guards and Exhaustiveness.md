# Type Guards and Exhaustiveness

## Goal

Write runtime checks that narrow types safely and make missing cases a compile error.

## What you learn

- How to write a type predicate (`x is T`).
- How to enforce exhaustive handling with `never`.
- Where type guards belong (boundaries, adapters).

## Explanation

Type guards are functions whose return type tells TypeScript how to narrow a value.
They’re most useful at boundaries where runtime checks are unavoidable.

Exhaustiveness checks make evolution safe: if you add a new union variant, the compiler
forces every switch to handle it.

## Example

Frontend example — File: `@app/src/utils/isNonEmptyString.ts`

```ts
export function isNonEmptyString(x: unknown): x is string {
  return typeof x === "string" && x.trim().length > 0;
}
```

Frontend example — File: `@app/src/utils/exhaustive.ts`

```ts
export function assertNever(x: never): never {
  throw new Error(`Unhandled case: ${String(x)}`);
}
```

## Pitfalls

- Writing overly permissive guards (they narrow incorrectly).
- Using a `default` branch without `never` enforcement.
