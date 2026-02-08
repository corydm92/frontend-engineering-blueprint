# Compatibility Windows ⏳

## Goal

Define how long old contracts remain valid.

## What you learn

- Deprecation windows reduce breakage.
- Versioning aligns releases.

## Explanation

Compatibility windows are the safety buffer that let consumers upgrade without being surprised.
Instead of removing or changing a contract immediately, you deprecate it, keep it working for a defined period, and provide a migration path.

A compatibility window should be concrete and observable. The minimum useful policy is:

- Deprecation date: when the old behavior is considered legacy and should no longer be used.
- Removal date: when it will be removed (or when breaking behavior will ship).

Pair the window with versioning. In a package world, semver communicates the “shape of the change,” while the window communicates “how long you have.”

## Example

Backend doc example — File: `@app/src/contracts/COMPATIBILITY.md`

```md
Deprecated: 2026‑02‑01
Removal: 2026‑03‑01
```

## Pitfalls

- Setting a window without a migration path just delays the break.
- Not communicating dates to consumers turns a “window” into an invisible deadline.
