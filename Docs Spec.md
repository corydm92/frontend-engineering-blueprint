# Docs Spec Master

## Purpose

This document is the **single, self-contained source of truth** for formatting, creating,
and auditing documentation in this repo. It should be portable to any project and still
fully define how to structure and write layers, sections, subsections, and notes.

## Non‑negotiable principles

- **Consistency beats creativity** for structure and formatting.
- **Separation of concerns** is required for cross‑stack tools (FE/BE/DB/Infra).
- **Quality and completeness** matter more than document length.
- **Authoritative sources** must be used for technical behavior when available.

## Audit Order (must follow)

When auditing, check in this exact order:

1. **Format standards** (markdown + emoji, no divider lines)
2. **Directory and file naming** (matches rules below)
3. **Initialization content** (complete implementation guide)
4. **Base Project Rules and Tooling quality**
5. **Core Sequential Subsections quality**
6. **Supporting Atomic Notes quality**

## Format Standards

All docs must follow these rules:

- Use markdown headers with `#` and `##` only.
- Use **very light, tasteful emojis** in headers.
- **Do not use divider lines** (`---`, `----`, or long character bars).
- Keep headings short and readable.
- All technical claims should align with **official documentation** when it exists.

### Code examples (required)

- Use fenced code blocks with a language hint (e.g. `ts`, `tsx`, `bash`).
- **Always include a mock file path** for code examples.
  - Example: `@app/src/flags/ldClient.ts`
- Use the **industry-standard library/tool** for the topic by default.
- **Path scope must match ecosystem**:
  - **Frontend-only** examples use `@app/src/...` and are labeled “Frontend example”.
  - **Backend-only** examples use `@app/src/...` and are labeled “Backend example”.
  - **Monorepo example** paths (e.g. `@app/packages/...`) must be labeled “Monorepo example”.
- Every example must **signal scope** in text (Frontend example / Backend example / Monorepo example).

### Documentation examples (required)

- Documentation examples must declare **scope and location** to remove ambiguity about where changes live.
- Use labels like “Frontend doc example”, “Backend doc example”, or “Monorepo doc example”.

## Structure and Naming Rules

### Layer naming

- `Layer XX — Name Emoji`
- `XX` is two digits (e.g. `05`).
- Use an em dash (`—`) between number and name.

### Section naming

- `X.Y — Section Name Emoji`
- `X` must match the layer number.
- `Y` is the subsection number within the layer.
- If a section must be split while preserving ordering, you may append a lowercase
  letter suffix to `Y`:
  - `1.1a — ...`
  - `1.1b — ...`

### Required section folders

Every section must include:

- `Base Project Rules and Tooling/`
  - `__Initialization/`
- `Core Sequential Subsections/`
- `Supporting Atomic Notes/`
- `README.md`

### Core Sequential Subsections

- Subsection folders use **incremented numbers** with a hyphen and **no dots**:
  - `1 - Foundations/`
- Files use **incremented numbers** with a hyphen and **no dots**. This can be as few or as many steps needed to fulfil the subsection conecpt requirements.
- The **intro file is the exception** and uses this format:
  - `0 Intro — <Subsection Name Without Number>.md`
  - `1 - Concept Name.md`
  - `2 - Next Concept.md`
  - `3 - Tutorial - Specific Walkthrough.md`
- **The tutorial is always the final file** in the sequence.
- The intro file uses the **0** prefix to mark it as the first item in the step flow.
- The intro file name should **match the parent directory** (minus any leading number and hyphen).
- The intro file provides the **human overview**: what the subsection is for, when to use it, and why it matters.

### Supporting Atomic Notes naming

- Single-topic notes with clear titles.
- No numbering required.

## Content Requirements by Doc Type

### 1) Section README

Must include:

