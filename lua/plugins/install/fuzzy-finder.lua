return {
	{
		'nvim-telescope/telescope.nvim', 
		tag = '0.1.2',
		-- or
		-- branch = '0.1.x',
		dependencies = { 'nvim-lua/plenary.nvim' },
		config = function () 
			local builtin = require('telescope.builtin')
			vim.keymap.set('n', '<leader>pf', function() 
				builtin.find_files({hidden = true}) 
			end, {})
			vim.keymap.set('n', '<C-p>', builtin.git_files, {})
			vim.keymap.set('n', '<leader>ps', function()
				builtin.grep_string({search = vim.fn.input("grep > ")});
			end)
			-- vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
			-- vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
			-- vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
		end
	}
}
