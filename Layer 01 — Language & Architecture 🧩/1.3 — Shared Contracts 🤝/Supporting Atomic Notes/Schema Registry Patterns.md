# Schema Registry Patterns 🧩

## Rules

- Use a single schema index file.
- Keep registry exports explicit.

## Example

Frontend example — File: `@app/src/schemas/index.ts`

```ts
export * from "./user";
export * from "./project";
```

## Gotchas

- Implicit exports make audits harder.
