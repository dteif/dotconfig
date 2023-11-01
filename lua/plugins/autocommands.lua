local config_path = vim.fn.stdpath("config")

-- create a "lazy_install" autocommands group to group plugin management autocommands
local lazy_augroup = vim.api.nvim_create_augroup("lazy_install", {})

-- this autocommand will install plugins when any plugin configuration changes. When
-- a change in the configuration of lazy is detected, LazyReload event will be fired.
vim.api.nvim_create_autocmd({ "User" }, {
  group = lazy_augroup,
  pattern = "LazyReload",
  callback = function()
    vim.cmd.source()
    local lazy = require("lazy")
    lazy.clean({ wait = true })
    lazy.install({ wait = true })
  end,
})

--[[
vim.api.nvim_create_autocmd({"BufWritePost"}, {
	group = lazy_augroup,
	pattern = {
		config_path .. "/lua/plugins/init.lua", 
		config_path .. "/lua/plugins/install/*.lua",
	},
	callback = function()
		print("Plugins configuration change detected. Installing...")
		vim.cmd.source()
		local lazy = require('lazy')
		lazy.clean({ wait = true })
		lazy.install({ wait = true })
	end
})
--]]
