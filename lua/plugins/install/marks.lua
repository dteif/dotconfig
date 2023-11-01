return {
  {
    "ThePrimeagen/harpoon",
    dependencies = { "nvim-lua/plenary.nvim" },
    lazy = false,
    config = function()
      require("core.keymap").harpoon()
    end,
  },
}
