#!/usr/bin/env bash
# bootstrap.sh — install dev-conventions symlinks into a project.
#
# Usage:
#   ./dev-conventions/bootstrap.sh <project-dir>
#
# Idempotent: re-running is safe; existing correct symlinks are left alone.

set -euo pipefail

if [[ $# -ne 1 ]]; then
  echo "usage: $0 <project-dir>" >&2
  exit 2
fi

# Resolve absolute paths.
project_dir=$(cd "$1" && pwd)
conventions_dir=$(cd "$(dirname "$0")" && pwd)

# Sanity: dev-conventions and project must be siblings (same parent).
if [[ "$(dirname "$project_dir")" != "$(dirname "$conventions_dir")" ]]; then
  echo "warning: $project_dir and $conventions_dir are not siblings." >&2
  echo "         Symlinks will still work but the relative target assumes siblings." >&2
fi

# (link_name, target_within_dev_conventions)
links=(
  ".cursor/rules:cursor/rules"
  ".cursor/skills:cursor/skills"
  "docs/conventions:docs/conventions"
)

for entry in "${links[@]}"; do
  link_rel="${entry%%:*}"
  target_sub="${entry##*:}"
  link_path="$project_dir/$link_rel"
  target_rel="../../dev-conventions/$target_sub"

  mkdir -p "$(dirname "$link_path")"

  if [[ -L "$link_path" ]]; then
    current=$(readlink "$link_path")
    if [[ "$current" == "$target_rel" ]]; then
      echo "  ok   $link_rel -> $target_rel"
      continue
    fi
    echo "  fix  $link_rel (was: $current)"
    rm "$link_path"
  elif [[ -e "$link_path" ]]; then
    echo "error: $link_path exists and is not a symlink." >&2
    echo "       Move or remove it first." >&2
    exit 1
  fi

  ln -s "$target_rel" "$link_path"
  echo "  link $link_rel -> $target_rel"
done

echo
echo "Done. Add these to $project_dir/.gitignore if not already present:"
echo "  /.cursor/rules"
echo "  /.cursor/skills"
echo "  /docs/conventions"
