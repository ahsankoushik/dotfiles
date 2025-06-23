local wezterm = require("wezterm")
local home = os.getenv("HOME")


local config = wezterm.config_builder()


config.font = wezterm.font("0xProto Nerd Font")


config.font_size = 12

config.enable_tab_bar = false

config.window_decorations = "TITLE | RESIZE"

-- config.window_background_opacity = 0.8
config.macos_window_background_blur = 10

config.color_scheme = "Catppuccin Mocha"
-- config.color_scheme = "Batman"
config.background = {
    {
        source ={
            File = home .. "/dotfiles/one-piece.jpg"

        },
        hsb = {
            brightness = 0.2,
            hue = 1.0,
            saturation = 1.0,
        },
    }
}
return config

