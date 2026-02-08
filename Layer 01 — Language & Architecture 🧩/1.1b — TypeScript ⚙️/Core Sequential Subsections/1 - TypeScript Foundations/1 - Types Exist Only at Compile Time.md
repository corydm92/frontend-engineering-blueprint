# Types Exist Only at Compile Time

## Goal

Understand what TypeScript can guarantee and why runtime validation still matters.

## What you learn

- Why types disappear after compilation.
- The difference between “typed” and “validated.”
- How to keep `unknown` from leaking into core logic.

## Explanation

TypeScript checks your program before it runs. Once compiled, only JavaScript remains.
That means TypeScript cannot protect you from untrusted runtime data like forms, network
responses, or environment variables.

The safe pattern is: treat boundary data as `unknown`, validate/parse it, then pass the
safe result into your core logic.

## Example

Frontend example — File: `@app/src/boundary/parseQueryParam.ts`

```ts
export function parsePage(value: unknown): number {
  if (typeof value !== "string") return 1;
  const n = Number(value);
  if (!Number.isFinite(n) || n < 1) return 1;
  return Math.floor(n);
}
```

## Pitfalls

- Using `as` to silence errors (it hides real bugs).
- Treating external data as already typed.
