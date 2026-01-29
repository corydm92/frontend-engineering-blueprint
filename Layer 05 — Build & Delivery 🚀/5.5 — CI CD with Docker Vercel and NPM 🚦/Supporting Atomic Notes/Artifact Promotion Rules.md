# Artifact Promotion Rules

## Good
- Build once in dev, promote the same artifact to staging and prod
- Stamp artifacts with a short SHA or tag for traceability
- Keep build steps in CI, not in CD

## Bad
- Rebuilding in staging or prod
- Deploying from unreviewed branches
- Promoting artifacts that skipped CI
