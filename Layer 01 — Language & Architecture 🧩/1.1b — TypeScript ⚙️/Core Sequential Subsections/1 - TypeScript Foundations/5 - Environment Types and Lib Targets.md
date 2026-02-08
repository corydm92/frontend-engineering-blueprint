# Environment Types and Lib Targets

## Goal

Align TypeScript’s type environment with the real runtime environment.

## What you learn

- What `lib` in `tsconfig` controls.
- How DOM vs Node type definitions affect code.
- How to avoid “missing type” or “wrong type” errors.

## Explanation

TypeScript’s standard library types are selected via `lib`. If you target the browser,
you need DOM types; if you target Node, you need Node types. Mismatches cause confusing
errors or false safety.

Keep lib targets aligned with your runtime targets and document them in the README.

## Example

Frontend example — File: `@app/tsconfig.json`

```json
{
  "compilerOptions": {
    "lib": ["ES2022", "DOM"],
    "types": []
  }
}
```

## Pitfalls

- Mixing DOM and Node types without intention (global type collisions).
- Assuming `lib` controls runtime availability (it only controls types).
