# Call Stack and Execution Order

## Goal

Understand how the call stack executes code so you can reason about synchronous order.

## What you learn

- Why JavaScript is run-to-completion per task.
- How nested calls build up the stack.
- Why long-running work blocks rendering.

## Explanation

The call stack is the stack of active function calls. JavaScript runs code to completion
before the event loop picks the next task, so synchronous work _blocks everything else_.

When you see UI freezes or unresponsive inputs, long stack execution is often the cause.

## Example

Frontend example — File: `@app/src/runtime/stack.ts`

```ts
export function computeTotal(values: number[]): number {
  let total = 0;
  for (const v of values) total += v;
  return total;
}

export function run() {
  const total = computeTotal([1, 2, 3]);
  return total;
}
```

## Pitfalls

- Doing heavy loops in render paths.
- Assuming `setTimeout` can “interrupt” synchronous work (it cannot).
