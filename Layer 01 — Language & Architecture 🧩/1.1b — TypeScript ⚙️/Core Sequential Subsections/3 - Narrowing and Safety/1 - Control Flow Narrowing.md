# Control Flow Narrowing

## Goal

Use built-in narrowing so you can operate on unions without assertions.

## What you learn

- How `typeof`, `in`, and equality checks narrow types.
- Why truthiness checks can be unsafe.
- How to avoid `!` by restructuring control flow.

## Explanation

TypeScript tracks control flow: after `typeof x === "string"`, the compiler knows `x` is
a string in that branch. Be explicit in checks to avoid false positives.

Truthiness checks are risky when `0`, `""`, or `false` are valid values.

## Example

Frontend example — File: `@app/src/utils/format.ts`

```ts
export function formatPriceCents(value: number | null | undefined): string {
  if (value == null) return "—";
  return `$${(value / 100).toFixed(2)}`;
}
```

## Pitfalls

- Using truthiness for numeric or boolean fields.
- Asserting non-null instead of narrowing.
