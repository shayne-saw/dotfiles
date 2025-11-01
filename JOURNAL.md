## Base System
https://archlinux.org/
https://wiki.archlinux.org/title/Main_page
- Arch
- KDE Plasma

Use `archinstall` interface for installation

## Kitty
https://sw.kovidgoyal.net/kitty/
via pacman

## Git
via pacman

`~/.gitconfig` - symlink to the repo dotfiles
`~/.gitconfig_local` - imported from the base config for local overrides

This is configured to sign commits with the ssh key which may not work on older versions of git or may not be supported by your host if you're using something other than github. To use GPG, override `gpg.format` and `user.signingkey` in `.gitconfig_local`

Can verify proper git configuration by doing `git config --list --show-origin`.

[Setup SSH Key](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)
[Setup GPG Key](https://docs.github.com/en/authentication/managing-commit-signature-verification/generating-a-new-gpg-key)
