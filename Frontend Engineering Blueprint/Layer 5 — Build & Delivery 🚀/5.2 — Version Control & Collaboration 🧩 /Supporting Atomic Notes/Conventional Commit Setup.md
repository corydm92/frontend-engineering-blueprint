Conventional Commit Setup

Last updated: 10/26/25

Purpose
Establish predictable, atomic commit discipline and semantic versioning automation.
Implements Conventional Commits, commitlint, Husky, and standard-version.

---

Why It Matters
Clear, structured commit messages improve collaboration, changelog accuracy, and automated versioning pipelines.
(googlable reference: conventional commits best practices)

---

Setup Steps

1. Install Dependencies
pnpm add -D @commitlint/{config-conventional,cli} husky lint-staged standard-version

2. Initialize Husky
npx husky install
npx husky add .husky/commit-msg 'npx --no-install commitlint --edit "$1"'

3. Configure Commitlint
Create file: .commitlintrc.cjs
module.exports = { extends: ['@commitlint/config-conventional'] }

4. Add NPM Scripts
Add to package.json:
"scripts": {
"release": "standard-version",
"prepare": "husky install"
}

5. Optional „ Pre-commit Hooks
Run lint, type, and test before each commit.
(googlable reference: husky lint-staged precommit)
npx husky add .husky/pre-commit "pnpm lint && pnpm type-check && pnpm test"

6. Verify
pnpm lint
pnpm type-check
pnpm test
git commit -m "chore(ci): add commitlint and husky setup"

Expected: commit passes hook, semantic message required.

---

Release Automation
Generate changelog and semantic version tags
(googlable reference: standard-version automated changelog)

pnpm release
git push --follow-tags origin main

---

Summary Checklist
[ ] Commitlint config created
[ ] Husky hooks installed
[ ] release script configured
[ ] Verified commit message validation
[ ] Tested changelog generation
