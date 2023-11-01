return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    },
    lazy = false,
    config = function()
      require("neo-tree").setup({
        -- The following are some of the available settings
        -- You can call `:lua require("neo-tree").paste_default_config()` to
        -- paste in the current file the documented default config.

        -- If a user has a sources list it will replace this one.
        -- Only sources listed here will be loaded.
        -- You can also add an external source by adding it's name to this list.
        -- The name used here must be the same name you would use in a require() call.
        sources = {
          "filesystem",
          "buffers",
          "git_status",
          "document_symbols",
        },
        default_source = "filesystem",
        popup_border_style = "rounded", -- "double", "none", "rounded", "shadow", "single" or "solid"

        add_blank_line_at_top = false,
        close_if_last_window = false,
        hide_root_node = false,
        -- If the root node is hidden, keep the indentation anyhow.
        -- This is needed if you use expanders because they render in the indent.
        retain_hidden_root_indent = true,
        open_files_in_last_window = true, -- false = open files in top left window

        -- source_selector provides clickable tabs to switch between sources.
        source_selector = {
          sources = {
            { source = "filesystem" },
            { source = "document_symbols" },
            { source = "buffers" },
            { source = "git_status" },
          },
          winbar = true,
        },

        default_component_configs = {
          diagnostics = {
            symbols = {
              hint = "󰌵",
              info = " ",
              warn = " ",
              error = " ",
            },
            highlights = {
              hint = "DiagnosticSignHint",
              info = "DiagnosticSignInfo",
              warn = "DiagnosticSignWarn",
              error = "DiagnosticSignError",
            },
          },

          indent = {
            indent_size = 2,
            padding = 1,
            -- indent guides
            with_markers = true,
            indent_marker = "│",
            last_indent_marker = "└",
            highlight = "NeoTreeIndentMarker",
            -- expander config, needed for nesting files
            with_expanders = false, -- if nil and file nesting is enabled, will enable expanders
            expander_collapsed = "",
            expander_expanded = "",
            expander_highlight = "NeoTreeExpander",
          },
          icon = {
            folder_closed = "",
            folder_open = "",
            folder_empty = "󰉖",
            folder_empty_open = "󰷏",
            -- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
            -- then these will never be used.
            default = "*",
            highlight = "NeoTreeFileIcon",
          },
          modified = {
            symbol = "[+] ",
            highlight = "NeoTreeModified",
          },
          name = {
            trailing_slash = false,
            highlight_opened_files = false, -- Requires `enable_opened_markers = true`.
            -- Take values in { false (no highlight), true (only loaded),
            -- "all" (both loaded and unloaded)}. For more information,
            -- see the `show_unloaded` config of the `buffers` source.
            use_git_status_colors = true,
            highlight = "NeoTreeFileName",
          },
          git_status = {
            symbols = {
              -- Change type
              added = "✚", -- NOTE: you can set any of these to an empty string to not show them
              deleted = "✖",
              modified = "",
              renamed = "󰁕",
              -- Status type
              untracked = "",
              ignored = "",
              unstaged = "󰄱",
              staged = "",
              conflict = "",
            },
            align = "right",
          },
        },

        window = {
          position = "left", -- left, right, top, bottom, float, current
          width = 40, -- applies to left and right positions
          height = 15, -- applies to top and bottom positions
          auto_expand_width = false, -- expand the window when file exceeds the window width. does not work with position = "float"
          -- settings that apply to float position only
          popup = {
            size = {
              height = "80%",
              width = "50%",
            },
            position = "50%", -- 50% means center it
            -- you can also specify border here, if you want a different setting from
            -- the global popup_border_style.
          },
          -- Create and paste/move files/directories on the same level as the directory under cursor (as opposed to within the directory under cursor).
          same_level = false,
          -- Affects how nodes get inserted into the tree during creation/pasting/moving of files if the node under the cursor is a directory:
          -- "child":   Insert nodes as children of the directory under cursor.
          -- "sibling": Insert nodes  as siblings of the directory under cursor.
          -- Mappings for tree window. See `:h neo-tree-mappings` for a list of built-in commands.
          -- You can also create your own commands by providing a function instead of a string.
          insert_as = "child",
          mappings = {
            -- Change 'toggle_node' from space to tab, since the first one is also the <leader>.
            ["<space>"] = "none",
            ["<tab>"] = {
              "toggle_node",
              nowait = false, -- disable `nowait` if you have existing combos starting with this char that you want to use
            },
          },
        },

        filesystem = {
          -- "auto"   means refreshes are async, but it's synchronous when called from the Neotree commands.
          -- "always" means directory scans are always async.
          -- "never"  means directory scans are never async.
          async_directory_scan = "auto",
          -- "shallow": Don't scan into directories to detect possible empty directory a priori
          -- "deep": Scan into directories to detect empty or grouped empty directories a priori.
          scan_mode = "shallow",

          filtered_items = {
            visible = true, -- when true, they will just be displayed differently than normal items
            force_visible_in_empty_folder = false, -- when true, hidden files will be shown if the root folder is otherwise empty
            show_hidden_count = true, -- when true, the number of hidden items in each folder will be shown as the last entry
            hide_dotfiles = true,
            hide_gitignored = true,
            hide_hidden = true, -- only works on Windows for hidden files/directories
            hide_by_name = {
              ".DS_Store",
              "thumbs.db",
              "node_modules",
            },
            -- uses glob style patterns
            hide_by_pattern = {
              --"*.meta",
              --"*/src/*/tsconfig.json"
            },
            -- remains visible even if other settings would normally hide it
            always_show = {
              --".gitignored",
            },
            -- remains hidden even if visible is toggled to true, this overrides always_show
            never_show = {
              ".DS_Store",
              "thumbs.db",
            },
            -- uses glob style patterns
            never_show_by_pattern = {
              --".null-ls_*",
            },
          },
          -- `false` means it only searches the tail of a path.
          -- `true` will change the filter into a full path
          -- search with space as an implicit ".*", so
          -- `fi init`
          -- will match: `./sources/filesystem/init.lua
          find_by_full_path_words = false,
          -- find_command = "fd", -- this is determined automatically, you probably don't need to set it
          -- you can specify extra args to pass to the find command.
          -- find_args = {
          -- 	fd = {
          -- 		"--exclude", ".git",
          -- 		"--exclude",  "node_modules"
          -- 	}
          -- },
          group_empty_dirs = false, -- when true, empty folders will be grouped together
          search_limit = 50, -- max number of search results when using filters
          follow_current_file = {
            enabled = true, -- This will find and focus the file in the active buffer every time
            --               -- the current file is changed while the tree is open.
            leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
          },
          hijack_netrw_behavior = "open_default", -- netrw disabled, opening a directory opens neo-tree
          -- in whatever position is specified in window.position
          -- "open_current",-- netrw disabled, opening a directory opens within the
          -- window like netrw would, regardless of window.position
          -- "disabled",    -- netrw left alone, neo-tree does not handle opening dirs
          use_libuv_file_watcher = false, -- This will use the OS level file watchers to detect changes
          -- instead of relying on nvim autocmd events.
        },
        document_symbols = {
          custom_kinds = {
            -- define custom kinds here (also remember to add icon and hl group to kinds)
            -- ccls
            -- [252] = 'TypeAlias',
            -- [253] = 'Parameter',
            -- [254] = 'StaticMethod',
            -- [255] = 'Macro',
          },
          kinds = {
            Unknown = { icon = "?", hl = "" },
            Root = { icon = "", hl = "NeoTreeRootName" },
            File = { icon = "󰈙", hl = "Tag" },
            Module = { icon = "", hl = "Exception" },
            Namespace = { icon = "󰌗", hl = "Include" },
            Package = { icon = "󰏖", hl = "Label" },
            Class = { icon = "󰌗", hl = "Include" },
            Method = { icon = "", hl = "Function" },
            Property = { icon = "󰆧", hl = "@property" },
            Field = { icon = "", hl = "@field" },
            Constructor = { icon = "", hl = "@constructor" },
            Enum = { icon = "󰒻", hl = "@number" },
            Interface = { icon = "", hl = "Type" },
            Function = { icon = "󰊕", hl = "Function" },
            Variable = { icon = "", hl = "@variable" },
            Constant = { icon = "", hl = "Constant" },
            String = { icon = "󰀬", hl = "String" },
            Number = { icon = "󰎠", hl = "Number" },
            Boolean = { icon = "", hl = "Boolean" },
            Array = { icon = "󰅪", hl = "Type" },
            Object = { icon = "󰅩", hl = "Type" },
            Key = { icon = "󰌋", hl = "" },
            Null = { icon = "", hl = "Constant" },
            EnumMember = { icon = "", hl = "Number" },
            Struct = { icon = "󰌗", hl = "Type" },
            Event = { icon = "", hl = "Constant" },
            Operator = { icon = "󰆕", hl = "Operator" },
            TypeParameter = { icon = "󰊄", hl = "Type" },

            -- ccls
            -- TypeAlias = { icon = ' ', hl = 'Type' },
            -- Parameter = { icon = ' ', hl = '@parameter' },
            -- StaticMethod = { icon = '󰠄 ', hl = 'Function' },
            -- Macro = { icon = ' ', hl = 'Macro' },
          },
        },
      })
    end,
  },
}
