# 8 - Shared Docs via Subtree (Optional) 🌳

## Goal

Use a **single docs repo as the source of truth** while letting each app contribute updates
via PRs and pull daily refreshes.

## Architecture decisions

- The shared docs live in a dedicated **master repo** (source of truth).
- Consuming apps vendor docs at `docs/blueprint/` using a **git subtree**.
- **No force push** to main in the master repo; updates land **only via PRs**.
- Each consuming app **pulls daily** to stay current.

## Steps

1. Add the master docs repo as a remote in the consuming app.
2. Add it as a subtree at `docs/blueprint/`.
3. Make local docs edits inside `docs/blueprint/`.
4. Push changes upstream as a **PR branch** to the master repo.
5. Add the update workflow template for daily syncs.
6. Pull daily updates from master into each consuming app.

## Example (actionable steps)

### 1) One‑time setup

File: `@app/docs/blueprint/README.md`

```bash
git remote add blueprint git@github.com:<you>/engineering-blueprint.git
git fetch blueprint
git subtree add --prefix=docs/blueprint blueprint main --squash
```

### 2) Add the daily workflow

File: `@app/.github/workflows/update-blueprint-docs.yml`

```bash
cp "Layer 00 — System Initialization ⚙️/0.1 — Setup Blueprint System In Project 🧭/Base Project Rules and Tooling/_Initialization/workflows/update-blueprint-docs.yml" .github/workflows/update-blueprint-docs.yml
```

Set repository variables:

- `BLUEPRINT_REPO` (e.g. `git@github.com:<you>/engineering-blueprint.git`)
- `BLUEPRINT_BRANCH` (default: `main`)

### 3) Local pull/push scripts (package.json)

File: `@app/package.json`

```json
{
  "scripts": {
    "docs:pull": "git fetch blueprint && git subtree pull --prefix=docs/blueprint blueprint main --squash",
    "docs:split": "git subtree split --prefix=docs/blueprint -b blueprint-<topic>",
    "docs:upstream": "bash -lc 'read -p \"Branch name: \" BRANCH; read -p \"Commit message: \" MSG; test -n \"$BRANCH\" && test -n \"$MSG\" || (echo \"Branch name and commit message are required\"; exit 1); git add docs/blueprint && git commit -m \"$MSG\" && git subtree split --prefix=docs/blueprint -b \"$BRANCH\" && git push blueprint \"$BRANCH\":refs/heads/\"$BRANCH\"'"
  }
}
```

Usage:

```bash
# daily refresh
npm run docs:pull

# upstream changes via PR branch
npm run docs:split
git push blueprint blueprint-<topic>:refs/heads/blueprint-<topic>
```

```bash
# one-shot upstream with prompts
npm run docs:upstream
```

## Enforcement rules

- No force pushes to master main.
- All updates to master docs go through PRs.
- Each app runs a **daily subtree pull** to stay current.

## Validation

- `docs/blueprint/` exists and matches the master repo structure.
- The update workflow exists at `.github/workflows/update-blueprint-docs.yml`.
- Updates are merged into master via PRs only.
- Each consuming app can pull the latest docs without conflicts.
