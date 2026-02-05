# 1 - Contract Source Setup 🧱

## Goal

Choose the source of truth and create the minimal contract location.

## Architecture decisions

- **Backend example:** contracts live in `@app/src/contracts`.
- **Monorepo example:** contracts live in `@app/packages/contracts`.

## Steps

1. Create the contract directory in your chosen location.
2. Add a single entry file to export schemas.
3. Confirm the app can import from that location.

## Example

Backend example — File: `@app/src/contracts/index.ts`

```ts
export * from './user';
export * from './project';
```

Monorepo example — File: `@app/packages/contracts/src/index.ts`

```ts
export * from './user';
export * from './project';
```

## Validation

- A contract module exists in the chosen location.
- Imports resolve without duplicating types elsewhere.