- A plain description of what the section is for.
- The list of what it covers.
- A short “How to use” sequence.
- `## Versions` block:
  - `As of: <YYYY-MM-DD>` (the day the docs were authored/updated)
  - 3–8 bullets of the relevant tool/runtime versions (examples: `TypeScript v5.9.3`, `ECMAScript 2024`, `Node v20`, `Chrome baseline (evergreen)`)
  - If versions are unknown, explicitly say `Unknown (must be pinned before relying on this doc set)`.

### 2) Base Project Rules and Tooling

Must include:

- Non‑negotiable rules for the section topic.
- Required metadata (if applicable).
- Boundaries of responsibility (FE/BE/DB/Infra).
- References to **official documentation** for the tool/technology.

### 3) Initialization (`__Initialization`)

This is the **primary implementation guide** for the tool/technology.

Required:

- Full start‑to‑finish setup for a new or existing app.
- Concrete, project‑agnostic steps with code examples.
- **Architecture decisions** (utilities, module layout, folder structure).
- **Mock file paths** for every code example.
- **Primary focus:** bootstrap the tool into a project and make it usable **as fast as possible** with a minimal, working example.
- **Depth belongs in Core Sequential Subsections** (Initialization is the “get it running now” guide; Core is the deep dive).

**Separation of concerns rule**:

- If the tool spans multiple stacks, create **separate docs per domain**:
  - Frontend integration
  - Backend integration
  - Database migration safety
  - Infrastructure integration
- Do **not** mix FE + BE + DB + Infra steps in the same file.
- Cross‑references between domain docs are allowed.

### 4) Core Sequential Subsections

Each subsection must:

- Build on the previous step (no jumps).
- Be complete enough to guide implementation without gaps.
- Use authoritative sources when describing technical behavior.
- Include **architecture decisions** where relevant.
- Include **tutorials as the final step** in each subsection.
- Include **real code examples** with mock file paths.
- For **large tools/frameworks**, provide a **near‑complete ordered curriculum** (basics → advanced) before the tutorial.
- When a subsection grows long, **split it into directories** and end each directory with a tutorial that **encapsulates that directory’s topics**.
- If the tool is simple, a single sequence with one final tutorial is sufficient.
- Use a **handbook‑style progression** (like the TypeScript Handbook) as the model:
  - Basics → Everyday Types → Narrowing → Functions → Object Types → Type Manipulation → Generics → Keyof/typeof → Indexed Access → Conditional Types → Mapped Types → Template Literal Types → Classes → Modules → Advanced.
- If you split into directories, **each directory that contains step docs** must include its own tutorial as the final file in that directory.
- If the topic is narrow or not deep, keep a **single sequence** under the subsection and place one tutorial at the end.
- Tutorials should be **hands-on exercises** and must include the **answer/solution** in the same doc.
- Tutorials must include a **starter scaffold** (partial code) so readers fill in the solution instead of starting from scratch.
- Tutorial examples must be **self-contained** (do not reference undefined imports or external snippets).

### Core Doc Anatomy (required)

The goal is **handbook-quality docs**: short, scannable, and complete enough that a
reader can apply the concept immediately without guessing.

#### A) Directory Intro Docs (0 Intro — ...)

Every Core Sequential Subsection directory (and any nested directories inside it)
must start with a `0 Intro — <Name>.md` file.

**Required blocks**:

- A 2–4 paragraph summary that explains:
  - the mental model for the directory
  - what the directory covers, in order
  - where this knowledge sits in the system (boundary vs core logic)
- `## Outcomes` with 3–6 bullets.

**When introducing a tool/framework for the first time in the curriculum**, add an
extra block:

- `## Intro Note — What This Tool Is For` that includes:
  - a plain-language definition (1 short paragraph)
  - a concrete “use it when…” list (3–6 bullets)
  - a mini example (one short code block)

Template:

```md
# <Directory Name> — Summary

<2–4 short paragraphs>

## Outcomes

- ...
- ...
- ...
```

#### B) Core Concept Step Docs (1…, 2…, 3…)

Concept docs teach **one idea** and end with the common failure modes. These files
must be understandable in isolation, but should still fit the sequence.

**Required blocks (in this order)**:

