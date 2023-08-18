local config_path = vim.fn.stdpath("config")

-- create a "packer_compile" autocommands group to group plugin management autocommands
local packer_augroup = vim.api.nvim_create_augroup("packer_compile", {})

-- this autocommand will recompile plugins when plugin configuration changes.
vim.api.nvim_create_autocmd({"BufWritePost"}, {
	group = packer_augroup,
	pattern = config_path .. "/lua/plugins/config.lua",
	callback = function()
		print("Plugins configuration change detected. Recompiling...")
		vim.cmd.source()
		vim.cmd.PackerSync()
	end
})
