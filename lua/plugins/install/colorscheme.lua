return {
	-- the main colorscheme should be available when starting Neovim
	{ 
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false, -- make sure we load this during startup since it is the main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			require("catppuccin").setup({
				integrations = {
					harpoon = true,
					neotree = true,
					treesitter = true,
					telescope = {
						enabled = true,
						-- style = "nvchad"
					},

				}
			})
			
			-- load the colorscheme here
			vim.cmd.colorscheme("catppuccin-frappe")
		end,

	},

	{
		'marko-cerovac/material.nvim',
		lazy = true,
	},
}
