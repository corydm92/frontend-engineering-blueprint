# Objects and Prototypes

## Goal

Understand property lookup and inheritance so you can reason about object behavior.

## What you learn

- How property lookup walks the prototype chain.
- The difference between own properties and inherited ones.
- Why prototype pollution is a security risk.

## Explanation

Objects inherit from a prototype. When you access `obj.prop`, the engine checks own properties
first, then walks the prototype chain.

This makes shared behavior possible without classes, but it also creates security risks if
you merge untrusted input into plain objects.

## Example

Frontend example — File: `@app/src/foundations/prototype.ts`

```ts
const base = { kind: "base" };
const child = Object.create(base);
child.name = "child";

export function describe(obj: { name?: string }) {
  return `${obj.name ?? "unknown"} (${(obj as { kind?: string }).kind ?? "none"})`;
}

export const sample = describe(child); // "child (base)"
```

## Pitfalls

- Using `for...in` without `hasOwnProperty` checks.
- Merging untrusted input into objects without safeguards (prototype pollution).
