# Schema Ownership 🧬

## Goal

Define who owns the GraphQL schema and how it changes.

## What you learn

- Schema changes require review and versioning.
- Ownership prevents drift.

## Explanation

GraphQL schemas are shared contracts. When “anyone can change anything,” clients drift, generated types stop matching reality, and fixes become reactive.
Schema ownership makes change intentional: a single team (or named role) is accountable for reviewing schema PRs and coordinating breakage.

The owner is responsible for:

- Reviewing schema diffs for breaking changes.
- Ensuring deprecations include a migration path and timeline.
- Keeping consumers informed when changes impact generated code.

Ownership does not block contributions. It makes impact visible and ensures one place is responsible for compatibility.

## Example

Backend doc example — File: `@app/src/graphql/README.md`

```md
Owner: API Team
Schema: /src/graphql/schema.graphql
```

## Pitfalls

- “Shared ownership” with no accountable owner leads to unreviewed breaking changes.
- Treating schema changes as internal refactors ignores the downstream cost to consumers.
