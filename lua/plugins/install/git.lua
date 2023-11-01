return {
  {
    "tpope/vim-fugitive",
    config = function()
      require("core.keymap").fugitive()
    end,
  },

  {
    "sindrets/diffview.nvim",
    config = function()
      -- Use diagonal lines instead of '-' char for	deleted lines of the 'diff' option. See ":h fillchars"
      vim.opt.fillchars:append({ diff = "╱" })

      -- Default plugin keymaps disabled so that they can be overridden by custom ones, if necessary.
      -- The custom (and re-exported defaults) are returned by a function located in "keymaps.lua" which_key
      -- exports the table required by the plugin config.
      local keymaps = vim.tbl_deep_extend("error", {
        disable_defaults = true, -- Disable the default keymaps
      }, require("core.keymap").diffview_actions())

      require("diffview").setup({
        enhanced_diff_hl = true,
        icons = { -- Only applies when use_icons is true.
          folder_closed = "",
          folder_open = "",
        },
        signs = {
          fold_closed = "", -- ""
          fold_open = "", -- ""
          done = "✓",
        },
        view = {
          default = {
            winbar_info = true, -- helps avoiding line mismatches between diff views due to lspsaga breadcrumbs
          },
          file_history = {
            winbar_info = true,
          },
        },

        keymaps,
      })

      require("core.keymap").diffview()
    end,
  },
}
