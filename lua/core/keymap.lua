-- Set <Space> as mapleader. Make sure this line is called before plugins are setup by lazy, so that mappings 
-- are correct.
vim.g.mapleader = " "

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Move selected lines up and down in visual mode.
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Join the current line with the following, while keeping the cursor in the same position.
vim.keymap.set("n", "J", "mzJ`z")

-- Scroll half screen up/down while keeping the cursor at mid screen.
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Yank into system clipboard ("+" register)
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")

-- Start replacing word (pattern) at cursor location with magic
-- (https://github.com/ThePrimeagen/init.lua/blob/master/lua/theprimeagen/remap.lua)
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

