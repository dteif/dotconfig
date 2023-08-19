-- Set <Space> as mapleader. Make sure this line is called before plugins are
-- setup by lazy, so that mappings are correct
vim.g.mapleader = " "

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
