# Tutorial — Robust Async Flow 🧪

## Scenario

You’re building a typeahead search. Requests fire on each keystroke. Old results sometimes
overwrite new ones, and occasional network errors break the UI.

## Task

- Implement `searchUsers(query)` using `fetch`.
- Ensure only the latest request updates results.
- Treat abort as non-fatal.
- Return `{ ok: true, data } | { ok: false, message }`.

## Hints

- Use a shared `AbortController` and abort before starting the next request.
- Check `err.name === "AbortError"`.

## Starter

Frontend example — File: `@app/src/search/searchUsers.ts`

```ts
type User = { id: string; name: string };

type Result<T> = { ok: true; data: T } | { ok: false; message: string };

let controller: AbortController | null = null;

export async function searchUsers(query: string): Promise<Result<readonly User[]>> {
  // TODO
  return { ok: true, data: [] };
}
```

## Answer

Frontend example — File: `@app/src/search/searchUsers.ts`

```ts
type User = { id: string; name: string };

type Result<T> = { ok: true; data: T } | { ok: false; message: string };

let controller: AbortController | null = null;

export async function searchUsers(query: string): Promise<Result<readonly User[]>> {
  if (controller) controller.abort();
  controller = new AbortController();

  try {
    const res = await fetch(`/api/search/users?q=${encodeURIComponent(query)}`, {
      signal: controller.signal,
    });

    if (!res.ok) {
      return { ok: false, message: `Request failed (${res.status})` };
    }

    const data = await res.json();
    if (!Array.isArray(data)) {
      return { ok: false, message: "Invalid payload" };
    }

    const users: User[] = [];
    for (const x of data) {
      if (!x || typeof x !== "object") continue;
      const u = x as Record<string, unknown>;
      const id = u["id"];
      const name = u["name"];
      if (typeof id !== "string" || typeof name !== "string") continue;
      users.push({ id, name });
    }

    return { ok: true, data: users };
  } catch (err) {
    if (err && typeof err === "object" && "name" in err && err.name === "AbortError") {
      return { ok: false, message: "aborted" };
    }

    return { ok: false, message: "Network error" };
  }
}
```
