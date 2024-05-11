return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.2",
    -- or
    -- branch = '0.1.x',
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup({
        defaults = {
          -- The following patterns are going to be excluded from every search. Files or directories already
          -- gitignored should not be put here, since by default telescope is already excluding those paths.
          file_ignore_patterns = { ".git/", "yarn.lock" },
        },
      })

      require("core.keymap").telescope()
    end,
  },
}
