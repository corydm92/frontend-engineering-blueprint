# Package Layout and Build 🧱

## Goal

Create a shared package that emits types and schemas.

## What you learn

- Shared packages need build outputs.
- Consuming apps import from `@app/contracts`.

## Explanation

A shared contracts package is only useful if consumers can import it reliably. That requires build outputs that match how your tooling resolves modules.
At minimum, you want TypeScript declaration files (`.d.ts`) and a consistent output directory (`dist/` or similar).

The build layout should make the public API obvious. Keep a single `src/index.ts` that exports the intended surface area, and emit outputs to a matching structure in `dist/`.
This lets apps import from `@app/contracts` without deep paths and without copying types into each app.

If you include runtime schemas (e.g., Zod), ensure the build config emits JavaScript as well (or the package is type-only by design and the runtime schemas live elsewhere).

## Example

Monorepo example — File: `@app/packages/contracts/tsconfig.json`

```json
{
  "compilerOptions": {
    "declaration": true,
    "outDir": "dist"
  }
}
```

## Pitfalls

- Publishing a package without declarations forces consumers to retype shapes locally.
- Allowing deep imports (e.g. `@app/contracts/dist/user`) couples consumers to internal layout and breaks refactors.