- `## Goal` (1–2 sentences): what the reader can do after this doc.
- `## What you learn` (2–4 bullets): concrete outcomes, not vague topics.
- `## Explanation` (2–5 short paragraphs): describe the mechanism, tradeoffs, and
  when to choose this approach. If there are two common options, explicitly state:
  “Use A when…, Use B when…”.
- `## Example` (or multiple `## Example — <variant>` sections): each example must:
  - start with `Frontend example — File: ...` or `Backend example — File: ...`
  - include a mock file path in backticks
  - include a code fence with all required imports defined
- `## Pitfalls` (2–4 bullets): mistakes + impact (what breaks or gets worse).

**Optional blocks (use when relevant)**:

- `## Architecture Notes`: module boundaries, folder layout, ownership, and
  “where this code lives.” Use bullets.
- `## Validation`: how to verify behavior (commands, tests, or expected outcomes).

Template:

````md
# <Concept Name>

## Goal

<1–2 sentences>

## What you learn

- ...
- ...

## Explanation

<2–5 short paragraphs>

## Example

Frontend example — File: `@app/src/...`

```ts
// ...
```
````

## Pitfalls

- ...
- ...

````

#### C) Tutorials (final file in a directory)

Tutorials close the loop. They must be runnable in principle and include the
solution in the same file.

**Required blocks (in this order)**:

- `## Scenario`: 2–4 sentences describing the real situation.
- `## Task`: 3–6 bullets of what to implement.
- `## Hints`: 2–5 bullets that point to the key API/idea.
- `## Starter`: a partial scaffold with TODOs + mock file path.
- `## Answer`: the complete solution + mock file path.

Template:

```md
# Tutorial — <Title> 🧪

## Scenario

<2–4 sentences>

## Task

- ...
- ...

## Hints

- ...

## Starter

Frontend example — File: `@app/src/...`

```ts
// TODO
````

## Answer

Frontend example — File: `@app/src/...`

```ts
// full solution
```

```

#### D) Initialization Step Docs (__Initialization)

Setup docs are pragmatic checklists with validation.

**Required blocks (in this order)**:

- `## Goal`
- `## Architecture decisions` (2–5 bullets)
- `## Steps` (numbered list)
- `## Example` (file path + code)
- `## Validation` (2–4 bullets)

**Global writing rules**

- No placeholders like `<your framework>` in core docs unless the file is explicitly
  a template. Prefer concrete examples.
- No undefined imports in examples.
- Keep docs “tight”: short paragraphs, no filler, no motivational language.
- If a default behavior matters, state it explicitly (and show how to override it).

### Tutorial Requirements (checklist)

- Scenario + Task + Hints + Starter + Answer
- Starter scaffold is runnable with the context provided
- All referenced symbols are defined in the example (or inlined)

Tutorials must be **example‑driven walkthroughs** (mini guides) for a specific feature set.

### Exhaustive Coverage (beginner → advanced)

Core Sequential Subsections must be written to be **exhaustive enough that a reader does not
need to prompt for “missing fundamentals.”** Enforce this with two required docs at the
`Core Sequential Subsections/` root:

- `0 Curriculum Map.md`
  - Ordered beginner → advanced topic list for the section.
  - Any excluded topic must be explicitly listed with a 1-sentence reason.
- `0 Coverage Checklist.md`
  - Checkbox list mirroring the Curriculum Map.
  - Every topic must be either checked (covered) or explicitly waived (with a reason).

### Domain Coverage Rubrics (required)

For any section, select all applicable domain rubrics below. If a topic spans multiple
domains, satisfy **all** relevant rubrics. If no rubric fits, add a new rubric to this
spec **before** writing docs for that section.

**Global rules (apply to every rubric below):**

- The Curriculum Map must include at least one concrete topic per category.
- The Coverage Checklist must show each category as either covered (with doc links) or explicitly waived (with a reason).
- When in doubt, prefer “include a small concept doc” over waiving.
- Use official handbooks/specs/references to drive ordering and terminology when they exist.

