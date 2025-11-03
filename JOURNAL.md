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
devpod up . --dotfiles https://github.com/shayne-saw/dotfiles --ide none
devbox ssh .
```

> Note: This setup ensures `ssh-agent` is used to forward keys into the DevPod container if an agent is running on the host.

Once you are inside the dev container run:
```bash
brew install neovim fzf ripgrep fd gitui fastfetch
```

You also have `asdf` available to install any language dependencies you need for that given project. To make language servers a little easier to run you can make those versions globally available.

TODO: Currently DevPod is making adjustments to the `.gitconfig` file rather than our `.gitconfig_local` inside the container. Likely not an issue because we probably won't be doing a lot of work on the dotfiles while inside a devcontainer.

### Lemonade (Clipboard)

To meet the challenge of enabling clipboard support from the neovim application inside the devcontainer. [Lemonade](https://github.com/lemonade-command/lemonade) is a clipboard provider that neovim calls and it sends the content to the host machine where a lemonade server is running and interacts with the host clipboard.

Installed on the docker container directly via go for now.

```bash
sudo apt install golang-go
go install github.com/lemonade-command/lemonade@latest
export PATH=$PATH:$(go env GOPATH)/bin
```

To run on the host machine I like using nix.

```bash
nix run nixpkgs#lemonade server
```

Nix will download what it needs the first time and binaries will be cached in the nix store so subsequent starts will be fast.

Need to configure neovim because by default lemonade will try to connect to a server at localhost.

```
:h provider-clipboard describes configuration shown below
```
```
```

Need to add the following to init.lua in the devcontainer neovim config. I haven't added it to this dotfiles project yet because I'm still figuring out how I want to make it conditional based on environment.

```lua
vim.g.clipboard = {
	name = "lemonade",
	copy = {
		["+"] = "lemonade copy -host=host.docker.internal",
		["*"] = "lemonade copy -host=host.docker.internal",
	},
	paste = {
		["+"] = "lemonade paste -host=host.docker.internal",
		["*"] = "lemonade paste -host=host.docker.internal",
	},
	cache_enabled = 0,
}
```
