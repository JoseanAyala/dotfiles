#!/bin/sh
# Runs once per machine: triggers vim.pack to clone any missing plugins
# declared in ~/.config/nvim. Idempotent — already-cloned plugins are skipped.

set -eu

if ! command -v nvim >/dev/null 2>&1; then
  echo "nvim not found, skipping plugin sync."
  exit 0
fi

echo "Syncing nvim plugins via vim.pack..."
nvim --headless '+qa' >/dev/null 2>&1 || true
echo "Done."
