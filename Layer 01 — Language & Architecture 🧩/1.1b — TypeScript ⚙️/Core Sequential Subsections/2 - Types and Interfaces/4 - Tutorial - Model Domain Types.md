# Tutorial — Model Domain Types 🧪

## Scenario

You’re building a checkout UI. The API returns a cart, and the UI needs a safe model for
rendering, updates, and error states.

## Task

- Define `CartItem` and `Cart` types.
- Define a `CartState` discriminated union.
- Write a `totalCents(cart)` helper.

## Hints

- Keep money as integer cents.
- Use discriminated unions for UI state.

## Starter

Frontend example — File: `@app/src/cart/model.ts`

```ts
export type CartItem = {
  // TODO
};

export type Cart = {
  // TODO
};

export type CartState = { status: "loading" } | { status: "error"; message: string } | { status: "ready"; cart: Cart };

export function totalCents(cart: Cart): number {
  // TODO
  return 0;
}
```

## Answer

Frontend example — File: `@app/src/cart/model.ts`

```ts
export type CartItem = {
  productId: string;
  name: string;
  priceCents: number;
  quantity: number;
};

export type Cart = {
  id: string;
  items: readonly CartItem[];
};

export type CartState = { status: "loading" } | { status: "error"; message: string } | { status: "ready"; cart: Cart };

export function totalCents(cart: Cart): number {
  return cart.items.reduce((sum, item) => sum + item.priceCents * item.quantity, 0);
}
```
