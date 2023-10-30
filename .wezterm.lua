local wezterm = require "wezterm"
local mux = wezterm.mux
local act = wezterm.action

local config = {}

if wezterm.config_builder then
    config = wezterm.config_builder()
end

config.font_size = 24
config.font = wezterm.font_with_fallback {
    "Iosevka Comfy",
    "LXGW WenKai Mono"
}

config.window_decorations = "RESIZE"

wezterm.on("gui-startup", function(cmd)
    local _, _, window = mux.spawn_window(cmd or {})
    window:gui_window():maximize()
end)

config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.hide_tab_bar_if_only_one_tab = true

config.color_scheme = "carbonfox"

config.leader = { key = "a", mods = "CTRL" }

config.keys = {
    {
        key = "a",
        mods = "LEADER|CTRL",
        action = act.SendKey { key = "a", mods = "CTRL" },
    },

    {
        key = "b",
        mods = "LEADER",
        action = act.SplitPane {
            direction = "Down",
            size = { Percent = 30 },
        },
    },

    {
        key = "r",
        mods = "LEADER",
        action = act.SplitPane {
            direction = "Right",
            size = { Percent = 66 },
        },
    },

    {
        key = "c",
        mods = "LEADER",
        action = act.SpawnTab "CurrentPaneDomain",
    },

    {
        key = "-",
        mods = "LEADER",
        action = act.SplitVertical { domain = "CurrentPaneDomain" },
    },

    {
        key = "\\",
        mods = "LEADER",
        action = act.SplitHorizontal { domain = "CurrentPaneDomain" },
    },

    {
        key = "z",
        mods = "LEADER",
        action = act.TogglePaneZoomState,
    },

    {
        key = "h",
        mods = "LEADER",
        action = act.ActivatePaneDirection "Left",
    },

    {
        key = "l",
        mods = "LEADER",
        action = act.ActivatePaneDirection "Right",
    },

    {
        key = "k",
        mods = "LEADER",
        action = act.ActivatePaneDirection "Up",
    },

    {
        key = "j",
        mods = "LEADER",
        action = act.ActivatePaneDirection "Down",
    },

    {
        key = "H",
        mods = "LEADER",
        action = act.AdjustPaneSize { "Left", 5 },
    },

    {
        key = "J",
        mods = "LEADER",
        action = act.AdjustPaneSize { "Down", 5 },
    },

    {
        key = "K",
        mods = "LEADER",
        action = act.AdjustPaneSize { "Up", 5 }
    },

    {
        key = "L",
        mods = "LEADER",
        action = act.AdjustPaneSize { "Right", 5 },
    },
}

return config
