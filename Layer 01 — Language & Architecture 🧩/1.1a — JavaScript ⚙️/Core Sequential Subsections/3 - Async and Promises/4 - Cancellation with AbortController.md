# Cancellation with AbortController

## Goal

Prevent stale async work from updating UI by supporting cancellation.

## What you learn

- How `AbortController` propagates cancellation.
- How to implement “latest only” requests.
- How to treat abort errors as control flow, not failure.

## Explanation

User-driven async work becomes stale fast (typeahead, navigation, filters). If older
requests finish last, they overwrite newer results.

`AbortController` is the standard way to cancel fetches and other signal-aware APIs.

## Example

Frontend example — File: `@app/src/data/latestOnly.ts`

```ts
export function createLatestOnly() {
  let current: AbortController | null = null;

  return {
    async run<T>(fn: (signal: AbortSignal) => Promise<T>): Promise<T> {
      if (current) current.abort();
      const controller = new AbortController();
      current = controller;

      try {
        return await fn(controller.signal);
      } finally {
        if (current === controller) current = null;
      }
    },
  };
}
```

## Pitfalls

- Treating abort as a generic failure (users see spurious error UI).
- Forgetting to cancel in `useEffect` cleanups.
