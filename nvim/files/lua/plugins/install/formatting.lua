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

          javascript = { { "prettierd", "prettier" } },
          typescript = { { "prettierd", "prettier" } },
          javascriptreact = { { "prettierd", "prettier" } },
          typescriptreact = { { "prettierd", "prettier" } },

          json = { { "prettierd", "prettier" } },

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
