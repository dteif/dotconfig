local M = {}

--- Check if the cwd path corresponds to the nvim config path.
--- @return boolean
function M.is_cwd_nvim_config()
	local path = vim.fn.getcwd()
	if path then
		path = vim.fs.normalize(path)
		local config_root = vim.fn.stdpath("config")
		config_root = vim.fs.normalize(config_root)
		return path:find(config_root, 1, true) == 1
	end
	return false
end

return M
