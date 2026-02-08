# Lazy Loading and Code Splitting

## Goal

Use dynamic imports to improve performance without breaking boundaries.

## What you learn

- How `import()` creates an async boundary.
- Where lazy loading helps (routes, heavy widgets).
- How to keep public APIs stable.

## Explanation

Dynamic `import()` lets bundlers split code into separate chunks that load on demand.
This improves startup time by deferring non-critical code.

Treat this as an architectural choice: it introduces async into module loading, so callers
must handle loading and error states.

## Example

Frontend example — File: `@app/src/routes/loadAdmin.ts`

```ts
export async function loadAdminRoute() {
  const mod = await import("@app/routes/AdminRoute");
  return mod.AdminRoute;
}
```

## Pitfalls

- Lazy loading tiny modules (overhead outweighs benefit).
- Importing for side effects (hard to reason about and test).
