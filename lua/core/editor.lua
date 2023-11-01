local M = {}

function M.before_setup() end

function M.setup()
  -- Set line number (relative)
  vim.opt.number = true
  vim.opt.relativenumber = true

  -- Set tabs width and always insert spaces instead of actual tabs.
  vim.opt.expandtab = true
  vim.opt.shiftwidth = 2
  vim.opt.softtabstop = 2
  vim.opt.tabstop = 2

  -- Do smart autoindenting when starting a new line. Works for C-like programs, but can also be used for other languages.
  vim.opt.smartindent = true

  -- Do not wrap text
  vim.opt.wrap = false

  -- Save history to file
  vim.opt.undofile = true

  -- Highlight all matches while searching, but without keeping them  highlighted when search is finished. The option
  -- 'vim.opt.hlsearch' is enabled when starting to search and disabled when leaving.
  local incsearch_highlight_augroup = vim.api.nvim_create_augroup("incsearch_highlight", {})
  vim.api.nvim_create_autocmd({ "CmdlineEnter" }, {
    group = incsearch_highlight_augroup,
    pattern = "/,?",
    command = ":set hlsearch",
  })
  vim.api.nvim_create_autocmd({ "CmdlineLeave" }, {
    group = incsearch_highlight_augroup,
    pattern = "/,?",
    command = ":set nohlsearch",
  })

  -- Enables 24-bit RGB color in the terminal ui. Requires an ISO-8613-3 compatible terminal.
  vim.opt.termguicolors = true

  -- Set minimal number of screen lines to keep above and below the cursor when scrolling.
  vim.opt.scrolloff = 8

  -- Fixed enabled signcolumn
  vim.opt.signcolumn = "yes"

  -- Add ruler column
  vim.opt.colorcolumn = "120"
end

return M
