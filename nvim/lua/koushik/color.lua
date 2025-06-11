
require("catppuccin").setup({
    flavour = "mocha", -- latte, frappe, macchiato, mocha
    transparent_background = true
})

vim.cmd.colorscheme "catppuccin"

require("themery").setup({
    themes={"catppuccin", "kanagawa", "rose-pine", "tokyonight"},
    livePreview = true
})

