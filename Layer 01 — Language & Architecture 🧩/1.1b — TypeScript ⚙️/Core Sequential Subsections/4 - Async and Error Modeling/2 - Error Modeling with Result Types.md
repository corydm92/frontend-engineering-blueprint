# Error Modeling with Result Types

## Goal

Make error states explicit so UI code can’t ignore them.

## What you learn

- How discriminated unions model success/failure.
- Why explicit error shapes reduce ambiguity.
- How to keep error handling consistent across layers.

## Explanation

When errors are modeled as data, callers must handle them explicitly. This avoids silent
catch blocks and “missing data” bugs.

## Example

Frontend example — File: `@app/src/data/result.ts`

```ts
export type Result<T> = { ok: true; data: T } | { ok: false; message: string; code?: string };

export function isOk<T>(result: Result<T>): result is { ok: true; data: T } {
  return result.ok;
}
```

## Pitfalls

- Mixing thrown errors with `Result` returns inconsistently.
- Using `string` for errors everywhere without structure.
