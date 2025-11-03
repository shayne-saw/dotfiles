#!/bin/bash
set -eu

FULL_INSTALL=false

# Parse arguments
for arg in "$@"; do
  case "$arg" in
  --full)
    FULL_INSTALL=true
    ;;
  esac
done

if $FULL_INSTALL; then
  echo "[INFO] Running full machine setup"
else
  echo "[INFO] Running headless/container setup"
  echo "[INSTALLING] neovim and dependencies"
  brew install neovim fzf ripgrep fd gitui fastfetch
fi

# Determine the absolute path to the directory containing this script.
# This uses 'cd' and 'pwd' in a subshell to resolve both relative and absolute script paths.
# The directory change does not affect the caller's shell session.
DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

# Check for required commands
for cmd in git curl; do
  if ! command -v "$cmd" >/dev/null 2>&1; then
    echo "[ERROR] $cmd is not installed."
    exit 1
  fi
done

if [ ! -f "$HOME/.config/kitty/themes/tokyo-night-kitty.conf" ]; then
  mkdir -p ~/.config/kitty/themes
  curl -sS -o ~/.config/kitty/themes/tokyo-night-kitty.conf \
    https://raw.githubusercontent.com/davidmathers/tokyo-night-kitty-theme/trunk/tokyo-night-kitty.conf
  echo "[DOWNLOADING] kitty theme -> .config/kitty/themes/tokyo-night-kitty.conf"
fi

if [ ! -f "$HOME/.config/nvim/init.lua" ]; then
  echo "[DOWNLOADING] lazy vim -> .config/nvim"

  git clone https://github.com/LazyVim/starter "$HOME/.config/nvim"
  rm -rf "$HOME/.config/nvim/.git"
  rm -rf "$HOME/.config/nvim/init.lua"
  rm -rf "$HOME/.config/nvim/lua/plugins"
fi

if [ ! -f "$HOME/.gitconfig_local" ]; then
  cp "$DOTFILES_DIR/gitconfig_local.template" "$HOME/.gitconfig_local"
  echo "[STUBBING] .gitconfig_local  Edit this file for local overrides."
fi

FILES=(.gitconfig .bashrc .bash_profile .config/kitty/kitty.conf .config/nvim/init.lua .config/nvim/lua/plugins .config/nix/nix.conf)

for file in "${FILES[@]}"; do
  if [ -f "$HOME/$file" ] && [ ! -L "$HOME/$file" ]; then
    mv "$HOME/$file" "$HOME/${file}.backup"
    echo "[COPYING] $file -> ${file}.backup"
  fi
done

for file in "${FILES[@]}"; do
  mkdir -p "$(dirname "$HOME/$file")"
  ln -sf "$DOTFILES_DIR/$file" "$HOME/$file"
  echo "[LINKING] $file -> $DOTFILES_DIR/$file"
done
