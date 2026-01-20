#!/usr/bin/env bash
set -euo pipefail

# ------------------------------------------------------------------------------
# Interactive mode selector (arrow keys + Enter)
# ------------------------------------------------------------------------------
# Options:
# 1) Organized Layer Structure:
#    /Base Project Rules and Tooling
#    /Core Sequential Subsections
#    /Supporting Atomic Notes
#
# 2) Open Layer Structure:
#    Layer folders only (open/configurable)
# ------------------------------------------------------------------------------

OPTIONS=(
  "Organized Layer Structure (Base Project Rules and Tooling / Core Sequential Subsections / Supporting Atomic Notes)"
  "Open Layer Structure (open and configurable)"
)

MODE=""  # "organized" | "open"
SELECTED=0

supports_tput() { command -v tput >/dev/null 2>&1; }
supports_tput || { echo "Error: 'tput' is required for arrow-key selection." >&2; exit 1; }

hide_cursor() { tput civis || true; }
show_cursor() { tput cnorm || true; }
cleanup() { show_cursor; }
trap cleanup EXIT

draw_menu() {
  # Move to a safe spot and clear from there down, avoiding top-line clipping
  tput cup 2 0   # row 2, col 0 (0-indexed); adjust to 1 or 3 if you prefer
  tput ed        # clear to end of screen

  echo "Docs init: choose a layer folder structure"
  echo "Use ↑/↓ and Enter"
  echo

  for i in "${!OPTIONS[@]}"; do
    if [[ "$i" -eq "$SELECTED" ]]; then
      printf "  > %s\n" "${OPTIONS[$i]}"
    else
      printf "    %s\n" "${OPTIONS[$i]}"
    fi
  done
}


read_key() {
  local key
  IFS= read -rsn1 key
  # Handle escape sequences for arrow keys: ESC [ A/B
  if [[ "$key" == $'\x1b' ]]; then
    IFS= read -rsn2 key
    echo "$key"
    return
  fi
  echo "$key"
}

hide_cursor
while true; do
  draw_menu
  key="$(read_key)"

  case "$key" in
    "[A") # Up
      ((SELECTED--))
      if (( SELECTED < 0 )); then SELECTED=$((${#OPTIONS[@]} - 1)); fi
      ;;
    "[B") # Down
      ((SELECTED++))
      if (( SELECTED >= ${#OPTIONS[@]} )); then SELECTED=0; fi
      ;;
    "") # Enter
      if (( SELECTED == 0 )); then MODE="organized"; else MODE="open"; fi
      break
      ;;
  esac
done

show_cursor
echo "Selected: ${OPTIONS[$SELECTED]}"
echo

# ------------------------------------------------------------------------------
# Create docs directories (always)
# ------------------------------------------------------------------------------
mkdir -p docs/{_project,adr,blueprint,process,references}
mkdir -p docs/blueprint/{00-system-initialization,01-language-architecture,02-state-framework,03-quality-stability,04-ui-experience,05-build-delivery,06-security-observability}

# ------------------------------------------------------------------------------
# README stubs (framing only)
# ------------------------------------------------------------------------------
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

# ------------------------------------------------------------------------------
# Layer README + optional organized sub-structure
# ------------------------------------------------------------------------------
for dir in docs/blueprint/*; do
  [[ -d "$dir" ]] || continue
  layer="$(basename "$dir")"


  if [[ "$MODE" == "organized" ]]; then
    # Create organized sub-structure (directories only + README framing only)
    mkdir -p \
      "$dir/Base Project Rules and Tooling" \
      "$dir/Core Sequential Subsections" \
      "$dir/Supporting Atomic Notes"

    cat > "$dir/README.md" <<EOF
# ${layer}

Layer guide directory.

Structure (organized):
- Base Project Rules and Tooling — standards and defaults that apply broadly in this layer
- Core Sequential Subsections — the recommended “do this in order” setup for the layer
- Supporting Atomic Notes — smaller, focused notes (single concepts, gotchas, examples)

This folder contains:
- Standards
- Examples
- Checklists
- “How to implement” docs for this layer
EOF

    cat > "$dir/Base Project Rules and Tooling/README.md" <<EOF
# Base Project Rules and Tooling

Broad standards and defaults for this layer.

Use this for:
- conventions
- tooling rules
- guardrails that keep projects consistent
EOF

    cat > "$dir/Core Sequential Subsections/README.md" <<EOF
# Core Sequential Subsections

The recommended step-by-step setup sequence for this layer.

Use this for:
- ordered checklists
- “do this first, then that” initialization
- verification steps
EOF

    cat > "$dir/Supporting Atomic Notes/README.md" <<EOF
# Supporting Atomic Notes

Small, focused notes for this layer.

Use this for:
- single-topic explanations
- examples
- gotchas and edge cases
EOF

  else
    # Open structure: only layer directory README framing
    cat > "$dir/README.md" <<EOF
# ${layer}

Layer guide directory.

This folder contains:
- Standards
- Examples
- Checklists
- “How to implement” docs for this layer

Structure: open and configurable (no required subfolders).
EOF
  fi
done

echo "✅ Docs structure + README framing created."
