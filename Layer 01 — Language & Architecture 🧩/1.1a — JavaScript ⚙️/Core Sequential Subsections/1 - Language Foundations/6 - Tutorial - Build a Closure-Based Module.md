# Tutorial — Build a Closure-Based Module 🧪

## Scenario

You need a small feature flag store with a private cache. It should expose a clean API but
keep implementation details hidden.

## Task

- Build a `createFlagStore()` function that hides its internal map.
- Support `get(name)`, `set(name, value)`, and `reset()` methods.
- Ensure callers cannot mutate the internal store directly.

## Hints

- Use a closure to keep the map private.
- Return an object with methods that operate on the private state.

## Starter

Frontend example — File: `@app/src/foundations/flagStore.ts`

```ts
export function createFlagStore() {
  // TODO
  return {
    get(name: string) {
      return false;
    },
    set(name: string, value: boolean) {
      // TODO
    },
    reset() {
      // TODO
    },
  };
}
```

## Answer

Frontend example — File: `@app/src/foundations/flagStore.ts`

```ts
export function createFlagStore() {
  const store = new Map<string, boolean>();

  return {
    get(name: string) {
      return store.get(name) ?? false;
    },
    set(name: string, value: boolean) {
      store.set(name, value);
    },
    reset() {
      store.clear();
    },
  };
}
```
