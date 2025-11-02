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

## Git
via pacman

`~/.gitconfig` - symlink to the repo dotfiles
`~/.gitconfig_local` - imported from the base config for local overrides

This is configured to sign commits with the ssh key which may not work on older versions of git or may not be supported by your host if you're using something other than github. To use GPG, override `gpg.format` and `user.signingkey` in `.gitconfig_local`

Can verify proper git configuration by doing `git config --list --show-origin`.

[Setup SSH Key](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)
[Setup GPG Key](https://docs.github.com/en/authentication/managing-commit-signature-verification/generating-a-new-gpg-key)

## Kitty
<https://sw.kovidgoyal.net/kitty/>  
_Installed via `pacman`_

Theme gets installed by the `setup.sh`.

## Neovim  
<https://neovim.io/>  
_Installed via `pacman`_

---

### LazyVim  
<https://www.lazyvim.org/>

#### Dependencies (install via `pacman`):

- `nodejs`, `npm` — for language servers and plugins
- `fzf`, `ripgrep`, `fd` — for fuzzy finding and searching
- `wl-clipboard` — Wayland clipboard support (yank/paste)
- `gitui` — for the LazyVim "gitui" extra

LazyVim is installed by the `setup.sh`. It clones the LazyVim git repo to `~/config/nvim` and removes the `.git` directory.

---

### DevPod
<https://devpod.sh/>

- Installed using their `curl` command.
- Once we get Nix working, DevPod is a prime candidate for packaging: [Nix Packages Search](https://search.nixos.org/packages?channel=25.05&query=devpod).

**To configure DevPod to use local Docker for container management:**
```sh
devpod provider add docker
```

**To start and connect to a DevPod project:**
```sh
devpod up . --dotfiles https://github.com/shayne-saw/dotfiles -ide none
devbox ssh .
```

> Note: This setup ensures `ssh-agent` is used to forward keys into the DevPod container if an agent is running on the host.
