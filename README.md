This repository contains configuration files and scripts to customize my version of neovim.

# Requirements

Some external tools need to be installed for everything to work properly.

- `ripgrep`, required by telescope.nvim plugin for `live_grep` and `grep_string` functionalities.

# Setup

NeoVim configuration is loaded by means of Lua scripts, whose main is the file `init.lua` in repository root. 
This file should be placed in your config directory, which is typically `~/.config/nvim` for Linux, BSD, or macOS, 
and `~/AppData/Local/nvim/` for Windows. Therefore, you can clone this repository directly in such folder.

If not found, plugins manager `packer.nvim` is going to be automatically installed in the proper directory.
See `plugins/bootstrap.lua` file for more details.
