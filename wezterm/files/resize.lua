local wezterm = require("wezterm")
local mux = wezterm.mux

local M = {}

-- Every time a resize occurs, save dimensions in a file and recover those when wezterm is reopened.
-- NB: multi-window is not supported. If a new window is spawned, any resize on any window will overwrite previous
-- dimensions.
function M.remember_resize()
  local cache_dir = wezterm.config_dir
  if wezterm.target_triple == "x86_64-pc-windows-msvc" then
    cache_dir = cache_dir .. "\\.cache\\"
  else
    cache_dir = cache_dir .. "/.cache/"
  end
  local cache_window_f = cache_dir .. "window.json"

  wezterm.on("gui-startup", function(cmd)
    -- Ensure cache directory exists
    os.execute("mkdir " .. cache_dir)

    -- Open cache file to recover previous dimensions
    local file = io.open(cache_window_f, "r")
    if file ~= nil then
      local cached = wezterm.json_parse(file:read("a"))
      local tab, pane, window = mux.spawn_window(cmd or { width = cached.cols, height = cached.rows })
      io.close(file)
    end
  end)

  wezterm.on("window-resized", function(window, pane)
    -- press <C-S-L> to open debug overlay
    -- print(window:active_tab():panes_with_info())

    -- Save current dimensions to cache file
    local dimension = window:active_tab():get_size()
    local cached = { cols = dimension.cols, rows = dimension.rows }
    local file = io.open(cache_window_f, "w")
    if file ~= nil then
      io.output(file)
      io.write(wezterm.json_encode(cached))
      io.close(file)
    end
  end)
end

return M
