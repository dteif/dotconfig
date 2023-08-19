return {
	{
		'sudormrfbin/cheatsheet.nvim',
		requires = {
			{'nvim-telescope/telescope.nvim'},
			{'nvim-lua/popup.nvim'},
			{'nvim-lua/plenary.nvim'},
		},
		lazy = true,
		cmd = {"Cheatsheet", "CheatsheetEdit"}
	}
}
