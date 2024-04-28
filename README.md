Workspace configuration files.

# Setup

Configuration files are expected to be found in your config directory, which is typically
`~/.config` for Linux, BSD, or macOS, and `~/AppData/Local` for Windows. Therefore,
you can clone this repository directly in such folder, e.g.

```sh
git clone https://github.com/dteif/dotconfig ~/.config
```

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

Requires:

__ripgrep__ [🔗](#ripgrep) Required by [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)
plugin for its `live_grep` and `grep_string` functionalities.

## Ripgrep

[Ripgrep](https://github.com/BurntSushi/ripgrep) is a line-oriented search tool that
recursively searches the current directory for a regex pattern.

You can install it with:

```sh
# Homebrew (MacOS / Linux)
brew install ripgrep
```