#### Programming Language

Language docs must be exhaustive enough that a beginner can progress to advanced usage without
needing to ask “what about X?” for core semantics.

**Categories (required unless explicitly waived):**

- `Execution model`: evaluation order, call stack, scheduling, runtime phases.
- `Scope and binding`: names, lifetimes, closures, binding rules, common footguns.
- `Data and objects`: primitives vs objects, mutation rules, identity, copying, dispatch/inheritance model if applicable.
- `Modules and boundaries`: import/export model, dependency direction, circular deps, packaging conventions.
- `Async and concurrency`: promises/tasks/threads/events as applicable, cancellation, race-condition patterns.
- `Errors`: error propagation, error typing/shape conventions, debugging workflow.
- `Type system` (if the language has one): assignability, narrowing/refinement, generics/polymorphism, escape hatches.
- `Platform integration` (if applicable): environment APIs (browser/Node/VM), IO boundaries, security implications.

#### Framework / Tool / Paradigm

**Categories (required unless explicitly waived):**

- `Purpose + boundaries`: what it solves, what it does not, where it belongs.
- `Mental model`: core abstractions and how they compose.
- `Integration points`: APIs, adapters, build tooling, runtime environment.
- `Configuration`: minimal setup, common options, safe defaults.
- `Core workflow`: create → use → extend → debug.
- `Composition + extensibility`: plugins, hooks/middleware, layering, escape hatches.
- `Error modes`: common failures, how they surface, how to diagnose.
- `Performance`: what affects performance, how to measure, guardrails.
- `Security + safety`: boundary validation, dangerous defaults, untrusted input handling.
- `Testing + validation`: how to verify locally + in CI (unit/integration/e2e where relevant).
- `Migration + versioning`: upgrade strategy, breaking changes, compatibility windows.

Prefer “how it behaves” over “what it is.” Every category should include at least one
file-path-anchored example somewhere in the curriculum.

#### Runtime / Platform

**Categories (required unless explicitly waived):**

- `Targets + compatibility`: supported versions, feature gaps, polyfills/shims.
- `Execution model`: scheduling/threads/event loop specifics for the platform.
- `Capabilities + limits`: IO, memory, permissions, sandboxing, quotas.
- `Platform APIs`: the primary APIs and how to integrate safely.
- `Performance characteristics`: common bottlenecks + measurement approach.
- `Security boundaries`: isolation model, safe defaults, data access constraints.

#### Data / Storage

**Categories (required unless explicitly waived):**

- `Data model + invariants`: core entities, constraints, and integrity rules.
- `Access patterns`: reads/writes, query shapes, and expected workloads.
- `Consistency + transactions`: isolation/consistency model and implications.
- `Schema evolution`: migrations, backfills, rollback strategy.
- `Performance`: indexing, caching, and hot-path optimization.
- `Durability + recovery`: backups, restore procedures, failure recovery.
- `Security + privacy`: access control, encryption, PII handling.

#### Architecture / Patterns

**Categories (required unless explicitly waived):**

- `Problem + forces`: what problem it solves and the constraints that make it hard.
- `Core idea`: the mechanics and why they work.
- `When to use / when not`: decision criteria and anti-patterns.
- `Tradeoffs + alternatives`: what you gain/lose vs other approaches.
- `Implementation steps`: how to apply it in code, with boundary placement.
- `Validation`: how to verify the pattern is delivering the intended outcome.

#### Security / Privacy

**Categories (required unless explicitly waived):**

- `Threat model + assets`: what you’re protecting and from whom.
- `Attack surface`: entry points and trust boundaries.
- `Controls + mitigations`: concrete safeguards and safe defaults.
- `Failure modes`: how issues surface and how to detect them.
- `Monitoring + incident response`: alerts, runbooks, escalation path.
- `Compliance + data handling`: retention, access, and regulatory constraints.

#### Observability / Reliability

**Categories (required unless explicitly waived):**

