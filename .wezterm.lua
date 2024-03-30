local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config.font_size = 20

config.hide_tab_bar_if_only_one_tab = true
config.window_decorations = "INTEGRATED_BUTTONS | RESIZE"

return config
