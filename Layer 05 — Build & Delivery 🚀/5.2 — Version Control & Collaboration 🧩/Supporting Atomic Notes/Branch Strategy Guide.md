Branch Strategy Guide
Version: v1.1
Last Updated: 10/28/25

Purpose:
Define a consistent branching model for development, integration, and release management across all repositories.
Branch strategies determine how teams collaborate, integrate, and deliver code predictably.
This guide provides four proven strategies with clear use cases, rules, and best practices.

---

1. Trunk-Based Development
Best for: Small to mid-size teams, CI/CD-first environments, high release velocity.

Summary:
• One long-lived branch: main (or trunk).
• Short-lived feature branches created directly from main.
• Continuous integration ensures main is always deployable.

Key Branches:
main
feature/<ticket-id>-<short-description>

DO:
• Merge daily or multiple times per week (trunk based development best practices).
• Keep branches short-lived (1–3 days) to avoid drift (branch lifespan best practices).
• Use feature flags to hide unfinished work (feature flag rollout strategy frontend).

DON’T:
• Maintain long-lived feature branches (branch drift anti pattern).
• Merge broken or untested code (CI gate enforcement DevOps).
• Stack dependent branches before merging to main (PR dependency anti pattern).

Example Flow:
feature/123-user-auth → PR → CI → Review → Merge → main → Auto Deploy

Why It Works:
• Simplifies CI/CD automation.
• Encourages rapid feedback and integration.
• Reduces merge conflicts and deployment risk.

---

2. GitHub Flow
Best for: SaaS products, web apps, or teams practicing continuous deployment.

Summary:
• One main branch.
• Create feature or fix branches from main.
• Merge via pull request after CI passes and review completes.
• Each merge to main triggers automatic deployment.

Key Branches:
main
feature/<ticket-id>-<short-description>
fix/<ticket-id>-<short-description>

DO:
• Automate build, lint, test, and deploy on merge (GitHub Actions CI CD pipeline setup).
• Use PR templates and required review approvals (pull request review template GitHub).
• Tag each deployment with semantic version (semantic version tagging GitHub).

DON’T:
• Merge without review or green CI (review bypass anti pattern).
• Push untested code directly to main (manual push anti pattern).
• Keep unmerged work isolated for long periods (integration lag anti pattern).

Example Flow:
feature/456-integrate-analytics-sdk → PR → CI → Review → Merge → main → Auto Deploy

Why It Works:
• Lightweight and easy to maintain.
• Enables fully automated deployments.
• Ideal for fast-moving web or product teams.

---

3. GitFlow
Best for: Enterprise applications or SDKs requiring strict release management.

Summary:
• Two long-lived branches: main (stable) and develop (integration).
• feature, release, and hotfix branches manage parallel workstreams.
• Releases are versioned and tagged for traceability.

Key Branches:
main
develop
feature/<ticket-id>-<short-description>
release/<version>
hotfix/<short-description>

DO:
• Protect main and develop with branch rules (branch protection GitFlow).
• Tag releases with semantic versioning (semantic versioning git tagging).
• Merge hotfixes back into both main and develop (merge backflow GitFlow best practices).

DON’T:
• Merge directly into main (bypass release management anti pattern).
• Skip integration tests on release branches (release testing best practices).
• Let develop drift too far from production (merge sync anti pattern).

Example Flow:
feature/789-add-billing-api → PR → CI → Review → Merge → develop → release/2.2.0 → QA → Merge → main → Tag → Deploy → Merge Back → develop

Why It Works:
• Provides structured release control.
• Clear visibility into production vs. development code.
• Supports parallel feature and stabilization phases.

---

4. Hybrid Strategy (Trunk + Release Branches)
Best for: Larger teams managing multiple environments or frequent patch releases.

Summary:
• main remains the single source of truth.
• release branches created temporarily for stabilization.
• hotfixes branched from main and merged back post-release.

Key Branches:
main
release/<version>
feature/<ticket-id>-<short-description>
hotfix/<short-description>

DO:
• Freeze release branches after feature cutoff (release freeze best practices).
• Merge back to main and tag after release (post release merge policy).
• Use feature flags for progressive rollout (progressive delivery frontend).

DON’T:
• Keep release branches open indefinitely (stale release branch anti pattern).
• Deploy directly from feature branches (deployment source consistency).
• Skip tagging after merges (missing tag release tracking anti pattern).

Example Flow:
feature/312-user-settings-panel → PR → CI → Review → Merge → main → release/2.3.0 → QA → Tag → Deploy → Merge Back → main

Why It Works:
• Balances continuous integration with controlled delivery.
• Reduces deployment risk during stabilization windows.
• Scales easily with environment-based pipelines.

---

5. Library / SDK Release Flow
Best for: Open-source or internal packages requiring versioned distributions.

Summary:
• main branch is always stable and published.
• Each release is tagged semantically (v1.2.3, v1.2.4).
• Changes follow commit conventions to drive automation.

Key Branches:
main
feature/<ticket-id>-<short-description>
fix/<ticket-id>-<short-description>

DO:
• Automate publishing via CI after tag creation (semantic release npm publish pipeline).
• Generate changelogs from Conventional Commits (changelog generation standard-version).
• Keep main always buildable and versioned (main branch stability best practices).

DON’T:
• Publish manually from local machines (manual publish risk npm).
• Push breaking changes without major version bump (semantic versioning breaking change policy).
• Skip tagging or changelog updates (version traceability anti pattern).

