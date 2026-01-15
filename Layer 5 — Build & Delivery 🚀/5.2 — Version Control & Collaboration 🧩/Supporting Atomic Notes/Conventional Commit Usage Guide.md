Conventional Commit Usage Guide
Last Updated: 10/28/25

Purpose:
This guide explains how to use Conventional Commits after setup with Husky, Commitlint, and standard-version.
Follow these steps to make sure your commits and releases are clean, predictable, and automated.

------------------------------------------------------------
1. Writing Commits

Every commit message must follow this format:
<type>(optional scope): <short, clear description>

Examples:
feat(ui): add dark mode toggle
fix(auth): refresh token issue
chore(ci): add commitlint setup
refactor(api): simplify fetch logic
docs(readme): update instructions

Common types:
feat - new feature
fix - bug fix
docs - documentation only
style - code formatting only
refactor - code change not adding or fixing a feature
perf - performance improvement
test - add or update tests
chore - build or tooling changes
ci - continuous integration or deployment

If your message doesn’t follow this format, Husky will block the commit.

------------------------------------------------------------
2. From Branch to Commit (Real Example)

Step 1: Create a new branch based on what you’re doing.
Examples:
feature/add-user-settings
fix/login-error
chore/update-dependencies

Step 2: Make your code changes.

Step 3: Stage your changes.
git add .

Step 4: Write a Conventional Commit message that matches your branch name.
Examples:
git commit -m "feat(settings): add user preferences screen"
git commit -m "fix(auth): resolve login redirect issue"
git commit -m "chore(deps): update axios and react-query"

Step 5: Push your branch to the remote repository.
git push -u origin feature/add-user-settings

If your commit fails, you’ll see an error like:
⛔
subject may not be empty [subject-empty]
⛔
type may not be empty [type-empty]
Just fix your message and try again.

------------------------------------------------------------
3. Verifying Hooks

To check that Husky and Commitlint are working:
ls .husky
# you should see commit-msg and maybe pre-commit

cat .husky/commit-msg
# should include npx --no-install commitlint --edit

You can test existing commits:
npx commitlint --from HEAD~5 --to HEAD
(This checks your last 5 commits.)

------------------------------------------------------------
4. Generating Releases and Changelog

When you’re ready to tag a release:
pnpm release

What this does:
- Reads all Conventional Commits since the last tag.
- Bumps the version number automatically (major/minor/patch).
- Updates CHANGELOG.md.
- Commits the changelog and tags the version.

Then push your changes:
git push --follow-tags origin main

------------------------------------------------------------
5. How the Tools Work Together

Commitlint: checks commit message format.
Husky: runs Commitlint automatically before every commit.
lint-staged (optional): runs lint, type-check, or tests before commit.
standard-version: reads your commits to update changelog and version numbers.

This system makes sure:
- All commit messages follow the same pattern.
- Changelogs are auto-generated.
- Versions update automatically.
- History stays clean and easy to understand.

------------------------------------------------------------
6. Daily Workflow

# Example full workflow
git checkout -b feature/add-notifications
# make changes
git add .
git commit -m "feat(notifications): add toast system for user alerts"
git push -u origin feature/add-notifications

# merge once reviewed
git checkout main
git pull
git merge feature/add-notifications
git push

# when ready to release
pnpm release
git push --follow-tags origin main

------------------------------------------------------------
7. CI/CD Enforcement (Optional)

To check commits during pull requests:
npx commitlint --from origin/main --to HEAD

This helps catch bad commit messages before merging.

------------------------------------------------------------
Summary:
Create a descriptive branch → write a matching Conventional Commit message → Husky validates it → standard-version updates changelog and version tags automatically.
You write clean code, and the system keeps your repo consistent.