return {
  {
    "L3MON4D3/LuaSnip",
    config = function()
      require("luasnip").setup({
        -- The following settings are set to avoid tab strokes moving the cursor around when exiting from a snippet
        -- without first completing it by visiting all the snippet nodes.
        history = false,
        region_check_events = { "CursorMoved", "CursorHold", "InsertEnter" },
      })
    end,
  },
}
