return {
	-- Toggle comments plugin
 	{
		'numToStr/Comment.nvim',
		config = function()
			require('Comment').setup()
		end,
		lazy = false,
	} 
}
