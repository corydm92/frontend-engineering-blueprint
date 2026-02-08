# Tutorial — Safe Reducer with Exhaustiveness 🧪

## Scenario

A reducer swallowed a new action type because a `default` branch returned the old state.
The bug shipped silently.

## Task

- Model actions as a discriminated union.
- Implement a reducer that handles every action.
- Add an exhaustiveness check.

## Hints

- Use a literal `type` field as the discriminant.
- Use `assertNever` in the `default` branch.

## Starter

Frontend example — File: `@app/src/state/reducer.ts`

```ts
type State = { count: number };

type Action = { type: "inc" } | { type: "dec" } | { type: "set"; value: number };

export function reducer(state: State, action: Action): State {
  // TODO
  return state;
}
```

## Answer

Frontend example — File: `@app/src/state/reducer.ts`

```ts
function assertNever(x: never): never {
  throw new Error(`Unhandled action: ${String(x)}`);
}

type State = { count: number };

type Action = { type: "inc" } | { type: "dec" } | { type: "set"; value: number };

export function reducer(state: State, action: Action): State {
  switch (action.type) {
    case "inc":
      return { count: state.count + 1 };
    case "dec":
      return { count: state.count - 1 };
    case "set":
      return { count: action.value };
    default:
      return assertNever(action);
  }
}
```
