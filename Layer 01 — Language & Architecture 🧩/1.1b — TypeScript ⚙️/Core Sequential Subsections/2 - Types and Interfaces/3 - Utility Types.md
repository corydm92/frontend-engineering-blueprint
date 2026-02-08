# Utility Types

## Goal

Transform models without duplicating definitions.

## What you learn

- Common utilities (`Pick`, `Omit`, `Partial`, `Required`).
- How `Record` models lookup tables.
- When to use explicit types instead.

## Explanation

Utility types are great when the derived type is mechanically related to the source.
If the derived type is its own concept, give it a named type and document it.

## Example

Frontend example — File: `@app/src/domain/product.ts`

```ts
export type Product = {
  id: string;
  name: string;
  priceCents: number;
  description?: string;
};

export type ProductListItem = Pick<Product, "id" | "name" | "priceCents">;
export type ProductDraft = Omit<Product, "id">;

export type ProductById = Record<string, Product>;
```

## Pitfalls

- Stacking utilities until the type becomes unreadable.
- Using `Partial` for validation (it weakens guarantees).
