return {
  {
    "stevearc/conform.nvim",
    opts = {},
    config = function()
      require("conform").setup({
        -- Set formatters to use by file type.
        -- Conform can run multiple formatters sequentially with e.g.:
        --   python = { "isort", "black" },
        -- or can run only the first available formatter by using a sub-list, with e.g.:
        --   javascript = { { "prettierd", "prettier" } },
        -- Use the "*" filetype to run formatters on all filetypes.
        formatters_by_ft = {
          lua = { "stylua" },

          -- nb: prettier was changed to have precedence over prettierd to support
          -- `satisfies` keyword which seems to cause errors (prettierd version 0.26.1)
          javascript = { "prettier", "prettierd", stop_after_first = true },
          typescript = { "prettier", "prettierd", stop_after_first = true },
          javascriptreact = { "prettier", "prettierd", stop_after_first = true },
          typescriptreact = { "prettier", "prettierd", stop_after_first = true },

          json = { "prettier", "prettierd", stop_after_first = true },
          jsonc = { "prettier", "prettierd", stop_after_first = true },

          -- Use the "*" filetype to run formatters on all filetypes.
          --   e.g.: ["*"] = { "codespell" },
          ["*"] = {},
          -- Use the "_" filetype to run formatters on filetypes that don't
          -- have other formatters configured.
          --   e.g.: ["_"] = { "trim_whitespace" },
          ["_"] = {},
        },
      })

      require("core.keymap").conform()
    end,
  },
}
