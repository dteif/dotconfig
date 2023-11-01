return {
  -- Main key bindings manager.
  -- Additionally, this plugin displays a popup with possible key bindings of the command you started typing.
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      -- This determines after how long the WhichKey window is opened when a keybinding button is pressed.
      vim.o.timeoutlen = 0
    end,
    opts = {
      -- your configuration comes here
    },
  },

  -- Legendary is useful to display (by means of telescope) a window will all mapped key bindings.
  -- Key bindings are managed by means of which-key.nvim, so do not add them to this plugin. Legendary will
  -- indeed display also which-key bindings.
  -- Additionally, Legendary can be used to develop custom commands or autocommands and functions callable by means
  -- of its ui.
  {
    "mrjones2014/legendary.nvim",
    -- since legendary.nvim handles all your keymaps/commands,
    -- its recommended to load legendary.nvim before other plugins
    priority = 10000,
    lazy = false,
    -- sqlite is only needed if you want to use frecency sorting
    -- dependencies = { 'kkharji/sqlite.lua' }
    config = function()
      require("legendary").setup({
        -- Initial keymaps to bind, can also be a function that returns the list
        keymaps = {},
        -- Initial commands to bind, can also be a function that returns the list
        commands = {},
        -- Initial augroups/autocmds to bind, can also be a function that returns the list
        autocmds = {},
        -- Initial functions to bind, can also be a function that returns the list
        funcs = {},
        -- Initial item groups to bind,
        -- note that item groups can also
        -- be under keymaps, commands, autocmds, or funcs;
        -- can also be a function that returns the list
        itemgroups = {},
        -- default opts to merge with the `opts` table
        -- of each individual item
        default_opts = {
          -- for example, { silent = true, remap = false }
          keymaps = {},
          -- for example, { args = '?', bang = true }
          commands = {},
          -- for example, { buf = 0, once = true }
          autocmds = {},
        },
        -- Customize the prompt that appears on your vim.ui.select() handler
        -- Can be a string or a function that returns a string.
        select_prompt = "legendary.nvim",
        -- Character to use to separate columns in the UI
        -- col_separator_char = '│',
        col_separator_char = " ",
        -- Optionally pass a custom formatter function. This function
        -- receives the item as a parameter and the mode that legendary
        -- was triggered from (e.g. `function(item, mode): string[]`)
        -- and must return a table of non-nil string values for display.
        -- It must return the same number of values for each item to work correctly.
        -- The values will be used as column values when formatted.
        -- See function `default_format(item)` in
        -- `lua/legendary/ui/format.lua` to see default implementation.
        default_item_formatter = nil,
        -- Customize icons used by the default item formatter
        icons = {
          -- keymap items list the modes in which the keymap applies
          -- by default, you can show an icon instead by setting this to
          -- a non-nil icon
          keymap = nil,
          command = "",
          fn = "󰡱",
          itemgroup = "",
        },
        -- Include builtins by default, set to false to disable
        include_builtin = true,
        -- Include the commands that legendary.nvim creates itself
        -- in the legend by default, set to false to disable
        include_legendary_cmds = false,
        -- lazy_nvim = {
        --   -- Automatically register keymaps that are defined on lazy.nvim plugin specs
        --   -- using the `keys = {}` property.
        --   auto_register = true,
        -- },
        -- which_key = {
        --   -- Automatically add which-key tables to legendary
        --   -- see ./doc/WHICH_KEY.md for more details
        --   auto_register = true,
        --   -- you can put which-key.nvim tables here,
        --   -- or alternatively have them auto-register,
        --   -- see ./doc/WHICH_KEY.md
        --   mappings = {},
        --   opts = {},
        --   -- controls whether legendary.nvim actually binds they keymaps,
        --   -- or if you want to let which-key.nvim handle the bindings.
        --   -- if not passed, true by default
        --   do_binding = false,
        --   -- controls whether to use legendary.nvim item groups
        --   -- matching your which-key.nvim groups; if false, all keymaps
        --   -- are added at toplevel instead of in a group.
        --   use_groups = true,
        -- },
        -- Which extensions to load; no extensions are loaded by default.
        -- Setting the plugin name to `false` disables loading the extension.
        -- Setting it to any other value will attempt to load the extension,
        -- and pass the value as an argument to the extension, which should
        -- be a single function. Extensions are modules under `legendary.extensions.*`
        -- which return a single function, which is responsible for loading and
        -- initializing the extension.
        extensions = {
          nvim_tree = false,
          smart_splits = false,
          op_nvim = false,
          diffview = false,
          lazy_nvim = true,
          which_key = {
            -- Automatically add which-key tables to legendary
            -- see ./doc/WHICH_KEY.md for more details
            auto_register = true,
            -- you can put which-key.nvim tables here,
            -- or alternatively have them auto-register,
            -- see ./doc/WHICH_KEY.md
            mappings = {},
            opts = {},
            -- controls whether legendary.nvim actually binds they keymaps,
            -- or if you want to let which-key.nvim handle the bindings.
            -- if not passed, true by default
            do_binding = false,
            -- controls whether to use legendary.nvim item groups
            -- matching your which-key.nvim groups; if false, all keymaps
            -- are added at toplevel instead of in a group.
            use_groups = true,
          },
        },
        scratchpad = {
          -- How to open the scratchpad buffer,
          -- 'current' for current window, 'float'
          -- for floating window
          view = "float",
          -- How to show the results of evaluated Lua code.
          -- 'print' for `print(result)`, 'float' for a floating window.
          results_view = "float",
          -- Border style for floating windows related to the scratchpad
          float_border = "rounded",
          -- Whether to restore scratchpad contents from a cache file
          keep_contents = true,
        },
        -- Directory used for caches
        cache_path = string.format("%s/legendary/", vim.fn.stdpath("cache")),
        -- Log level, one of 'trace', 'debug', 'info', 'warn', 'error', 'fatal'
        log_level = "info",
      })
    end,
  },
}
