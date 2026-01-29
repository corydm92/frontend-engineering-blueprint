#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
INIT_SCRIPT="${SCRIPT_DIR}/init-docs.sh"

if [[ ! -f "$INIT_SCRIPT" ]]; then
  echo "Missing init-docs.sh at: $INIT_SCRIPT" >&2
  exit 1
fi

tmp_dir="$(mktemp -d)"
cleanup() { rm -rf "$tmp_dir"; }
trap cleanup EXIT

cp "$INIT_SCRIPT" "$tmp_dir/init-docs.sh"
chmod +x "$tmp_dir/init-docs.sh"

run_init() {
  if command -v script >/dev/null 2>&1; then
    TERM=xterm script -q /dev/null bash -c "cd \"$tmp_dir\" && printf '\n' | \"$tmp_dir/init-docs.sh\""
  else
    (cd "$tmp_dir" && TERM=xterm "$tmp_dir/init-docs.sh" <<< $'\n')
  fi
}

assert_path() {
  local path="$1"
  if [[ ! -e "$path" ]]; then
    echo "Missing: $path" >&2
    exit 1
  fi
}

assert_file() {
  local path="$1"
  if [[ ! -f "$path" ]]; then
    echo "Missing file: $path" >&2
    exit 1
  fi
}

run_init

assert_path "$tmp_dir/docs"
assert_file "$tmp_dir/docs/README.md"
assert_file "$tmp_dir/docs/__project/README.md"
assert_file "$tmp_dir/docs/adr/README.md"
assert_file "$tmp_dir/docs/blueprint/README.md"
assert_file "$tmp_dir/docs/process/README.md"
assert_file "$tmp_dir/docs/references/README.md"

LAYER_DIRS=(
  "Layer 00 - System Initialization"
  "Layer 01 - Language & Architecture"
  "Layer 02 - State & Framework"
  "Layer 03 - Quality & Stability"
  "Layer 04 - UI & Experience"
  "Layer 05 - Build & Delivery"
  "Layer 06 - Security & Observability"
)

for layer in "${LAYER_DIRS[@]}"; do
  layer_dir="$tmp_dir/docs/blueprint/$layer"
  assert_path "$layer_dir"
  assert_file "$layer_dir/README.md"

  if [[ "$layer" =~ ([0-9]{2}) ]]; then
    layer_num="$((10#${BASH_REMATCH[1]}))"
  else
    echo "Could not parse layer number from: $layer" >&2
    exit 1
  fi

  section_dir="$layer_dir/${layer_num}.0 Section Example"
  assert_path "$section_dir"
  assert_file "$section_dir/README.md"

  assert_path "$section_dir/Base Project Rules and Tooling"
  assert_file "$section_dir/Base Project Rules and Tooling/README.md"
  assert_path "$section_dir/Base Project Rules and Tooling/__Initialization"
  assert_file "$section_dir/Base Project Rules and Tooling/__Initialization/README.md"

  assert_path "$section_dir/Core Sequential Subsections"
  assert_file "$section_dir/Core Sequential Subsections/README.md"

  assert_path "$section_dir/Supporting Atomic Notes"
  assert_file "$section_dir/Supporting Atomic Notes/README.md"
done

echo "OK: init-docs.sh creates the expected docs structure."
