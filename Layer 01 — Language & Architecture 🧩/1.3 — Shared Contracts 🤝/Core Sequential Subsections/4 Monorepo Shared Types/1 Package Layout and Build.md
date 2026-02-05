# Package Layout and Build 🧱

## Goal

Create a shared package that emits types and schemas.

## What you learn

- Shared packages need build outputs.
- Consuming apps import from `@app/contracts`.

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
