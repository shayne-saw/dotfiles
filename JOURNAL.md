## Base System
https://archlinux.org/
https://wiki.archlinux.org/title/Main_page
- Arch
- KDE Plasma

Use `archinstall` interface for installation

## Bash

`~/.bashrc` - is executed for **non-login interactive shells** (like when you open a new terminal window or tab).
`~/.bash_profile` - is executed for **login shells** (like when you log in via SSH or at a text console).

The `setup.sh` script copies existing files with `.backup` suffix and replaces them with symlinks to the dotfiles repo.

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

