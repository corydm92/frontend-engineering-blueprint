# 7 - Docs Spec Adoption 🧾

## Goal

Add the Docs Spec to a new app so documentation is created, updated, and audited against a **single standard**.

## Architecture decisions

- Store the spec at `@app/docs/blueprint/Docs Spec.md` so it lives with the system docs.
- Link the spec from the top-level `README.md` to make it discoverable.
- Treat the spec as the **source of truth** for structure and formatting.

## Steps

1. Copy `Docs Spec.md` into `docs/blueprint/`.
2. Link the spec from the project `README.md`.
3. Enforce the spec for all new docs and audits.

## Example

File: `@app/docs/blueprint/Docs Spec.md`

```bash
mkdir -p docs/blueprint
cp ./Docs\ Spec.md docs/blueprint/Docs\ Spec.md
```

File: `@app/README.md`

```md
## 🧾 Docs Spec

See `docs/blueprint/Docs Spec.md` for formatting, structure, and audit rules.
```

## Validation

- The spec exists at `docs/blueprint/Docs Spec.md`.
- The project README links to the spec.
- New docs follow the spec without exceptions.
