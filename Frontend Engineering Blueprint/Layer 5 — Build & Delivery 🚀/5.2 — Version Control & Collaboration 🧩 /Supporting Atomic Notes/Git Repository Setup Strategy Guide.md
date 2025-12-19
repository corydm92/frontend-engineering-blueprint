Git Repository Setup Strategy Guide
Version: v1.7
Last Updated: 10/28/25

Purpose:
Define a consistent, minimal process for setting up a new Git repository and initializing it locally after creation in GitHub.
This guide ensures all projects start with clear documentation, governance, and CI/CD structure before active development begins.

---

Phase 1 „ Repository Creation (GitHub Web)

1. Create Repository
´ Navigate to https://github.com/new
´ Set Repository Name:
Format: <product>-<function>-<domain>
Example: synct-frontend, tempo-api, design-system
´ Description: Short summary of purpose.
´ Visibility: Private (default) or Public if open-source.
´ Initialize with:
? README.md
? .gitignore (Node baseline)
? LICENSE (MIT or organization standard)

2. Add Default Branch Protection
´ Settings ? Branches ? Add rule
´ Protect main:
- Require pull request before merging.
- Require at least 1 approving review.
- Require status checks to pass (CI, lint, tests).
- Require signed commits.
- Automatically delete head branches after merge (Settings ? General ? Automatically delete head branches)

3. Add Repository Topics and Labels
´ Settings ? Topics ? Add relevant tags (frontend, react, nextjs).
´ Issues ? Labels ? Create workflow labels (bug, feature, docs, enhancement).

At this point, repository setup in GitHub is complete.
All further configuration and project additions must be done **locally** after cloning the repository.

---

Phase 2 „ Local Initialization (Developer Setup)

1. Clone Repository
git clone <repository-url>
cd <project-folder>

2. Verify Repository State
git status
git remote -v
git branch

---

Phase 3 „ Documentation Setup (Local)

1. Create /docs Directory Structure Locally
mkdir -p docs/adr docs/blueprint docs/process docs/architecture

2. Add Baseline Documentation
´ docs/adr/0001-project-setup-contract.md „ define framework, language, and stack.
´ docs/architecture/stack.md „ summarize chosen tools and architecture decisions.
´ docs/process/initialization-checklist.md „ record the system setup steps.
´ docs/blueprint/reference.md „ point to current blueprint version (e.g., v1.15).

3. Commit and Push Documentation
git add docs
git commit -m "docs: add baseline ADRs and project setup docs"
git push -u origin main

---

Phase 4 „ Branching and Commit Discipline

1. Strategy Selection
´ GitHub Flow „ small teams
´ Trunk-Based „ mid-size
´ Hybrid (Trunk + Releases) „ large orgs
´ GitFlow „ enterprise or SDK libraries
Reference: Branch Strategy Guide v1.1

2. Branch Naming
feature/<ticket>-<short-desc>
fix/<ticket>-<short-desc>
hotfix/<short-desc>
release/<version>
chore/<short-desc>

3. Commit Format (Conventional Commits)
feat: add login API
fix: resolve null pointer
chore: update lint config

4. Enforce Commit Rules
´ Install commitlint and husky locally:
pnpm add -D @commitlint/{config-conventional,cli} husky lint-staged
´ Enable hooks:
npx husky install
npx husky add .husky/commit-msg 'npx --no-install commitlint --edit "$1"'
´ Add .commitlintrc.cjs:
module.exports = { extends: ['@commitlint/config-conventional'] }

---

Phase 5 „ Framework and Project Setup (Local)

1. Language and Framework
´ Confirm project baseline matches ADR 0001 „ Project Setup Contract.
´ Framework: Next.js, Vite, or React (as defined in ADR 0001).
´ Language: TypeScript with strict mode enabled.
´ Install framework locally using pnpm:
pnpm create next-app@latest --ts
or
pnpm create vite@latest my-app --template react-ts
´ Verify initial boot:
pnpm dev
Access app at http://localhost:3000 (or framework default).

2. Build Tooling
´ Add ESLint + Prettier shared configuration.
´ Initialize TypeScript config (tsconfig.base.json).
´ Run initial lint, type, and build steps to verify baseline setup:
pnpm lint && pnpm type-check && pnpm build

3. Install Tooling (per Project Setup Contract ADR)
´ Node (LTS, e.g., v24)
´ pnpm (latest)
´ TypeScript (v5.6)
´ Verify installation:
node -v
pnpm -v
tsc -v

´ Ensure versions are tracked in package.json:
"engines": {
"node": ">=24.0.0",
"pnpm": ">=10.0.0"
}

4. Initialize Local Config
pnpm install
pnpm lint
pnpm test
pnpm dev (optional for framework verification)

5. Design System and Styling
´ Install and configure TailwindCSS, Chakra, or org standard UI framework.
´ Add base design tokens (colors, spacing, typography, motion).
´ Add accessibility linting (jsx-a11y).

6. Testing Baseline
´ Install Jest or Vitest + React Testing Library.
´ Add a basic smoke test under /tests.
´ Verify local run:
pnpm test

---

Phase 6 „ CI/CD and Automation (Local to Remote)

1. Add GitHub Actions Workflow
mkdir -p .github/workflows
touch .github/workflows/ci.yml

Example:
name: CI
on: [pull_request]
jobs:
build:
runs-on: ubuntu-latest
steps:
- uses: actions/checkout@v3
- uses: pnpm/action-setup@v3
with:
version: 10
- run: pnpm install --frozen-lockfile
- run: pnpm lint && pnpm type-check && pnpm test

git add .github/workflows/ci.yml
git commit -m "ci: add base workflow"
git push origin main

2. Add Dependabot Configuration
Create `.github/dependabot.yml` locally:
version: 2
updates:
- package-ecosystem: "npm"
directory: "/"
schedule:
interval: "weekly"
Commit and push.

3. Optional: Release Automation
´ Add `.github/workflows/release.yml` for standard-version or semantic-release.
´ Commit and push to main.

---

Phase 7 „ Security and Access (GitHub Configuration)

1. Add Secrets (GitHub Web)
´ Settings ? Secrets and variables ? Actions
´ Add keys like:
API_KEY, DATABASE_URL, NEXTAUTH_SECRET

2. Enable Security Features
´ Settings ? Security ? Enable:
- Dependabot alerts
- Secret scanning
- Code scanning
- 2FA required for collaborators

3. Confirm Branch Protections
´ Require PR + 1 approval
´ Require CI checks
´ Require signed commits
´ Prevent force pushes

---

Verification Checklist

? Repository created via GitHub web
? Repo cloned locally
? ADR 0001 and baseline documentation added
? Node, pnpm, and TypeScript versions verified and tracked
? Framework installed and builds successfully
? Linting and testing pass locally
? CI pipeline passing in GitHub
? Branch protections and access controls verified
? Secrets securely configured in GitHub settings

---

References
´ Project Setup Contract ADR v0.2
´ Initialization Checklist v1.3
´ Branch Strategy Guide v1.1
´ Frontend Engineering Blueprint v1.15
´ GitHub Docs „ Managing Branch Protection Rules
´ GitHub Docs „ Configuring CI/CD with Actions
