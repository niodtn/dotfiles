local wezterm = require 'wezterm'
local config = wezterm.config_builder()

local TAB_EDGE_LEFT = wezterm.nerdfonts.ple_left_half_circle_thick
local TAB_EDGE_RIGHT = wezterm.nerdfonts.ple_right_half_circle_thick

config = {
    window_close_confirmation = "NeverPrompt",

    -- Appearance
    default_cursor_style = "BlinkingBar",

    freetype_load_target = "Light",
    window_padding = {left = 15, right = 15, top = 15, bottom = 15},
    window_frame = {
        active_titlebar_bg = '#000000',
        inactive_titlebar_bg = '#000000'
    }
}

config.colors = {
    tab_bar = {inactive_tab_edge = "#FF0000"}
    -- active_tab = {bg_color = "#FF0000", fg_color = "#00FFFF"},
    -- inactive_tab = {bg_color = "#0000FF", fg_color = "#FFFF00"}
}

config.automatically_reload_config = true

-- FONTS
config.font = wezterm.font("Sarasa Mono K", {weight = "Bold"})
config.font_size = 16
config.window_frame.font = wezterm.font("Sarasa Mono K", {weight = "Bold"})
config.window_frame.font_size = 16

-- TAB BAR
config.window_decorations = "RESIZE"
config.hide_tab_bar_if_only_one_tab = false
config.use_fancy_tab_bar = true

-- WINDOW FRAME
config.window_frame.border_left_width = '12px'
config.window_frame.border_right_width = '12px'
config.window_frame.border_top_height = '12px'
config.window_frame.border_bottom_height = '12px'

config.window_frame.border_left_color = '#000000'
config.window_frame.border_right_color = '#000000'
config.window_frame.border_top_color = '#000000'
config.window_frame.border_bottom_color = '#000000'

return config
