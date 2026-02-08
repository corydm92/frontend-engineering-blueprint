# Tutorial — Typed Async Flow 🧪

## Scenario

A dashboard loads user data and must handle failures without crashing the UI.

## Task

- Implement `loadUserProfile` returning a `Result<UserProfile>`.
- Validate the payload shape before returning success.
- Use `Result` to represent errors instead of throwing.

## Hints

- Keep the parsed shape small and strict.
- Use `unknown` until validation passes.

## Starter

Frontend example — File: `@app/src/data/loadUserProfile.ts`

```ts
export type Result<T> = { ok: true; data: T } | { ok: false; message: string };

export type UserProfile = {
  id: string;
  name: string;
};

export async function loadUserProfile(id: string): Promise<Result<UserProfile>> {
  // TODO
  return { ok: false, message: "not implemented" };
}
```

## Answer

Frontend example — File: `@app/src/data/loadUserProfile.ts`

```ts
export type Result<T> = { ok: true; data: T } | { ok: false; message: string };

export type UserProfile = {
  id: string;
  name: string;
};

function parseUserProfile(value: unknown): UserProfile | null {
  if (!value || typeof value !== "object") return null;
  const x = value as Record<string, unknown>;
  const id = x["id"];
  const name = x["name"];
  if (typeof id !== "string" || typeof name !== "string") return null;
  return { id, name };
}

export async function loadUserProfile(id: string): Promise<Result<UserProfile>> {
  try {
    const res = await fetch(`/api/users/${id}`);
    if (!res.ok) return { ok: false, message: `HTTP ${res.status}` };
    const parsed = parseUserProfile(await res.json());
    if (!parsed) return { ok: false, message: "Invalid payload" };
    return { ok: true, data: parsed };
  } catch {
    return { ok: false, message: "Network error" };
  }
}
```
