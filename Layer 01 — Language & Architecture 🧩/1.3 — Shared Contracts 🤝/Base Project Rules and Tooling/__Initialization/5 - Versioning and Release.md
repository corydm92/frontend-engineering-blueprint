# 5 - Versioning and Release 🏷️

## Goal

Ship contract updates safely without breaking consumers.

## Architecture decisions

- Contracts follow semver.
- Breaking changes require a migration window.

## Steps

1. Bump contract version on breaking changes.
2. Release contracts before dependent apps update.

## Example

Backend doc example — File: `@app/src/contracts/CHANGELOG.md`

```md
## 1.2.0

- Add `role` field to User
```

## Validation

- Consumers can upgrade with a clear change log.
- Breaking changes are flagged before release.
