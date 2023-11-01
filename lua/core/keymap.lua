local M = {}

function M.before_setup()
  -- Set <space> as mapleader. Make sure this line is called before plugins are setup by lazy, so that mappings
  -- are correct.
  vim.g.mapleader = " "
end

function M.setup()
  M.general()
end

-- Register general keymaps
function M.general()
  local wk = require("which-key")

  wk.register({
    -- Join the current line with the following, while keeping the cursor in the same position.
    J = { "mzJ`z", "Join with next line" },

    -- Scroll half screen up/down while keeping the cursor at mid screen.
    ["<C-d>"] = { "<C-d>zz", "Scroll up half a page" },
    ["<C-u>"] = { "<C-u>zz", "Scroll down half a page" },

    -- Move between open windows
    ["<M-Left>"] = { "<C-w>h", "Go to the left window" },
    ["<M-Down>"] = { "<C-w>j", "Go to the down window" },
    ["<M-Up>"] = { "<C-w>k", "Go to the up window" },
    ["<M-Right>"] = { "<C-w>l", "Go to the right window" },
    ["˙"] = { "<C-w>h", "Go to the left window" }, -- <M-h>
    ["∆"] = { "<C-w>j", "Go to the down window" }, -- <M-j>
    ["˚"] = { "<C-w>k", "Go to the up window" }, -- <M-k>
    ["¬"] = { "<C-w>l", "Go to the right window" }, -- <M-l>

    -- TODO move to neotree function
    ["ƒ"] = { "<cmd>Neotree focus<cr>", "Go to file tree window" }, -- <M-f>
  }, { mode = "n" })

  wk.register({
    px = { vim.cmd.Ex, "Explore current file directory (netrw)" },

    y = { '"+y', "Yank into system clipboard" },

    -- Start replacing word (pattern) at cursor location with magic
    -- (https://github.com/ThePrimeagen/init.lua/blob/master/lua/theprimeagen/remap.lua)
    s = { ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>", "Replace word under cursor", silent = false },
  }, { mode = "n", prefix = "<leader>" })

  wk.register({
    -- Move selected lines up and down in visual mode.
    J = { ":m '>+1<CR>gv=gv", "Shift down line(s)" },
    K = { ":m '<-2<CR>gv=gv", "Shift up line(s)" },
  }, { mode = "v" })

  wk.register({
    y = { '"+y', "Yank into system clipboard" },
  }, { mode = "v", prefix = "<leader>" })
end

-- Register comment.nvim keymaps
function M.comment()
  -- Comment mappings are performed manually to correctly register to which-key and legendary plugins.
  -- Mappings could be performed (like done automatically by plugin) by means of e.g.
  -- ```
  -- wk.register({
  --   gc = { "<Plug>(comment_toggle_linewise)", "Comment toggle linewise" },
  --   gb = { "<Plug>(comment_toggle_blockwise)", "Comment toggle blockwise" },
  -- }, { mode = "n" })
  -- ```
  -- However, since for count-dependent 'comment_toggle_linewise_count' (called by original 'gcc' keybind to support
  -- e.g. 4gcc), an expression keybinding is required, and since this seems not working properly by using which-key,
  -- mapping is performed by means of comment.api module.
  -- See
  -- - https://github.com/numToStr/Comment.nvim/blob/0236521ea582747b58869cb72f70ccfa967d2e89/lua/Comment/init.lua
  -- - :h comment.api

  local wk = require("which-key")
  local api = require("Comment.api")

  local vvar = vim.api.nvim_get_vvar

  wk.register({
    -- Toggle lines (linewise) with dot-repeat support
    -- Example: <leader>c3j will comment 4 lines
    c = { api.call("toggle.linewise", "g@"), "Comment toggle linewise" },
    -- Toggle lines (blockwise) with dot-repeat support
    -- Example: <leader>gb3j will comment 4 lines
    C = { api.call("toggle.blockwise", "g@"), "Comment toggle blockwise" },
  }, { mode = "n", prefix = "<leader>", expr = true })

  wk.register({
    -- Toggle either current line ('<leader>cc') or a number of lines ('[count]<leader>cc')
    -- Does not support dot-repeat (api.call corresponding function does not seem to work)
    cc = {
      function()
        local count = vim.v.count
        if count == 0 then
          api.toggle.linewise.current()
        else
          api.toggle.linewise.count(count)
        end
      end,
      "Comment toggle current line (linewise)",
    },
    -- Toggle current line (block). Similar to linewise above.
    CC = {
      function()
        local count = vim.v.count
        if count == 0 then
          api.toggle.blockwise.current()
        else
          api.toggle.blockwise.count(count)
        end
      end,
      "Comment toggle current line (blockwise)",
    },
  }, { mode = "n", prefix = "<leader>" })

  local esc = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)
  wk.register({
    -- Toggle selection (linewise)
    c = {
      function()
        vim.api.nvim_feedkeys(esc, "nx", false)
        api.toggle.linewise(vim.fn.visualmode())
      end,
      "Comment toggle selection (linewise)",
    },
    -- Toggle selection (blockwise)
    C = {
      function()
        vim.api.nvim_feedkeys(esc, "nx", false)
        api.toggle.blockwise(vim.fn.visualmode())
      end,
      "Comment toggle selection (blockwise)",
    },
  }, { mode = "x", prefix = "<leader>" })

  -- TODO visual + extra?
end

-- Register conform.nvim keymaps
function M.conform()
  local wk = require("which-key")

  wk.register({
    b = {
      f = {
        function()
          require("conform").format({ async = false, lsp_fallback = true })
        end,
        "Format file",
      },
      s = {
        function()
          require("conform").format({ async = false, lsp_fallback = true })
          vim.cmd("w")
        end,
        "Save file after formatting",
      },
      S = { "<cmd>w<cr>", "Save file without formatting" },
    },
  }, { mode = "n", prefix = "<leader>" })

  wk.register({
    b = {
      f = {
        function()
          local start_range = vim.api.nvim_buf_get_mark(0, "<")
          local end_range = vim.api.nvim_buf_get_mark(0, ">")
          local range = { start = start_range }
          range["end"] = end_range
          require("conform").format({ range, async = false, lsp_fallback = true })
        end,
        "Format selection",
      },
    },
  }, { mode = "v", prefix = "<leader>" })
end

-- Register diffview.nvim keymaps
function M.diffview()
  local wk = require("which-key")

  wk.register({
    g = {
      d = {
        v = { "<cmd>DiffviewOpen<cr>", "Open a new diffview that compares against the index" },
        q = { "<cmd>DiffviewClose<cr>", "Close the active diffview" },
      },
    },
  }, { mode = "n", prefix = "<leader>" })
end

-- Register diffview.nvim keymaps actions usable inside diffviews.
--
-- This function, differently from others in this file, returns a table which is then used by diffview
-- setup. The following keymaps will be available only when a diffview tab is open, and if this is active.
-- Therefore, there should not be any conflicts with other 'common' keymaps.
--
-- Diffview default keymaps will be disabled, so this function should return them as well as custom ones.
function M.diffview_actions()
	local actions = require("diffview.actions")

  return {
    view = {
      -- The `view` bindings are active in the diff buffers, only when the current
      -- tabpage is a Diffview.
      { "n", "<tab>",       actions.select_next_entry,              { desc = "Open the diff for the next file" } },
      { "n", "<s-tab>",     actions.select_prev_entry,              { desc = "Open the diff for the previous file" } },
      { "n", "gf",          actions.goto_file_edit,                 { desc = "Open the file in the previous tabpage" } },
      { "n", "<C-w><C-f>",  actions.goto_file_split,                { desc = "Open the file in a new split" } },
      { "n", "<C-w>gf",     actions.goto_file_tab,                  { desc = "Open the file in a new tabpage" } },
      { "n", "<leader>e",   actions.focus_files,                    { desc = "Bring focus to the file panel" } },
      { "n", "<leader>b",   actions.toggle_files,                   { desc = "Toggle the file panel." } },
      { "n", "g<C-x>",      actions.cycle_layout,                   { desc = "Cycle through available layouts." } },
      { "n", "[x",          actions.prev_conflict,                  { desc = "In the merge-tool: jump to the previous conflict" } },
      { "n", "]x",          actions.next_conflict,                  { desc = "In the merge-tool: jump to the next conflict" } },
      { "n", "<leader>co",  actions.conflict_choose("ours"),        { desc = "Choose the OURS version of a conflict" } },
      { "n", "<leader>ct",  actions.conflict_choose("theirs"),      { desc = "Choose the THEIRS version of a conflict" } },
      { "n", "<leader>cb",  actions.conflict_choose("base"),        { desc = "Choose the BASE version of a conflict" } },
      { "n", "<leader>ca",  actions.conflict_choose("all"),         { desc = "Choose all the versions of a conflict" } },
      { "n", "dx",          actions.conflict_choose("none"),        { desc = "Delete the conflict region" } },
      { "n", "<leader>cO",  actions.conflict_choose_all("ours"),    { desc = "Choose the OURS version of a conflict for the whole file" } },
      { "n", "<leader>cT",  actions.conflict_choose_all("theirs"),  { desc = "Choose the THEIRS version of a conflict for the whole file" } },
      { "n", "<leader>cB",  actions.conflict_choose_all("base"),    { desc = "Choose the BASE version of a conflict for the whole file" } },
      { "n", "<leader>cA",  actions.conflict_choose_all("all"),     { desc = "Choose all the versions of a conflict for the whole file" } },
      { "n", "dX",          actions.conflict_choose_all("none"),    { desc = "Delete the conflict region for the whole file" } },
    },
    diff1 = {
      -- Mappings in single window diff layouts
      { "n", "g?", actions.help({ "view", "diff1" }), { desc = "Open the help panel" } },
    },
    diff2 = {
      -- Mappings in 2-way diff layouts
      { "n", "g?", actions.help({ "view", "diff2" }), { desc = "Open the help panel" } },
    },
    diff3 = {
      -- Mappings in 3-way diff layouts
      { { "n", "x" }, "2do",  actions.diffget("ours"),            { desc = "Obtain the diff hunk from the OURS version of the file" } },
      { { "n", "x" }, "3do",  actions.diffget("theirs"),          { desc = "Obtain the diff hunk from the THEIRS version of the file" } },
      { "n",          "g?",   actions.help({ "view", "diff3" }),  { desc = "Open the help panel" } },
    },
    diff4 = {
      -- Mappings in 4-way diff layouts
      { { "n", "x" }, "1do",  actions.diffget("base"),            { desc = "Obtain the diff hunk from the BASE version of the file" } },
      { { "n", "x" }, "2do",  actions.diffget("ours"),            { desc = "Obtain the diff hunk from the OURS version of the file" } },
      { { "n", "x" }, "3do",  actions.diffget("theirs"),          { desc = "Obtain the diff hunk from the THEIRS version of the file" } },
      { "n",          "g?",   actions.help({ "view", "diff4" }),  { desc = "Open the help panel" } },
    },
    file_panel = {
      { "n", "j",              actions.next_entry,                     { desc = "Bring the cursor to the next file entry" } },
      { "n", "<down>",         actions.next_entry,                     { desc = "Bring the cursor to the next file entry" } },
      { "n", "k",              actions.prev_entry,                     { desc = "Bring the cursor to the previous file entry" } },
      { "n", "<up>",           actions.prev_entry,                     { desc = "Bring the cursor to the previous file entry" } },
      { "n", "<cr>",           actions.select_entry,                   { desc = "Open the diff for the selected entry" } },
      { "n", "o",              actions.select_entry,                   { desc = "Open the diff for the selected entry" } },
      { "n", "l",              actions.select_entry,                   { desc = "Open the diff for the selected entry" } },
      { "n", "<2-LeftMouse>",  actions.select_entry,                   { desc = "Open the diff for the selected entry" } },
      { "n", "-",              actions.toggle_stage_entry,             { desc = "Stage / unstage the selected entry" } },
      { "n", "s",              actions.toggle_stage_entry,             { desc = "Stage / unstage the selected entry" } },
      { "n", "S",              actions.stage_all,                      { desc = "Stage all entries" } },
      { "n", "U",              actions.unstage_all,                    { desc = "Unstage all entries" } },
      { "n", "X",              actions.restore_entry,                  { desc = "Restore entry to the state on the left side" } },
      { "n", "L",              actions.open_commit_log,                { desc = "Open the commit log panel" } },
      { "n", "zo",             actions.open_fold,                      { desc = "Expand fold" } },
      { "n", "h",              actions.close_fold,                     { desc = "Collapse fold" } },
      { "n", "zc",             actions.close_fold,                     { desc = "Collapse fold" } },
      { "n", "za",             actions.toggle_fold,                    { desc = "Toggle fold" } },
      { "n", "zR",             actions.open_all_folds,                 { desc = "Expand all folds" } },
      { "n", "zM",             actions.close_all_folds,                { desc = "Collapse all folds" } },
      { "n", "<c-b>",          actions.scroll_view(-0.25),             { desc = "Scroll the view up" } },
      { "n", "<c-f>",          actions.scroll_view(0.25),              { desc = "Scroll the view down" } },
      { "n", "<tab>",          actions.select_next_entry,              { desc = "Open the diff for the next file" } },
      { "n", "<s-tab>",        actions.select_prev_entry,              { desc = "Open the diff for the previous file" } },
      { "n", "gf",             actions.goto_file_edit,                 { desc = "Open the file in the previous tabpage" } },
      { "n", "<C-w><C-f>",     actions.goto_file_split,                { desc = "Open the file in a new split" } },
      { "n", "<C-w>gf",        actions.goto_file_tab,                  { desc = "Open the file in a new tabpage" } },
      { "n", "i",              actions.listing_style,                  { desc = "Toggle between 'list' and 'tree' views" } },
      { "n", "f",              actions.toggle_flatten_dirs,            { desc = "Flatten empty subdirectories in tree listing style" } },
      { "n", "R",              actions.refresh_files,                  { desc = "Update stats and entries in the file list" } },
      { "n", "<leader>e",      actions.focus_files,                    { desc = "Bring focus to the file panel" } },
      { "n", "<leader>b",      actions.toggle_files,                   { desc = "Toggle the file panel" } },
      { "n", "g<C-x>",         actions.cycle_layout,                   { desc = "Cycle available layouts" } },
      { "n", "[x",             actions.prev_conflict,                  { desc = "Go to the previous conflict" } },
      { "n", "]x",             actions.next_conflict,                  { desc = "Go to the next conflict" } },
      { "n", "g?",             actions.help("file_panel"),             { desc = "Open the help panel" } },
      { "n", "<leader>cO",     actions.conflict_choose_all("ours"),    { desc = "Choose the OURS version of a conflict for the whole file" } },
      { "n", "<leader>cT",     actions.conflict_choose_all("theirs"),  { desc = "Choose the THEIRS version of a conflict for the whole file" } },
      { "n", "<leader>cB",     actions.conflict_choose_all("base"),    { desc = "Choose the BASE version of a conflict for the whole file" } },
      { "n", "<leader>cA",     actions.conflict_choose_all("all"),     { desc = "Choose all the versions of a conflict for the whole file" } },
      { "n", "dX",             actions.conflict_choose_all("none"),    { desc = "Delete the conflict region for the whole file" } },
    },
    file_history_panel = {
      { "n", "g!",            actions.options,                     { desc = "Open the option panel" } },
      { "n", "<C-A-d>",       actions.open_in_diffview,            { desc = "Open the entry under the cursor in a diffview" } },
      { "n", "y",             actions.copy_hash,                   { desc = "Copy the commit hash of the entry under the cursor" } },
      { "n", "L",             actions.open_commit_log,             { desc = "Show commit details" } },
      { "n", "zR",            actions.open_all_folds,              { desc = "Expand all folds" } },
      { "n", "zM",            actions.close_all_folds,             { desc = "Collapse all folds" } },
      { "n", "j",             actions.next_entry,                  { desc = "Bring the cursor to the next file entry" } },
      { "n", "<down>",        actions.next_entry,                  { desc = "Bring the cursor to the next file entry" } },
      { "n", "k",             actions.prev_entry,                  { desc = "Bring the cursor to the previous file entry." } },
      { "n", "<up>",          actions.prev_entry,                  { desc = "Bring the cursor to the previous file entry." } },
      { "n", "<cr>",          actions.select_entry,                { desc = "Open the diff for the selected entry." } },
      { "n", "o",             actions.select_entry,                { desc = "Open the diff for the selected entry." } },
      { "n", "<2-LeftMouse>", actions.select_entry,                { desc = "Open the diff for the selected entry." } },
      { "n", "<c-b>",         actions.scroll_view(-0.25),          { desc = "Scroll the view up" } },
      { "n", "<c-f>",         actions.scroll_view(0.25),           { desc = "Scroll the view down" } },
      { "n", "<tab>",         actions.select_next_entry,           { desc = "Open the diff for the next file" } },
      { "n", "<s-tab>",       actions.select_prev_entry,           { desc = "Open the diff for the previous file" } },
      { "n", "gf",            actions.goto_file_edit,              { desc = "Open the file in the previous tabpage" } },
      { "n", "<C-w><C-f>",    actions.goto_file_split,             { desc = "Open the file in a new split" } },
      { "n", "<C-w>gf",       actions.goto_file_tab,               { desc = "Open the file in a new tabpage" } },
      { "n", "<leader>e",     actions.focus_files,                 { desc = "Bring focus to the file panel" } },
      { "n", "<leader>b",     actions.toggle_files,                { desc = "Toggle the file panel" } },
      { "n", "g<C-x>",        actions.cycle_layout,                { desc = "Cycle available layouts" } },
      { "n", "g?",            actions.help("file_history_panel"),  { desc = "Open the help panel" } },
    },
    option_panel = {
      { "n", "<tab>", actions.select_entry,          { desc = "Change the current option" } },
      { "n", "q",     actions.close,                 { desc = "Close the panel" } },
      { "n", "g?",    actions.help("option_panel"),  { desc = "Open the help panel" } },
    },
    help_panel = {
      { "n", "q",     actions.close,  { desc = "Close help menu" } },
      { "n", "<esc>", actions.close,  { desc = "Close help menu" } },
    },
  }
end

-- Register fugitive keymaps
function M.fugitive()
  local wk = require("which-key")

  wk.register({
    g = {
      c = {
        m = { "<cmd>Git commit <bar> wincmd J<cr>", "Commit staged changes" },
      },
    },
  }, { mode = "n", prefix = "<leader>" })
end

-- Register harpoon keymaps
function M.harpoon()
  local wk = require("which-key")
  local mark = require("harpoon.mark")
  local ui = require("harpoon.ui")

  wk.register({
    ["<C-e>"] = { ui.toggle_quick_menu, "Toggle harpoon quick menu" },
  }, { mode = "n" })

  local n_leader_maps = {
    a = { mark.add_file, "Add file to harpoon list" },
  }
  for i = 1, 9 do
    n_leader_maps[tostring(i)] = {
      function()
        ui.nav_file(i)
      end,
      string.format("Go to harpoon file #%d", i),
    }
  end
  wk.register(n_leader_maps, { mode = "n", prefix = "<leader>" })
end

-- Register lspsaga.nvim keymaps
function M.lspsaga()
  local wk = require("which-key")

  wk.register({
    ["<C-`>"] = { "<cmd>Lspsaga term_toggle<cr>", "Open float terminal" },
  }, { mode = "n" })

  wk.register({
    k = {
      f = { "<cmd>Lspsaga finder def+ref+imp<cr>", "Open implementation, references and definitions finder" },
      r = { "<cmd>Lspsaga finder ref<cr>", "Open references finder" },
      k = { "<cmd>Lspsaga hover_doc<cr>", "Open documentation for symbol" },
      d = { "<cmd>Lspsaga peek_definition<cr>", "Peek definition" },
      e = {
        f = { "<cmd>Lspsaga show_buf_diagnostics<cr>", "Show file diagnostics" },
        w = { "<cmd>Lspsaga show_workspace_diagnostics<cr>", "Show workspace diagnostics" },
      },
      o = { "<cmd>Lspsaga outline<cr>", "Show outline" },
    },
  }, { mode = "n", prefix = "<leader>" })

  wk.register({
    ["<C-`>"] = { "<cmd>Lspsaga term_toggle<cr>", "Close float terminal" },
  }, { mode = "t" })
end

-- Register telescope.nvim keymaps
function M.telescope()
  local wk = require("which-key")
  local ts = require("telescope.builtin")

  wk.register({
    p = {
      f = {
        function()
          ts.find_files({ hidden = true })
        end,
        "Find file",
      },
      F = {
        function()
          ts.find_files({ hidden = true, no_ignore = true })
        end,
        "Find file (w/ ignored)",
      },
      S = { ts.grep_string, "Find current string" },
      s = { ts.live_grep, "Find string" },
      g = { ts.git_files, "Find file (git)" },
      b = { ts.buffers, "Find open buffer" },
      h = { ts.help_tags, "Find help tag" },
    },
    k = {
      e = {
        d = { "<cmd>Telescope diagnostics<cr>", "Show workspace diagnostics (telescope)" },
        e = {
          function()
            ts.diagnostics({ bufnr = 0 })
          end,
          "Show file diagnostics (telescope)",
        },
      },
    },
  }, { prefix = "<leader>", mode = "n" })
end

return M
