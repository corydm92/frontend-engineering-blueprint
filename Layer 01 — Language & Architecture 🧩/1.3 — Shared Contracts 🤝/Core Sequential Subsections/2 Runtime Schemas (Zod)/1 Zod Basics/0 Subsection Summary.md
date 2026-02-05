# 1 Zod Basics — Summary 🧭

This directory establishes the **runtime‑first mental model**: a schema is a
validator at runtime, parsing is the boundary, and errors are structured data you
can render in UI or APIs.

We start with the first schema, then compare `parse` vs `safeParse`, then learn how
to format errors into user‑friendly shapes. The tutorial closes the loop by
validating a real form payload.

## Outcomes

- Define a first schema and derive a type from it.
- Choose the right parsing mode for a given flow.
- Turn errors into field‑level messages for UI.
