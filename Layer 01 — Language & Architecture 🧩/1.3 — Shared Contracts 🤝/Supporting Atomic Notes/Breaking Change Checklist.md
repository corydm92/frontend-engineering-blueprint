# Breaking Change Checklist ✅

## Rules

- Add a migration window.
- Communicate changes to consumers.
- Release contract changes before app changes.

## Example

Backend doc example — File: `@app/src/contracts/MIGRATION.md`

```md
Change: Add `role` (required)
Window: 2 weeks
Owner: Platform Team
```

## Gotchas

- Breaking without a window causes silent failures.
