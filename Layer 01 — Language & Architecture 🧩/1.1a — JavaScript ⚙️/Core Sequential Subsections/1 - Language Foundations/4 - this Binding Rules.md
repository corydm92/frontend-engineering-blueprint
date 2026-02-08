# this Binding Rules

## Goal

Predict `this` across call sites to avoid accidental undefined or global access.

## What you learn

- How `this` is bound at call time.
- The difference between method calls and bare function calls.
- How arrow functions capture `this` lexically.

## Explanation

`this` is not lexical; it is bound **by the call site**. A function called as a method
(`obj.fn()`) gets `this = obj`, while a bare call (`fn()`) typically gets `undefined` in
strict mode.

Arrow functions do not have their own `this`; they close over the enclosing `this`, making
them safer for callbacks and event handlers.

## Example

Frontend example — File: `@app/src/foundations/thisRules.ts`

```ts
export const user = {
  name: "Cory",
  greet() {
    return `hi ${this.name}`;
  },
  greetLater() {
    setTimeout(() => {
      console.log(this.greet());
    }, 0);
  },
};
```

## Pitfalls

- Passing a method as a callback without binding (`this` becomes undefined).
- Using `function` instead of arrow in callbacks when you need lexical `this`.
