return {
  -- Lsp progress info (to use with statusline lualine)
  {
    "linrongbin16/lsp-progress.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lsp-progress").setup()
    end,
  },

  -- statusline
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "linrongbin16/lsp-progress.nvim",
    },
    lazy = false,
    config = function()
      require("lualine").setup({
        options = {
          -- Set theme. See lualine readme, or, for catppuccin,
          -- see https://github.com/catppuccin/nvim#integrations
          theme = "catppuccin",

          icons_enabled = true,
          component_separators = { left = " ", right = " " },
          section_separators = { left = "", right = "" },
          -- component_separators = { left = '', right = ''},
          -- section_separators = { left = '', right = ''},
          disabled_filetypes = {
            statusline = {},
            winbar = {},
          },
          ignore_focus = {},
          always_divide_middle = true,
          globalstatus = true,
          refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
          },
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = {
            "branch",
            "diff",
            {
              "diagnostics",
              symbols = {
                error = "󰅚 ", -- x000f015a
                warn = "󰀪 ", -- x000f002a
                info = "󰋽 ", -- x000f02fd
                hint = "󰌶 ", -- x000f0336
              },
            },
          },
          lualine_c = {
            { "filename", path = 1 },
            "require('lsp-progress').progress()", -- see lsp-progress.nvim
          },
          lualine_x = { "encoding", "fileformat", "filetype" },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { "filename" },
          lualine_x = { "location" },
          lualine_y = {},
          lualine_z = {},
        },
        tabline = {},
        winbar = {},
        inactive_winbar = {},
        -- extensions = {"quickfix"}
        extensions = { "lazy", "neo-tree" },
      })

      -- listen lsp-progress event and refresh lualine
      vim.api.nvim_create_augroup("lualine_augroup", { clear = true })
      vim.api.nvim_create_autocmd("User LspProgressStatusUpdated", {
        group = "lualine_augroup",
        callback = require("lualine").refresh,
      })
    end,
  },
}
