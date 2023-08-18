-- This file should contain the list of plugins to use. This file
-- is watched for changes and will issue a packer recompile when it
-- is changed.
--
-- Additionally, this script will download and install packer in the
-- proper directory, if not found.

-- Install packer if not found
local packer_bootstrap = require("plugins.bootstrap").ensure_packer()

-- Plugins to use
return require('packer').startup(function(use)
	-- Plugin Manager
	-- Packer can manage itself
	use 'wbthomason/packer.nvim'

	-- Bars and Lines
	use {
		'nvim-lualine/lualine.nvim',
		requires = { 'nvim-tree/nvim-web-devicons' }
	}

	-- Colorscheme
	use {
		'marko-cerovac/material.nvim',
	}

	-- Editing Support
	use {
		'numToStr/Comment.nvim',
		config = function()
			require('Comment').setup()
		end
	}
	
	-- Fuzzy Finder
	use {
		'nvim-telescope/telescope.nvim', 
		tag = '0.1.2',
		-- or
		-- branch = '0.1.x',
		requires = { {'nvim-lua/plenary.nvim', 'nvim-tree/nvim-web-devicons'} }
	}

	-- LSP + Completion
	-- use {
	-- 	'VonHeikemen/lsp-zero.nvim',
	-- 	branch = 'v2.x',
	-- 	requires = {
	-- 		-- LSP Support
	-- 		{'neovim/nvim-lspconfig'},             -- Required
	-- 		{'williamboman/mason.nvim'},           -- Optional
	-- 		{'williamboman/mason-lspconfig.nvim'}, -- Optional
	-- 		-- Autocompletion
	-- 		{'hrsh7th/nvim-cmp'},     -- Required
	-- 		{'hrsh7th/cmp-nvim-lsp'}, -- Required
	-- 		{'L3MON4D3/LuaSnip'},     -- Required
	-- 	}
	-- }

	-- Marks
	use {
		"ThePrimeagen/harpoon",
		requires = { {"nvim-lua/plenary.nvim"} }
	}

	-- Syntax
	use {
		'nvim-treesitter/nvim-treesitter',
		run = function()
			-- This ensures that all installed parsers are updated to the latest version via :TSUpdate
			local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
			ts_update()
		end,
	}
	use "nvim-treesitter/playground"

	-- Utility
	use {
		'sudormrfbin/cheatsheet.nvim',
		requires = {
			{'nvim-telescope/telescope.nvim'},
			{'nvim-lua/popup.nvim'},
			{'nvim-lua/plenary.nvim'},
		}
	}

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if packer_bootstrap then
		require('packer').sync()
	end
end)
