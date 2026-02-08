# Closures in Practice

## Goal

Use closures intentionally to encapsulate state without leaking it.

## What you learn

- Why inner functions can access outer variables.
- How closures create private state.
- Where closures can cause memory retention issues.

## Explanation

A closure is a function that **remembers** the lexical environment where it was created.
This enables powerful patterns like private state and factories.

Closures are not magic — they’re a direct result of lexical scope. They also keep references
alive, which matters for memory and long-lived UI sessions.

## Example

Frontend example — File: `@app/src/foundations/counter.ts`

```ts
export function createCounter() {
  let value = 0;

  return {
    inc() {
      value += 1;
      return value;
    },
    reset() {
      value = 0;
    },
  };
}
```

## Pitfalls

- Capturing mutable variables unintentionally (loop bugs, stale values).
- Storing closures in long-lived caches without cleanup (memory leaks).
