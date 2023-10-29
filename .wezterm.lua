local wezterm = require "wezterm"

local config = {}

if wezterm.config_builder then
    config = wezterm.config_builder()
end

config.font_size = 22
config.font = wezterm.font_with_fallback {
    "Fira Code",
    "LXGW WenKai Mono"
}

config.window_decorations = "RESIZE"

config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.hide_tab_bar_if_only_one_tab = true

config.color_scheme = "carbonfox"
config.colors = {
    tab_bar = {
        background = "#333333",

        active_tab = {
            fg_color = "#ffffff",
            bg_color = "#444444",
        },

        new_tab = {
            bg_color = "#333333",
            fg_color = "#ffffff",
        },

        new_tab_hover = {
            bg_color = "#555555",
            fg_color = "#ffffff",
        },
    },
}

return config
