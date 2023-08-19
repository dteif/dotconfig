return {
	-- the main colorscheme should be available when starting Neovim
	{
		'marko-cerovac/material.nvim',
		lazy = false, -- make sure we load this during startup since it is the main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			-- load the colorscheme here
			vim.cmd.colorscheme("material")
		end,
	},
}
