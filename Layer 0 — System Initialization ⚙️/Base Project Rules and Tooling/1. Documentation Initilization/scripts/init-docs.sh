#!/usr/bin/env bash
set -euo pipefail

# -------------------------
# Create docs directories
# -------------------------
mkdir -p docs/{_project,adr,blueprint,process,references}
mkdir -p docs/blueprint/layers/{00-system-initialization,01-language-architecture,02-state-framework,03-quality-stability,04-ui-experience,05-build-delivery,06-security-observability}

# -------------------------
# README stubs (framing only)
# -------------------------
cat > docs/README.md <<'EOF'
# Documentation

/docs is the documentation root for this project.

Folders:
- /docs/_project — project-wide truth (overview, stack, ownership, review cadence)
- /docs/adr — architecture decision records (immutable decisions)
- /docs/blueprint — layer guides, standards, examples
- /docs/process — workflows + templates used to run the project
- /docs/references — diagrams and external notes
EOF

cat > docs/_project/README.md <<'EOF'
# _project

Project-wide truth and overview.

This folder answers:
- What is this system?
- What is the current stack and why?
- Who owns the foundations and how often do we review them?
EOF

cat > docs/adr/README.md <<'EOF'
# ADRs

Architecture Decision Records (ADRs) are immutable once accepted.

Rules:
- Accepted ADRs do not change
- If a decision changes, write a new ADR that supersedes the old one
- ADRs should link to related docs in /docs/_project and /docs/blueprint
EOF

cat > docs/blueprint/README.md <<'EOF'
# Blueprint

Layer-by-layer engineering standards and examples.

This folder contains:
- Layer guides (00–06) in maturity order
- Example-driven conventions
- Checklists that prevent drift as the system grows
EOF

cat > docs/process/README.md <<'EOF'
# Process

Repeatable engineering workflows and templates.

This folder contains:
- Templates (created in later steps)
- Operating procedures for maintaining the repo
EOF

cat > docs/references/README.md <<'EOF'
# References

Supporting material (diagrams, external notes, links).

Rules:
- Link to sources when possible
- Don’t duplicate canonical documentation here
EOF

# Per-layer READMEs
for dir in docs/blueprint/layers/*; do
  layer="$(basename "$dir")"
  cat > "$dir/README.md" <<EOF
# ${layer}

Layer guide directory.

This folder contains:
- Standards
- Examples
- Checklists
- “How to implement” docs for this layer
EOF
done

echo "✅ Docs structure + README framing created."
