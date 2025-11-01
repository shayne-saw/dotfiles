#
# ~/.bash_profile
#
export PATH="$HOME/.local/bin:$HOME/.nix-profile/bin:$PATH"
export EDITOR="nvim"
export npm_config_prefix="$HOME/.local"

# Source .bashrc for interactive shell settings
if [ -f "$HOME/.bashrc" ]; then
  . "$HOME/.bashrc"
fi

# Start ssh-agent if not already running (optional)
if [ -z "$SSH_AUTH_SOCK" ]; then
  eval "$(ssh-agent -s)"
fi
