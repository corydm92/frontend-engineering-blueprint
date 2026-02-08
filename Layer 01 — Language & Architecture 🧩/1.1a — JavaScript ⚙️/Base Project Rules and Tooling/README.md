# JavaScript — Base Project Rules and Tooling ⚙️

These rules keep JavaScript correct under concurrency and prevent invisible failure modes.

## Non-negotiables

- Treat async work as concurrent by default; make ordering explicit.
- Never ignore a promise: `await` it or intentionally fire-and-forget with a comment.
- Use `AbortController` for user-driven or cancelable async work.
- Avoid hidden shared mutable state across async boundaries.
- Prefer named exports and clear module boundaries over barrel files everywhere.

## Ownership boundaries

- Frontend owns DOM, rendering, and browser API integration.
- Backend owns server runtime constraints and IO boundaries.
- Shared code owns environment-agnostic abstractions, not platform wiring.

## References

- MDN JavaScript Guide (official)
- MDN `Promise`, `async`/`await`, `AbortController` docs (official)
- ECMAScript specification (official)
