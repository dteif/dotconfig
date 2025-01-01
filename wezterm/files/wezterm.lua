local wezterm = require("wezterm")
local resize = require("resize")

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- ###################################################################### Colors

config.color_scheme = "Catppuccin Macchiato"
-- dim unfocused panes
config.inactive_pane_hsb = {
  saturation = 1.0,
  brightness = 0.8,
}

-- ####################################################################### Fonts

config.font_dirs = { "assets/fonts" }

--   NotoSansM
-- config.line_height = 1.25
-- config.font_size = 11
-- config.font_dirs = { "assets/fonts" }
-- config.font = wezterm.font_with_fallback({
--   {
--     family = "NotoSansM Nerd Font",
--     weight = "Regular",
--     harfbuzz_features = { "calt=0", "clig=0", "liga=0" },
--   },
-- })

--   CaskaydiaCove [Cascadia Code]
config.line_height = 1.4
config.font_size = 11
config.dpi_by_screen = {
  -- ["Built-in Retina Display"] = 144, -- You can omit this if you don't need to change it
  ["PHL 499P9"] = 82,
}
config.font = wezterm.font_with_fallback({
  {
    family = "CaskaydiaCove Nerd Font",
    weight = "Regular",
  },
})
-- override default DemiBold and ExtraLight
config.font_rules = {
  {
    italic = true,
    intensity = "Normal",
    font = wezterm.font({
      family = "CaskaydiaCove Nerd Font",
      style = "Italic",
    }),
  },
  {
    intensity = "Bold",
    italic = true,
    font = wezterm.font({
      family = "CaskaydiaCove Nerd Font",
      weight = "Bold",
      style = "Italic",
    }),
  },
  {
    intensity = "Bold",
    italic = false,
    font = wezterm.font({
      family = "CaskaydiaCove Nerd Font",
      weight = "Bold",
    }),
  },
  {
    italic = true,
    intensity = "Half",
    font = wezterm.font({
      family = "CaskaydiaCove Nerd Font",
      weight = "Light",
      style = "Italic",
    }),
  },
  {
    italic = false,
    intensity = "Half",
    font = wezterm.font({
      family = "CaskaydiaCove Nerd Font",
      weight = "Light",
    }),
  },
}

-- ###################################################################### Window

-- padding
config.window_padding = {
  left = "25px",
  right = "25px",
  top = "25px",
  bottom = "5px",
}
config.enable_scroll_bar = false
config.use_resize_increments = true
-- remove title bar, but keep resizable border
config.window_decorations = "RESIZE"
-- config.window_background_opacity = 0.95
-- config.macos_window_background_blur = 40

-- TabBar
-- config.tab_bar_at_bottom = true -- this is needed if plugin is not used
-- config.use_fancy_tab_bar = false -- this allows the color_scheme to style also tabs (w/o plugin)
config.hide_tab_bar_if_only_one_tab = true
wezterm.plugin.require("https://github.com/nekowinston/wezterm-bar").apply_to_config(config, {
  position = "bottom",
  max_width = 32,
  dividers = "slant_right", -- or "slant_left", "arrows", "rounded", false
  indicator = {
    leader = {
      enabled = true,
      off = " ",
      on = " ",
    },
    mode = {
      enabled = true,
      names = {
        resize_mode = "RESIZE",
        copy_mode = "VISUAL",
        search_mode = "SEARCH",
      },
    },
  },
  tabs = {
    numerals = "arabic", -- or "roman"
    pane_count = "superscript", -- or "subscript", false
    brackets = {
      active = { "", " ◉" },
      inactive = { "", " ◯" },
    },
  },
  clock = { -- note that this overrides the whole set_right_status
    enabled = false,
    format = "%H:%M", -- use https://wezfurlong.org/wezterm/config/lua/wezterm.time/Time/format.html
  },
})

-- Additional scripts
resize.remember_resize()

-- and finally, return the configuration to wezterm
return config
