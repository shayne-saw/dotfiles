#!/bin/bash

# Determine the absolute path to the directory containing this script.
# This uses 'cd' and 'pwd' in a subshell to resolve both relative and absolute script paths.
# The directory change does not affect the caller's shell session.
DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

ln -sf "$DOTFILES_DIR/gitconfig" "$HOME/.gitconfig"
echo "[LINKING ] ~/.gitconfig -> dotfiles/gitconfig"

if [ ! -f "$HOME/.gitconfig_local" ]; then
  cp "$DOTFILES_DIR/gitconfig_local.template" "$HOME/.gitconfig_local"
  echo "[STUBBING] ~/.gitconfig_local  Edit this file for local overrides."
else
  echo "[IGNORING] ~/.gitconfig_local"
fi
