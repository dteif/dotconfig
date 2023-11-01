return {
  -- Toggle comments plugin
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup({
        -- Disable auto mappings so we can define them by means of which-key.
        mappings = false,
      })

      require("core.keymap").comment()
    end,
    lazy = false,
  },

  {
    "mg979/vim-visual-multi",
  },

  {
    "nvim-treesitter/nvim-treesitter-context",
    config = function()
      require("treesitter-context").setup({
        -- max_lines = -1,
      })
    end,
  },
}
