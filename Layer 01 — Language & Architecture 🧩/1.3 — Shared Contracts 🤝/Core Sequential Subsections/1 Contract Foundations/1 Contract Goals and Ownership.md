# Contract Goals and Ownership 🎯

## Goal

Establish what contracts are for and who owns them.

## What you learn

- Contracts define stable boundaries.
- One team owns schema changes.

## Explanation

Contracts are the agreement between producers and consumers: “this is the shape and meaning of the data we share.”
They work best when they live at boundaries (APIs, forms, events) and when changes are deliberate rather than accidental.

Ownership is the mechanism that keeps contracts from drifting. A named owner (team or role) is responsible for:
reviewing changes, approving breaking migrations, and keeping consumers informed.

Use a single owner per contract surface area (e.g., “user payloads,” “billing events”), even if multiple teams contribute code.
That keeps accountability clear when changes create downstream impact.

## Example

Backend example — File: `@app/src/contracts/README.md`

```md
# Contracts

Owner: Platform Team
Scope: API payloads and domain objects
```

## Pitfalls

- Treating contracts as “just types” encourages breaking changes without realizing it.
- Splitting ownership across many teams leads to drift and unreviewed changes.
