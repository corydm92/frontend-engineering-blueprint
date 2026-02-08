# Mocking with MSW 🧪

## Rules

- Use MSW to simulate contract responses in frontend tests.

## Example

Frontend example — File: `@app/src/tests/mocks/handlers.ts`

```ts
import { rest } from "msw";

export const handlers = [
  rest.get("/api/users", (req, res, ctx) => {
    return res(ctx.json([{ id: "1", email: "a@b.com" }]));
  }),
];
```

## Gotchas

- Keep mock payloads aligned with contract updates.
