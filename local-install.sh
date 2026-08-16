#!/usr/bin/env bash
#
# Install local skills into the user's skills directories by creating symlinks.
# Each first-level subdirectory under [proj]/skills is symlinked into:
#   ~/.agents/skills/
#   ~/.claude/skills/
#
# Run from Git Bash:  ./local-install.sh

set -euo pipefail

# Resolve the project root as the directory containing this script.
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILLS_SRC="$SCRIPT_DIR/skills"

DEST_DIRS=(
  "$HOME/.agents/skills"
  "$HOME/.claude/skills"
)

if [[ ! -d "$SKILLS_SRC" ]]; then
  echo "Skills source directory not found: $SKILLS_SRC" >&2
  exit 1
fi

for dest in "${DEST_DIRS[@]}"; do
  mkdir -p "$dest"
done

# Iterate over first-level subdirectories of the skills source directory.
for skill in "$SKILLS_SRC"/*/; do
  [[ -d "$skill" ]] || continue
  name="$(basename "$skill")"

  for dest in "${DEST_DIRS[@]}"; do
    target="$dest/$name"

    if [[ -e "$target" || -L "$target" ]]; then
      rm -rf "$target"
    fi

    MSYS=winsymlinks:nativestrict ln -s "$skill" "$target"
    echo "Linked $name -> $target"
  done
done
