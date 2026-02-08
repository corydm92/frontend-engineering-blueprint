# Fetch — Streaming, Cancellation, and Errors

## Rules

- `fetch` resolves on _HTTP completion_, not on JSON parsing.
- Use `AbortController` for cancellation.
- Always handle non-2xx responses explicitly.

## Example

Frontend example — File: `@app/src/data/fetchJson.ts`

```ts
export async function fetchJson(url: string, signal?: AbortSignal): Promise<unknown> {
  const res = await fetch(url, { signal });
  if (!res.ok) throw new Error(`HTTP ${res.status}`);
  return await res.json();
}
```

## Gotchas

- A network error rejects the promise; a 404 does not.
- Aborted requests throw `AbortError` and should not show “failure” UI.