Example Flow:
feature/987-new-api-method → PR → Review → Merge → main → Tag (v1.2.3) → npm publish → Notify

Why It Works:
• Guarantees version consistency and traceability.
• Automates package publishing lifecycle.
• Reduces manual release risk in library projects.

---

Branch Strategy Selection Matrix

Team Size / Type | Recommended Strategy
------------------------------------------------------------
1–5 engineers (startup) | GitHub Flow
6–20 engineers (growth stage) | Trunk-Based Development
20+ engineers (enterprise) | Hybrid (Trunk + Release Branches)
Open-source / SDK teams | GitFlow or Library Flow

---

Merge and Review Policy

1. All merges must pass CI (lint, type, test) before approval.
2. At least one reviewer required per pull request.
3. Use squash merges for features; rebase merges for long-lived branches.
4. Tag every release merge to main with semantic version.
5. Protect main (and develop if used) via branch protection rules.
6. Automatically delete merged branches.

---

Pull Request Lifecycle

1. Create branch using naming convention (feature/, fix/, hotfix/).
2. Commit using Conventional Commits (feat:, fix:, chore:, docs:, etc.).
3. Push branch and open PR with clear summary and checklist.
4. Run automated tests, lint, and type checks.
5. Request peer review and approval.
6. Merge into main after green build and approval.
7. Tag release if applicable and trigger deploy.

---

Recommended Branch Protection Rules

• Require pull request before merging.
• Require status checks to pass before merge (lint, type, test, build).
• Require signed commits and verified authors.
• Enforce linear history (no merge commits on main).
• Automatically delete merged branches.
• Restrict force pushes and direct merges to protected branches.
• Require issue or ticket reference in PR description.

---

Example Branch Flows Summary

Trunk-Based Example:
feature/123-user-auth → PR → CI → Review → Merge → main → Auto Deploy

Steps:
1. Developer creates a new branch named feature/123-user-auth from main.
2. Commits and pushes small, frequent changes (1–3 day lifespan).
3. Opens a Pull Request for review and automated CI checks (lint, test, type-check).
4. Another engineer reviews and approves after green build.
5. The branch is merged directly into main.
6. CI automatically deploys main to the production or staging environment.
7. Branch is deleted after merge — main remains always deployable.

---

GitHub Flow Example:
feature/456-integrate-analytics-sdk → PR → CI → Review → Merge → main → Auto Deploy

Steps:
1. Engineer branches off main with feature/456-integrate-analytics-sdk.
2. Develops and commits incremental changes related to the analytics feature.
3. Opens a Pull Request once work is complete and CI pipeline runs.
4. Reviewer approves after all checks pass.
5. Merge completes directly into main.
6. Merge triggers automatic deployment to production via CI/CD pipeline.
7. The feature becomes live immediately; rollback handled via Git tag or deployment automation.

---

Hybrid Example:
feature/312-user-settings-panel → PR → CI → Review → Merge → main → release/2.3.0 → QA → Tag → Deploy → Merge Back → main

Steps:
1. Developer branches off main: feature/312-user-settings-panel.
2. After completing the feature, a Pull Request is created for review.
3. CI validates the branch — lint, type, test all pass.
4. Once approved, the feature branch merges into main.
5. A release branch (release/2.3.0) is created for QA stabilization and bug fixes.
6. QA tests the release; any critical fixes are applied directly to release/2.3.0.
7. After sign-off, release/2.3.0 merges into main.
8. Tag the release (v2.3.0) and trigger the deploy.
9. Merge back any changes from release/2.3.0 into main to maintain parity.
10. Delete feature and release branches once complete.

---

GitFlow Example:
feature/789-add-billing-api → PR → CI → Review → Merge → develop → release/2.2.0 → QA → Merge → main → Tag → Deploy → Merge Back → develop

Steps:
1. Developer branches from develop: feature/789-add-billing-api.
2. Commits changes locally, runs tests, and pushes updates.
3. Opens a Pull Request targeting develop.
4. CI validates and reviewer approves the merge.
5. Once multiple features are integrated, a release branch (release/2.2.0) is created from develop.
6. QA performs testing and bug fixes occur on release/2.2.0.
7. After QA sign-off, release/2.2.0 merges into main.
8. Tag the merge commit (v2.2.0) and deploy to production.
9. Merge release/2.2.0 back into develop to sync fixes.
10. Delete feature and release branches after deployment.

---

Library Flow Example:
feature/987-new-api-method → PR → Review → Merge → main → Tag (v1.2.3) → npm publish → Notify

Steps:
1. Developer branches from main: feature/987-new-api-method.
2. Implements and tests the new API addition or SDK enhancement.
3. Opens a Pull Request for review; CI validates build and type integrity.
4. Reviewer approves, merge occurs into main.
5. A semantic tag (v1.2.3) is created on the merge commit.
6. CI pipeline publishes the package to npm (or internal registry).
7. Team receives release notification with changelog summary.
8. The new package version is automatically consumable by downstream projects.

---

Branch Lifespan Guidelines

• Feature branches: 1–3 days
• Fix branches: 1–3 days
• Hotfix branches: same day
• Release branches: 3–7 days (until deploy)
• Chore / Docs branches: 1–2 days
• Experiment / Spike branches: short-term, deleted after review

---

Governance

• Branch strategy must be defined at project setup and documented in the Project Setup Contract ADR.
• Any change to branching model requires team consensus and ADR revision.
• Review cadence: Quarterly or post-release retrospective.
• Branch naming and protection rules enforced via CI or GitHub policies.