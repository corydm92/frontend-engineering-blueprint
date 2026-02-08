# JavaScript Runtime Baseline

## Goal

Establish a clear runtime target so syntax, modules, and platform APIs behave predictably.

## Architecture decisions

- Prefer ESM (`import`/`export`) for modern tooling.
- Document runtime targets explicitly (browser + Node version).
- Avoid relying on unspecified scheduling for correctness.

## Steps

1. Decide the runtime targets (e.g. evergreen browsers + Node 20).
2. Use ESM consistently.
3. Add a minimal smoke script to verify the runtime baseline.

## Example

Frontend example — File: `@app/package.json`

```json
{
  "type": "module",
  "engines": {
    "node": ">=20"
  },
  "scripts": {
    "smoke:node": "node ./scripts/smoke.mjs"
  }
}
```

Frontend example — File: `@app/scripts/smoke.mjs`

```js
import { setTimeout as delay } from "node:timers/promises";

await delay(10);
console.log("ok");
```

## Validation

- `npm run smoke:node` prints `ok`.
- The repo documents the minimum supported browser/Node targets.
