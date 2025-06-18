local wezterm = require("wezterm")


local config = wezterm.config_builder()


config.font = wezterm.font("0xProto Nerd Font")


config.font_size = 12

config.enable_tab_bar = false

config.window_decorations = "TITLE | RESIZE"

config.window_background_opacity = 0.9
config.macos_window_background_blur = 10

config.color_scheme = "Catppuccin Mocha"
-- config.color_scheme = "Batman"

return config

