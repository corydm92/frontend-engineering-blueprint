# OpenAPI Codegen 📄

## Rules

- Use OpenAPI for REST‑first systems that need shared types.

## Example

Backend doc example — File: `@app/src/openapi.yml`

```yml
openapi: 3.1.0
info:
  title: API
  version: 1.0.0
```

## Gotchas

- Ensure generated code is committed or reproducible in CI.
