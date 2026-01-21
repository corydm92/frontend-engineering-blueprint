# 1 — Blueprint Setup + Directory READMEs

## Goal

Create a predictable `/docs` structure and framing `README.md` files so contributors know where information lives before we write product code.

## Blueprint Structure

```
/docs
├─ __project/                       # Project-wide truth (overview, stack, ownership, review cadence)
├─ adr/                             # Architecture Decision Records (immutable decisions)
├─ blueprint/                       # Blueprint root (layers + section standards)
│  ├─ 00 System Initialization/
│  ├─ 01 Language & Architecture/
│  │  └─ 1.1 Section Example/       # Example Section showing the standard internal structure, will be generated for every layer
│  │     ├─ README.md
│  │     ├─ Base Project Rules and Tooling/
│  │     │  ├─ __Initialization/
│  │     │  │  └─ README.md
│  │     │  └─ README.md
│  │     ├─ Core Sequential Subsections/
│  │     │  └─ README.md
│  │     └─ Supporting Atomic Notes/
│  │        └─ README.md
│  ├─ 02 State & Framework/
│  │  └─ ...
│  ├─ 03 Quality & Stability/
│  │  └─ ...
│  ├─ 04 UI & Experience/
│  │  └─ ...
│  ├─ 05 Build & Delivery/
│  │  └─ ...
│  └─ 06 Security & Observability/
│     └─ ...
├─ process/                         # Workflows + templates used to run the project
└─ references/                      # Diagrams and external notes (supporting material, not canonical)

```

## Script Location

This step uses an existing script:

`scripts/init-docs.sh`

The script is already written. Please copy it to the base directory of your project

### Execute the script in your project

`chmod +x init-docs.sh && ./init-docs.sh`

## Verification

- `docs/` exists with: `_project`, `adr`, `blueprint`, `process`, `references`
- Each directory contains a `README.md`
- `docs/blueprint/layers/*` exists and each layer directory contains a `README.md`
- Script created only directories and `README.md` files (no other placeholders)

## Commit

Commit message:  
`feat(docs): add docs structure and directory README framing`
