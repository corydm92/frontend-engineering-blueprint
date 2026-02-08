# Discriminated Unions

## Goal

Model state machines so each branch has the right fields without optional chaos.

## What you learn

- How a discriminant key drives safe branching.
- Why “optional everything” leads to invalid states.
- How to scale UI state safely.

## Explanation

A discriminated union is a union of object types that share a common literal field.
Switching on that field narrows the union and makes invalid states unrepresentable.

## Example

Frontend example — File: `@app/src/data/requestState.ts`

```ts
export type RequestState<T> =
  | { status: "idle" }
  | { status: "loading" }
  | { status: "error"; message: string }
  | { status: "success"; data: T };

export function renderUser(state: RequestState<{ name: string }>): string {
  switch (state.status) {
    case "idle":
      return "—";
    case "loading":
      return "Loading…";
    case "error":
      return state.message;
    case "success":
      return state.data.name;
  }
}
```

## Pitfalls

- Forgetting a discriminant (narrowing becomes fragile).
- Adding fields to the wrong state (invalid combinations).
