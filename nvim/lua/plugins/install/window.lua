return {
  -- Navigate between nvim and tmux panes seamlessly
  {
    "numToStr/Navigator.nvim",
    config = function()
      require("Navigator").setup()

      require("core.keymap").navigator()
    end,
  },
}
