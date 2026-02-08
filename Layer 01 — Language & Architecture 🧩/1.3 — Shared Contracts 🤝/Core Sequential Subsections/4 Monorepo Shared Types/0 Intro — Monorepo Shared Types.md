# Monorepo Shared Types — Summary

This subsection covers shared contract packages in a monorepo topology.

## Intro Note — What This Subsection Is For

Shared types in a monorepo act like a “single contract package” that multiple apps
and services import instead of re‑defining the same shapes.

**Use this when multiple packages need the same contracts**, such as:

- A web app and backend sharing request/response types
- Multiple frontend apps consuming the same API
- Tools and scripts that rely on a common data model

**What it solves**: duplication and drift between teams and packages.

**How it solves it**: you publish a dedicated contracts package inside the
monorepo with a clear build and versioning flow.

## Outcomes

- Create a shared contracts package with build outputs consumers can import.
- Publish and version contracts safely without breaking downstream apps.
- Keep shared types and runtime schemas discoverable and consistent.
