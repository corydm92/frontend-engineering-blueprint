# Docs Spec

## Purpose

Define the formatting, structure, and quality bar for all documentation in this repo.
Use this file as the **single source of truth** for doc audits and new writing.

## Audit Order (must follow)

When asked to audit, check **in this exact order**:

1) **Format standards** (markdown style + emojis, no divider lines)
2) **Directory and file naming** (matches Master structure)
3) **Initialization docs quality** (5.5 init + 0.1 init)
4) **Base Project Rules and Tooling quality** (5.5 baseline)
5) **Core Sequential Subsections quality** (2.3 Next.js baseline)
6) **Supporting Atomic Notes quality** (1.1 baseline)

## Format Standards

All docs must follow these rules:

- Use markdown headers with `#` and `##`.
- Use **very light, tasteful emojis** in headers.
- **Do not use divider lines** (`---`, `----`, or long character bars).
- Keep headings consistent and readable.
- Technical topics must be **fully encompassing** and grounded in authoritative sources.
- If official documentation exists for a technical topic, **use it as the primary reference** and align terminology and definitions to it.

Formatting references:
- `Layer 00 — System Initialization ⚙️/0.1 — Setup Blueprint System In Project 🧭/Base Project Rules and Tooling/_Initialization/1 - Blueprint System Setup.md`
- `Layer 05 — Build & Delivery 🚀/5.5 — Trunk-Based + Feature Flag CI CD 🚦/Base Project Rules and Tooling/__Initialization/Trunk-Based + Feature Flag CI CD with Docker Vercel and NPM - Initialization.md`

## Structure and Naming Rules

All folder and file names must follow the **Master Guide** example exactly:

- `Blueprint Project Guide (Master Edition).md` → **Example of Full Blueprint Structure**
- Core Sequential Subsections use **numbered, incremented folders and files** with **no dots**:
  - Folder: `1 Mental Model/`
  - File: `0 Subsection Summary.md`

## Quality Bar (by doc type)

### System Initialization (structure + quality)

Use these as the reference standard:
- `Layer 00 — System Initialization ⚙️/0.1 — Setup Blueprint System In Project 🧭/Base Project Rules and Tooling/_Initialization`
- `Layer 05 — Build & Delivery 🚀/5.5 — Trunk-Based + Feature Flag CI CD 🚦/Base Project Rules and Tooling/__Initialization`

### Base Project Rules and Tooling (quality)

Baseline reference:
- `Layer 05 — Build & Delivery 🚀/5.5 — Trunk-Based + Feature Flag CI CD 🚦/Base Project Rules and Tooling/README.md`

### Core Sequential Subsections (quality)

Baseline reference:
- `Layer 02 — State & Framework 🔄/2.3 — Framework (Next.js)/Core Sequential Subsections`

Expectations:
- Each step builds on the last (no jumps).
- Clarity and depth matter more than length.
- Use the same level of rigor across all layers.
- Technical subsections should be **complete enough to guide implementation** without gaps.
- Prefer verified, authoritative references when describing technical behavior.

### Supporting Atomic Notes (quality)

Baseline reference:
- `Layer 01 — Language & Architecture 🧩/1.1 — TypeScript & JavaScript ⚙️/Supporting Atomic Notes`

Expectations:
- Focused, single-topic notes.
- Clear rules, examples, and quick guidance.
- Match the formatting standards above.
