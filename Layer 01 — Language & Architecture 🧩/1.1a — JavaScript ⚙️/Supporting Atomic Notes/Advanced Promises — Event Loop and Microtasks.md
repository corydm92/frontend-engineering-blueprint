# Advanced Promises — Event Loop and Microtasks

## Rules

- Promise callbacks run as microtasks.
- Microtasks drain fully before the next task runs.
- Unbounded microtask chains can starve rendering.

## Example

Frontend example — File: `@app/src/promises/microtaskLoop.ts`

```ts
export function microtaskLoop(count: number) {
  let i = 0;
  function tick() {
    i += 1;
    if (i < count) queueMicrotask(tick);
  }
  tick();
}
```

## Gotchas

- Recursive microtasks can block the UI even if each one is tiny.
- Timers don’t run until microtasks are drained.
