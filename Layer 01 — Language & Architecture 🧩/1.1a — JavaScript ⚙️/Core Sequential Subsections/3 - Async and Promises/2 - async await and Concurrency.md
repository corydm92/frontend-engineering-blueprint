# async/await and Concurrency

## Goal

Use `async`/`await` while staying explicit about concurrency and ordering.

## What you learn

- Why `await` is sequential by default.
- How to run independent work concurrently.
- How to preserve error context.

## Explanation

`await` makes async code look synchronous. If you `await` two independent requests one
after the other, you serialize them and increase latency.

Start independent promises first, then `await` them together to preserve concurrency.

## Example

Frontend example — File: `@app/src/data/loadDashboard.ts`

```ts
type User = { id: string; name: string };
type Notification = { id: string; title: string };

async function fetchJson(url: string, signal?: AbortSignal): Promise<unknown> {
  const res = await fetch(url, { signal });
  if (!res.ok) throw new Error(`HTTP ${res.status}`);
  return await res.json();
}

export async function loadDashboard(userId: string, signal?: AbortSignal) {
  const userP = fetchJson(`/api/users/${userId}`, signal);
  const notifP = fetchJson(`/api/users/${userId}/notifications`, signal);

  const [user, notifications] = await Promise.all([userP, notifP]);
  return { user, notifications };
}
```

## Pitfalls

- Serializing independent requests with back-to-back `await`.
- Using `Promise.all` when partial success is acceptable.
