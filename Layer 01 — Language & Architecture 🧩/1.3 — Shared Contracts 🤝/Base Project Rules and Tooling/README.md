# Shared Contracts — Base Project Rules and Tooling 🤝

These rules define how contracts are authored, shared, and enforced across systems.

## Non‑negotiable rules

- A single **source of truth** owns the contract.
- Contracts must include **runtime validation** at system boundaries.
- Breaking changes require a **migration plan** and **version strategy**.
- Each contract has an **owner** and **compatibility window**.

## Ownership boundaries

- **Backend** owns authoritative domain rules.
- **Frontend** consumes contracts and must not redefine them.
- **Monorepo** shared packages are allowed when multiple apps share the same contract.

## Required metadata

- contract name
- owner
- version
- compatibility window
- deprecation policy

## References

- Zod: https://zod.dev/
- GraphQL Code Generator: https://the-guild.dev/graphql/codegen
- OpenAPI: https://spec.openapis.org/oas/latest.html

## Initialization

Follow the step‑by‑step implementation guide in `__Initialization` for setup.
