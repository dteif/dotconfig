return {
  {
    "sudormrfbin/cheatsheet.nvim",
    requires = {
      { "nvim-telescope/telescope.nvim" },
      { "nvim-lua/popup.nvim" },
      { "nvim-lua/plenary.nvim" },
    },
    lazy = true,
    cmd = { "Cheatsheet", "CheatsheetEdit" },
  },

  -- dressing.nvim
  -- Improve the built-in vim.ui interfaces with telescope, fzf, etc.
  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
    config = function()
      require("dressing").setup({
        select = {
          get_config = function(opts)
            opts = opts or {}
            local cfg = {
              telescope = {
                layout_config = {
                  width = 120,
                  height = 25,
                },
              },
            }
            if opts.kind == "legendary.nvim" then
              cfg.telescope.sorter = require("telescope.sorters").fuzzy_with_index_bias({})
            end
            return cfg
          end,
        },
      })
    end,
  },
}
