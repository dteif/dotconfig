Workspace configuration files.

# Setup

Configuration files are expected to be mostly found in the user config directory,
which is typically `~/.config` for Linux, BSD, or macOS, and `~/AppData/Local` for
Windows. This repository, however, makes use of [Ansible](https://github.com/ansible/ansible)
and some custom tools to install, update and manage configurations, which will eventually
be symlinked to the expected directories according the application and the host platform.

## Run setup

```sh
ansible-playbook -i .ansible/inventory.yaml setup.yaml
```

## Manual installation

### Clone the repository

This repository can be cloned anywhere, for instance you can clone it with:

```sh
git clone https://github.com/dteif/dotconfig ~/dotconfig
```

Some tools are included within this repository by means of git 
[submodules](https://git-scm.com/book/en/v2/Git-Tools-Submodules). These have to be
explicitly downloaded after a new clone or a pull of an update that upgraded the version
of a submodule. Most of the times, it is enough to call (after `clone` or `pull`):

```sh
git submodule update --init
```

### Install Ansible

In order to make use of the automated management of the configuration files, Ansible needs
to be installed on the machine. This could be done, for instance, with:

```sh
# Homebrew (MacOS)
brew install pipx
pipx ensurepath
pipx install --include-deps ansible
```








# Setup applications

Additionally, some external tools need to be installed for everything to work properly.
The following is a list of programs which are configured by files in this repository
or are required by another one. Notice, however, that not all the programs listed here
have to be installed necessarily, since some of them may still operate independently.
Mandatory requirements will be made explicit.

## Neovim
 
[Neovim](https://github.com/neovim/neovim) is a modernized, highly customizable text
editor inspired by Vim. It aims to improve upon Vim's functionality and extend it
with additional features while maintaining compatibility with Vim scripts and configurations.

You can install it with:

```sh
# Homebrew (MacOS / Linux)
brew install neovim
```

The following tools are required:

__ripgrep__ [🔗](#ripgrep) Required by [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)
plugin for its `live_grep` and `grep_string` functionalities.

In order to have a proper visualization of all the displayed elements, it is necessary
to run Neovim inside a terminal emulator that supports both 'true colors' and 'nerd fonts'. 
This can be one of the following:

__wezterm__ [🔗](#wezterm) (_optional_)

## Ripgrep

[Ripgrep](https://github.com/BurntSushi/ripgrep) is a line-oriented search tool that
recursively searches the current directory for a regex pattern.

You can install it with:

```sh
# Homebrew (MacOS / Linux)
brew install ripgrep
```

## Tmux

[Tmux](https://github.com/tmux/tmux) is a terminal multiplexer: it enables a number
of terminals to be created, accessed, and controlled from a single screen. tmux may
be detached from a screen and continue running in the background, then later reattached.

You can install it with:

```sh
# Homebrew (MacOS)
brew install tmux
```

### Tmux Plugin Manager

Tmux plugins are installed by means of [Tmux Plugin Manager](https://github.com/tmux-plugins/tpm)
(_TPM_), which is downloaded as a git submodule. However, plugins are not installed
automatically, but they need to be manually fetched by starting `tmux` and pressing
`prefix` + `I` (nb: tmux `prefix` has been remapped to `C-s`). 

## Tmuxinator

[Tmuxinator](https://github.com/tmuxinator/tmuxinator) is used to create and manage
tmux sessions easily.

You can install it with: 

```sh
# Homebrew (MacOS)
brew install tmuxinator
```

## Wezterm

[Wezterm](https://github.com/wez/wezterm) is a GPU-accelerated cross-platform terminal
emulator and multiplexer written by [wez](https://github.com/wez) and implemented in Rust

You can install it with:

```sh
# Homebrew (MacOS)
brew install --cask wezterm
```
