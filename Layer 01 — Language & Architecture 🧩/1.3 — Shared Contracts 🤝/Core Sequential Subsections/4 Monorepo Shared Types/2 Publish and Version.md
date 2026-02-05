# Publish and Version 🏷️

## Goal

Release contract packages without breaking consumers.

## What you learn

- Semantic versioning for shared packages.
- Consumers upgrade via package versions.

## Explanation

Publishing shared contracts is a coordination problem: consumers need to know when a change is safe, when it’s breaking, and how to migrate.
Semantic versioning is the basic communication tool for that:

- Patch: bugfixes that don’t change shape/meaning.
- Minor: backward-compatible additions (new optional fields, new endpoints/exports).
- Major: breaking changes (renames, removals, meaning changes, required fields).

Pair versioning with a release note or changelog that explains impact. A major version without a migration note is still a surprise break, just with a bigger number.

## Example

Monorepo example — File: `@app/packages/contracts/package.json`

```json
{
  "name": "@app/contracts",
  "version": "1.2.0"
}
```

## Pitfalls

- Publishing breaking changes as a minor version forces emergency fixes downstream.
- Treating version bumps as “busywork” removes the only signal consumers have.
