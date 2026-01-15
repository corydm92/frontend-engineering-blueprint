Branch Naming Conventions

Purpose:
Establish clear, predictable, and searchable branch names that communicate intent, purpose, and ownership.
Branch names should follow a consistent structure across all teams and repositories to improve traceability and automation.

---

General Format:
<type>/<scope>-<short-description>

Example:
feature/auth-login-flow
fix/dashboard-loading-state
chore/update-eslint-config
release/2.1.0
hotfix/production-env-vars

---

Primary Branch Types:

1. Mainline Branches
main
develop (only if using GitFlow)

Description:
• main — always stable, deployable branch
• develop — optional integration branch (only in GitFlow or hybrid models)

---

2. Feature Branches
feature/<ticket-id>-<short-description>

Examples:
feature/123-add-user-profile
feature/456-integrate-analytics-sdk
feature/design-token-refactor

Usage:
• Used for new features, enhancements, or experiments
• Always branch from main (trunk-based) or develop (GitFlow)
• Keep lifespan short (1–3 days maximum)
• Merge via pull request after passing CI

---

3. Bugfix Branches
fix/<ticket-id>-<short-description>

Examples:
fix/789-resolve-login-timeout
fix/912-fix-header-overlap
fix/analytics-event-naming

Usage:
• For addressing known defects or regressions
• Should always include related issue ID
• Merge into main or release branch after testing

---

4. Hotfix Branches
hotfix/<short-description>

Examples:
hotfix/rollback-api-endpoint
hotfix/security-header-missing

Usage:
• Emergency production patches
• Branched from main only
• Merged back into both main and develop/release branches
• Requires tagging and post-release review

---

5. Release Branches
release/<version>

Examples:
release/2.0.0
release/2.1.1

Usage:
• Used for pre-production stabilization and final testing
• Bug fixes only; no new features
• After QA sign-off, merge into main and tag version
• Merge back into develop (if applicable)

---

6. Chore / Maintenance Branches
chore/<short-description>

Examples:
chore/update-dependencies
chore/improve-lint-rules
chore/ci-pipeline-refactor

Usage:
• For non-functional tasks — refactors, dependency updates, or CI improvements
• Follow same PR and review standards as features

---

7. Documentation Branches
docs/<short-description>

Examples:
docs/add-adr-template
docs/improve-readme
docs/blueprint-v1.16-update

Usage:
• Used for documentation-only changes
• Can merge directly to main if no code changes are involved

---

8. Experiment / Spike Branches
spike/<short-description>
experiment/<short-description>

Examples:
spike/react-compiler-evaluation
experiment/turbopack-integration

Usage:
• Temporary research or proof-of-concept work
• Never directly merged into main; create follow-up feature branch for implementation
• Delete after conclusion

---

9. Test / Sandbox Branches
test/<short-description>
sandbox/<short-description>

Examples:
test/deployment-workflow
sandbox/ui-theme-experiment

Usage:
• Used for internal testing or validation only
• Not merged into production branches
• Deleted after validation

---

10. Environment Branches (Optional)
env/<environment-name>

Examples:
env/staging
env/qa
env/demo

Usage:
• Used in multi-environment CI/CD pipelines for deployment testing
• Not for development work
• Typically managed by automation, not manually edited

---

Branch Naming Rules:
1. Always use lowercase letters.
2. Separate words with hyphens (-).
3. Avoid special characters, spaces, or underscores.
4. Keep descriptions short (3–6 words maximum).
5. Always include issue or ticket ID for traceability.
6. Delete merged branches to reduce clutter.
7. Branch names must align with commit prefixes (feat:, fix:, chore:, docs:, etc.).

---

Example Branch Naming Matrix:

Type | Example | Merge Target
--------------------------------------------------------------
feature | feature/123-user-auth-flow | main or develop
fix | fix/456-loading-spinner | main or release
hotfix | hotfix/env-variable-patch | main
release | release/2.2.0 | main + develop
chore | chore/update-ci-config | main or develop
docs | docs/update-adr-guidelines | main
spike | spike/react-compiler-investigation | none (archived)
experiment | experiment/turbopack-build-tests | none (archived)
env | env/staging | none (managed by CI)
test | test/performance-pipeline | none (temporary)

---

Recommended Branch Lifespan:
• Feature / Fix branches: 1–3 days
• Release branches: 3–7 days (until deploy)
• Hotfix branches: same day resolution
• Chore / Docs: merge within 1 day
• Experiments / Spikes: delete after completion

---

Best Practices:
• Enforce branch naming via CI pre-push hooks or GitHub branch rules (branch naming policy GitHub).
• Automate tagging and versioning through release branches (semantic versioning release automation).
• Link branches to issues or tickets automatically using repository integrations (issue tracking GitHub).