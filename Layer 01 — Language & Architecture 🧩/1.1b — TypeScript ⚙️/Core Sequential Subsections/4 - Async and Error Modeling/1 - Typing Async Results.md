# Typing Async Results

## Goal

Use explicit return types so async boundaries stay predictable.

## What you learn

- How `async` implies `Promise<T>`.
- How to model success/failure shapes.
- Why `unknown` is safer than `any` for payloads.

## Explanation

Async functions always return a promise. Make the resolved value explicit so callers can
handle results without guessing. If the payload is untrusted, keep it `unknown` until you
validate it.

## Example

Frontend example — File: `@app/src/data/loadUser.ts`

```ts
export type Result<T> = { ok: true; data: T } | { ok: false; message: string };

export async function loadUser(userId: string): Promise<Result<unknown>> {
  try {
    const res = await fetch(`/api/users/${userId}`);
    if (!res.ok) return { ok: false, message: `HTTP ${res.status}` };
    return { ok: true, data: await res.json() };
  } catch {
    return { ok: false, message: "Network error" };
  }
}
```

## Pitfalls

- Returning `any` from async boundaries.
- Throwing raw errors without context or shape.
