# Type Checking in CI

## Goal

Make type checking a required gate so type drift is caught before merge.

## Architecture decisions

- CI runs `npm run typecheck` as a separate step.
- Type checking uses `--noEmit` to avoid artifacts.
- Fail fast on type errors.

## Steps

1. Ensure `typecheck` exists in `package.json`.
2. Add a CI step that runs it.

## Example

Frontend example — File: `@app/.github/workflows/ci.yml`

```yml
name: CI

on:
  pull_request:

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: "20"
      - run: npm ci
      - run: npm run typecheck
      - run: npm test
```

## Validation

- A PR with a type error fails CI.
- Fixing the type error passes without runtime changes.
