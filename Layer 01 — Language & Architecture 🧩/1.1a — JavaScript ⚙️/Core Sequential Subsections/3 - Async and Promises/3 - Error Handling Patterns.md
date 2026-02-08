# Error Handling Patterns

## Goal

Handle async errors while preserving context and intent.

## What you learn

- The difference between handling and hiding errors.
- How to add context without losing the root cause.
- Where to catch errors in a call chain.

## Explanation

Errors should be caught at boundaries: UI handlers, adapters, or integration points.
Catching too deep tends to hide failures or strip context.

When you do catch, add context and rethrow (or return a structured error). This makes
logs actionable without exploding noise.

## Example

Frontend example — File: `@app/src/data/errors.ts`

```ts
export class DataError extends Error {
  constructor(message: string, options?: { cause?: unknown }) {
    super(message);
    this.name = "DataError";
    // @ts-ignore - cause is supported in modern runtimes; kept loose for portability.
    this.cause = options?.cause;
  }
}
```

Frontend example — File: `@app/src/data/loadWithContext.ts`

```ts
import { DataError } from "@app/data/errors";

export async function loadJson(url: string, signal?: AbortSignal): Promise<unknown> {
  try {
    const res = await fetch(url, { signal });
    if (!res.ok) throw new Error(`HTTP ${res.status}`);
    return await res.json();
  } catch (err) {
    throw new DataError(`Failed to load ${url}`, { cause: err });
  }
}
```

## Pitfalls

- Catching too early and returning `null` (failures become “missing data”).
- Logging and rethrowing at every layer (noise, not signal).