- `Signals`: logs, metrics, traces, and what each is used for.
- `Instrumentation`: where to instrument and how to structure telemetry.
- `SLOs + SLIs`: targets, error budgets, and alert thresholds.
- `Dashboards + runbooks`: what to monitor and how to respond.
- `Failure modes`: known failures and recovery strategies.
- `Cost + sampling`: managing telemetry volume without losing signal.

#### Product / UX / Design Systems (if applicable)

**Categories (required unless explicitly waived):**

- `Principles + goals`: UX objectives and constraints.
- `Components + tokens`: core building blocks and theming strategy.
- `Interaction patterns`: states, feedback, empty/error/loading patterns.
- `Accessibility`: required standards and testing approach.
- `Usage guidelines`: do/don’t patterns and integration examples.
- `Performance impact`: how UI decisions affect performance.

#### Process / Delivery / Governance

**Categories (required unless explicitly waived):**

- `Workflow + roles`: steps, ownership, and responsibilities.
- `Artifacts`: required docs, templates, and review gates.
- `Automation`: CI/CD hooks, bots, and enforcement points.
- `Quality gates`: checks, approvals, and failure handling.
- `Metrics + SLAs`: what success looks like and how it’s measured.
- `Rollback + recovery`: how to unwind failures safely.

### Subsection Curriculum Template (required)

Each subsection directory must follow one of these two patterns.

**Pattern 1: Flat Subsection (no nested directories)**

1. `0 Intro — <Subsection Name>.md` (summary + outcomes)
2. `1 ...` through `N ...` concept docs (typically 2–6)
3. `N+1 Tutorial - ...` as the final file

**Pattern 2: Nested Subsection (directory of directories)**

- Parent directory contains:
  - `0 Intro — <Parent Name>.md` (summary + outcomes; optional tool intro note)
  - child directories (`1 ...`, `2 ...`, etc) that each represent a mini-subsection
- Each child directory follows Pattern 1 and ends with a tutorial.

**Rules**:

- Every directory starts with a `0 Intro — ...` summary doc.
- A tutorial is required for any directory that contains a learning sequence
  (`1 ...` step docs). Container directories that only contain `0 Intro` + child
  directories do not require a tutorial.
- Every concept doc must use the Core Doc Anatomy.
- Every concept doc must include at least one file‑path‑anchored example.

### Quality Gates (required)

- Concept docs include the required blocks (Goal, What you learn, Explanation, Example, Pitfalls).
- Every tutorial includes Starter + Answer with runnable context.
- Every concept doc includes a mock file path in examples.
- Every directory begins with `0 Intro — ...` and (when it contains step docs) ends with a tutorial.
- “Not Applicable” sections must be explicitly labeled when optional blocks are present but unused.

### 5) Supporting Atomic Notes

Each note must:

- Be single‑topic and concise.
- Include **rules**, **examples**, and **gotchas**.
- Include code examples with mock file paths when relevant.

## Creation Checklist (use for new sections)

1. Create the section folder name using the naming rules.
2. Add `README.md` with purpose + coverage + usage.
3. Add `Base Project Rules and Tooling/README.md` with non‑negotiables.
4. Add `Base Project Rules and Tooling/__Initialization/` with domain‑specific setup docs.
5. Add `Core Sequential Subsections/0 Curriculum Map.md` and `Core Sequential Subsections/0 Coverage Checklist.md`.
6. Add `Core Sequential Subsections/` with numbered folders and files.
6. Ensure the **last file in each subsection is a tutorial** with real code.
7. Add `Supporting Atomic Notes/` with focused notes and gotchas.

## Audit Checklist (use for corrections)

- Headers use `#` and `##` only.
- Emojis are minimal and tasteful.
- No divider lines.
- Names match required structure.
- Initialization docs are complete and separated by domain.
- Tutorials exist and are last in each subsection.
- All examples include **mock file paths** and code fences.
- Architecture decisions are explicitly documented.
- Quality matches this spec (doc anatomy, depth, and tutorial requirements).
```
