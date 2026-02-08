# JavaScript Runtime — Execution Model Quick Reference

## Rules

- A task runs to completion before the next task starts.
- Microtasks run after the current task and before the next task.
- Rendering typically occurs between tasks, not inside microtasks.

## Example

Frontend example — File: `@app/src/runtime/ordering.ts`

```ts
export function ordering(log = console.log) {
  log("sync");
  Promise.resolve().then(() => log("microtask"));
  setTimeout(() => log("task"), 0);
}
```

## Gotchas

- `await Promise.resolve()` does not yield to rendering.
- Long synchronous tasks block everything, including input.
