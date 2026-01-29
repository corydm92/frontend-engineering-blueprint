# CI/CD System Boundary

CI is the **quality gate**:
- Runs on pull_request (and main if needed)
- Validates formatting, lint, types, and tests
- Produces the artifact that will be promoted

CD is the **promotion engine**:
- Moves the same artifact from dev → staging → prod
- Uses Gitflow triggers (develop, release/*, v* tags)
- Never rebuilds after the dev artifact is created

Rule: if a step changes the artifact, it belongs in CI, not CD.
