alias nixd 'nix develop -c fish'

# Suppress Fish greeting in Nix shells
if test -n "$IN_NIX_SHELL"
    set -g fish_greeting
end

if status is-interactive
    # Commands to run in interactive sessions can go here
    starship init fish | source
    direnv hook fish | source
end
