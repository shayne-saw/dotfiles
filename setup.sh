#!/bin/bash

# Determine the absolute path to the directory containing this script.
# This uses 'cd' and 'pwd' in a subshell to resolve both relative and absolute script paths.
# The directory change does not affect the caller's shell session.
DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

if [ ! -f "$HOME/.gitconfig_local" ]; then
  cp "$DOTFILES_DIR/gitconfig_local.template" "$HOME/.gitconfig_local"
  echo "[STUBBING] .gitconfig_local  Edit this file for local overrides."
else
  echo "[IGNORING] .gitconfig_local"
fi

FILES=(.gitconfig .bashrc .bash_profile)

for file in "${FILES[@]}"; do
  if [ -f "$HOME/$file" ] && [ ! -L "$HOME/$file" ]; then
    mv "$HOME/$file" "$HOME/${file}.backup"
    echo "[COPYING] $file -> ${file}.backup"
  fi
done

for file in "${FILES[@]}"; do
  ln -sf "$DOTFILES_DIR/$file" "$HOME/$file"
  echo "[LINKING] $file -> $DOTFILES_DIR/$file"
done
