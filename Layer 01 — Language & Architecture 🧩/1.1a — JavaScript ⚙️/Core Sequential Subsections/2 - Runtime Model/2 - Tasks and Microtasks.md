# Tasks and Microtasks

## Goal

Predict ordering between timers, promises, and rendering.

## What you learn

- What a task is vs a microtask.
- Why promise callbacks run before the next task.
- How microtasks can delay rendering.

## Explanation

Tasks (macrotasks) come from timers, user events, and IO callbacks. Microtasks are queued
by promises and `queueMicrotask`. After a task completes, the engine runs all pending
microtasks before moving to the next task.

This is why promise callbacks can run before `setTimeout(..., 0)` and why microtask loops
can starve rendering.

## Example

Frontend example — File: `@app/src/runtime/order.ts`

```ts
export function demo(log = console.log) {
  log("sync-start");

  setTimeout(() => log("task"), 0);
  Promise.resolve().then(() => log("microtask"));

  log("sync-end");
}
```

## Pitfalls

- Treating microtasks as a safe “yield” to rendering.
- Creating infinite microtask loops that block the UI.
