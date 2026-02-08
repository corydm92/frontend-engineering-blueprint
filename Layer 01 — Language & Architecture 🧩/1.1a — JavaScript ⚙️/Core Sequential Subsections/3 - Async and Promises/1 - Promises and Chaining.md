# Promises and Chaining

## Goal

Write promise chains that preserve errors and enforce ordering.

## What you learn

- Why returning a promise from `.then()` matters.
- How errors propagate through chains.
- When to prefer small helper functions.

## Explanation

A promise chain is a sequence of transformations. The key rule: return the next promise
from `.then()` to ensure ordering.

If you call an async function inside `.then()` without returning it, the outer chain won’t
wait, and your code becomes accidentally concurrent.

## Example

Frontend example — File: `@app/src/data/loadUserChain.ts`

```ts
type User = { id: string; name: string };

async function fetchJson(url: string, signal?: AbortSignal): Promise<unknown> {
  const res = await fetch(url, { signal });
  if (!res.ok) throw new Error(`HTTP ${res.status}`);
  return await res.json();
}

export function loadUser(userId: string, signal?: AbortSignal): Promise<User> {
  return Promise.resolve()
    .then(() => fetchJson(`/api/users/${userId}`, signal))
    .then((data) => {
      if (!data || typeof data !== "object") throw new Error("Invalid payload");
      const x = data as Record<string, unknown>;
      const id = x["id"];
      const name = x["name"];
      if (typeof id !== "string" || typeof name !== "string") throw new Error("Invalid user");
      return { id, name };
    });
}
```

## Pitfalls

- Not returning a promise from `.then()` (ordering breaks).
- Swallowing errors in `.catch()` without surfacing them.
