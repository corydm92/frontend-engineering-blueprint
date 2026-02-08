# Lexical Environments and Scope

## Goal

Understand how JavaScript resolves identifiers so you can predict variable lookup.

## What you learn

- What “lexical scope” means in practice.
- How scope chains are created.
- Why `let` and `const` are block-scoped.

## Explanation

JavaScript uses **lexical scope**: where a function is _defined_ determines which variables
it can see. When the engine evaluates an identifier, it walks the scope chain outward until
it finds a binding or reaches the global scope.

Block scope (`let`/`const`) prevents accidental re-use and makes lifetime explicit. It is
a core tool for correctness in async code and loops.

## Example

Frontend example — File: `@app/src/foundations/scope.ts`

```ts
const prefix = "user:";

export function makeKey(id: string): string {
  const localPrefix = prefix.toUpperCase();
  return `${localPrefix}${id}`;
}
```

## Pitfalls

- Assuming a variable is “shared” when it’s actually block-scoped.
- Shadowing outer variables and creating subtle bugs.
