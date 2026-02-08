# Hoisting and the Temporal Dead Zone

## Goal

Predict declaration behavior so you don’t rely on accidental ordering.

## What you learn

- How `var`, `let`, and `const` differ during initialization.
- What the temporal dead zone (TDZ) means.
- Why function declarations behave differently from function expressions.

## Explanation

Declarations are processed before execution. `var` bindings are hoisted and initialized to
`undefined`, while `let` and `const` are hoisted but uninitialized — accessing them before
their declaration throws a `ReferenceError` (the TDZ).

Function declarations are hoisted with their full body, while function expressions are not.

## Example

Frontend example — File: `@app/src/foundations/hoisting.ts`

```ts
export function demo() {
  // `var` is hoisted and initialized to undefined.
  console.log(typeof laterVar); // "undefined"
  var laterVar = 1;

  // `let` is hoisted but uninitialized (TDZ).
  // console.log(laterLet); // ReferenceError
  let laterLet = 2;

  return laterVar + laterLet;
}
```

## Pitfalls

- Relying on `var` hoisting for control flow.
- Using `let`/`const` before declaration (TDZ errors).
