# Tutorial — Diagnose a Timing Bug 🧪

## Scenario

A loading spinner sometimes never appears. A teammate added `await Promise.resolve()` as a
“yield,” but it didn’t help.

## Task

- Explain (in code comments) why `await Promise.resolve()` doesn’t yield to rendering.
- Add a `yieldToBrowser()` helper that yields across a task boundary.
- Use it before a simulated long task.

## Hints

- Promise callbacks run as microtasks.
- Rendering happens between tasks, not inside microtasks.

## Starter

Frontend example — File: `@app/src/runtime/yieldToBrowser.ts`

```ts
export async function yieldToBrowser(): Promise<void> {
  // TODO
}

export async function doWorkWithSpinner(setVisible: (v: boolean) => void): Promise<void> {
  setVisible(true);

  // TODO: yield so the spinner can paint

  const end = Date.now() + 50;
  while (Date.now() < end) {
    // busy
  }

  setVisible(false);
}
```

## Answer

Frontend example — File: `@app/src/runtime/yieldToBrowser.ts`

```ts
export async function yieldToBrowser(): Promise<void> {
  // Yield across a task boundary so rendering can occur.
  await new Promise<void>((resolve) => setTimeout(resolve, 0));
}

export async function doWorkWithSpinner(setVisible: (v: boolean) => void): Promise<void> {
  setVisible(true);

  await yieldToBrowser();

  const end = Date.now() + 50;
  while (Date.now() < end) {
    // busy
  }

  setVisible(false);
}
```
