# TypeScript — Base Project Rules and Tooling ⚙️

These rules keep TypeScript meaningful rather than cosmetic.

## Non-negotiables

- Enable `strict` and treat type errors as build failures.
- Avoid `any`; prefer `unknown` + runtime validation at boundaries.
- Model domain types explicitly instead of patching with assertions.
- Prefer discriminated unions for UI state and state machines.
- Keep public types close to boundaries (forms, APIs, adapters).

## Ownership boundaries

- Frontend owns UI types and view models.
- Backend owns persistence models and request handlers.
- Shared packages own shared contracts only (DTOs, schemas).

## References

- TypeScript Handbook (official)
- `tsconfig` reference (official)
