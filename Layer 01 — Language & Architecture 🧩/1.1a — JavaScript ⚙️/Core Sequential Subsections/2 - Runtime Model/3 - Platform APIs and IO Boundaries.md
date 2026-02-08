# Platform APIs and IO Boundaries

## Goal

Know which work happens outside the JS engine and how results return.

## What you learn

- The boundary between JS and platform subsystems (network, timers, storage).
- Why APIs like `fetch` are async even if you don’t `await` them.
- How IO boundaries affect error handling and cancellation.

## Explanation

Many platform APIs run outside the JS engine. For example, `fetch` starts a network request
in the browser subsystem; the JS engine is notified later via tasks/microtasks.

This means you must treat IO as asynchronous even when code “looks” synchronous. It also
means error handling must be explicit: exceptions don’t cross the boundary for you.

## Example

Frontend example — File: `@app/src/runtime/fetchBoundary.ts`

```ts
export async function loadJson(url: string, signal?: AbortSignal): Promise<unknown> {
  const res = await fetch(url, { signal });
  if (!res.ok) throw new Error(`HTTP ${res.status}`);
  return await res.json();
}
```

## Pitfalls

- Assuming `fetch` errors throw synchronously.
- Starting IO without handling cancellation (stale results overwrite state).
