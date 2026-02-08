# Tutorial — Make Boundary Data Safe 🧪

## Scenario

A teammate typed query params as `{ page: number }`, but production crashes when the
value is missing or malformed.

## Task

- Parse unknown input into a safe `Filters` object.
- Default `page` to `1` when invalid.
- Default `q` to an empty string.

## Hints

- Use `typeof` checks.
- Prefer defaults over throwing for URL-driven state.

## Starter

Frontend example — File: `@app/src/boundary/filters.ts`

```ts
export type Filters = {
  page: number;
  q: string;
};

export function parseFilters(input: { page?: unknown; q?: unknown }): Filters {
  // TODO
  return { page: 1, q: "" };
}
```

## Answer

Frontend example — File: `@app/src/boundary/filters.ts`

```ts
export type Filters = {
  page: number;
  q: string;
};

function parsePage(value: unknown): number {
  if (typeof value !== "string") return 1;
  const n = Number(value);
  if (!Number.isFinite(n) || n < 1) return 1;
  return Math.floor(n);
}

function parseQuery(value: unknown): string {
  if (typeof value !== "string") return "";
  return value.trim();
}

export function parseFilters(input: { page?: unknown; q?: unknown }): Filters {
  return {
    page: parsePage(input.page),
    q: parseQuery(input.q),
  };
}
```
