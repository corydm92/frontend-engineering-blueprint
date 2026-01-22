# 2 — Generate Project Master Blueprint (Seed)

## 🎯 Goal

Create the **Project Master Blueprint** — the first authoritative, project-owned document that defines how this project will apply the Blueprint System.

This step converts guidance into intent.

Until this document exists, the Blueprint System is installed but **not yet authoritative**.

## 📦 What This Step Produces

This step produces **one artifact**:

- `docs/blueprint/PROJECT_MASTER.md` — the Project Master Blueprint

This document:

- Is owned by the project
- Is derived from a Blueprint System Guide
- Becomes the canonical reference for project standards and constraints
- Serves as the source of truth for all future Blueprint System artifacts

No layer rules are encoded yet  
No tooling is configured yet  
No ADRs are created yet

This step establishes **authority**, not implementation.

## 🧠 Mental Model

Think of the Project Master Blueprint as the project’s **constitutional document**.

- **Blueprint System Guides** explain what the system is and how it works
- The **Project Master Blueprint** defines how this specific project applies it
- All Blueprint System artifacts must trace back to this document

The flow is intentional:

- Guides → inform thinking
- Project Master Blueprint → commits intent
- Blueprint System artifacts → encode and enforce decisions

If someone asks, “Why does this project do it this way?”,  
the answer should point here first.

## 📚 How This Document Is Created

Choose **one** Blueprint System Guide as your starting point:

- **Public Edition** — lightweight, exploratory adoption
- **Team Edition** — balanced default for most teams
- **Master Edition** — deep, opinionated starting point

Then:

- Copy the chosen Guide into the project
- Rename it to `PROJECT_MASTER.md`
- Edit it to reflect:
  - the project’s context
  - constraints
  - scope
  - deviations
  - governance expectations

The Guide becomes **project-specific** at this point.

The original Guide remains an upstream reference and does not change.

## 🚫 Explicit Non-Goals

This step does **not**:

- Install the Blueprint System (already done in Step 1)
- Populate layer directories with rules or setup steps
- Configure tooling or infrastructure
- Create ADRs or stack summaries
- Encode enforcement mechanisms

Those happen **after** project intent is defined.

## 🛠 Setup Steps

1. Select a Blueprint System Guide and version  
   Decide which Guide best matches the project’s maturity and goals.

2. Copy the Guide into the project  
   Place it under `docs/blueprint/` and rename it to `PROJECT_MASTER.md`.

3. Edit the document to reflect project reality  
   Remove irrelevant sections, add constraints, and clarify scope.

4. Review for authority  
   Confirm this document clearly answers:
   - What are we building?
   - How are we applying the Blueprint?
   - What constraints shape all downstream decisions?

Once complete, the Blueprint System becomes authoritative for this project.

## ✅ Verification

- `docs/blueprint/PROJECT_MASTER.md` exists
- It is derived from a single Blueprint System Guide
- Project-specific context and constraints are explicit
- The document is treated as the primary standards reference
- No system artifacts are created without aligning to it

If all checks pass, proceed with the remaining Layer 0 setup steps.
