# Contract Testing 🧪

## Rules

- Test schemas against real payload samples.
- Validate both success and failure cases.

## Example

Backend example — File: `@app/src/tests/contracts/user.test.ts`

```ts
import { z } from 'zod';

const UserSchema = z.object({ id: z.string() });

expect(UserSchema.safeParse({ id: '1' }).success).toBe(true);
```

## Gotchas

- Untested contracts drift quickly.
