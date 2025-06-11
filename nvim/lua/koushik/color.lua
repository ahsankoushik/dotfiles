
require("catppuccin").setup({
    flavour = "mocha", -- latte, frappe, macchiato, mocha
    transparent_background = true
})

vim.cmd.colorscheme "catppuccin"

require("themery").setup({
    themes={"catppuccin", "kanagawa", "rose-pine", "tokyonight"},
    livePreview = true
})



-- Change the color of absolute line numbers
vim.api.nvim_set_hl(0, "LineNr", { fg = "#888888", bg = "NONE" })

-- Change the color of the current line number
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#FFD700", bold = true })

-- (Optional) If you use relative numbers and want different colors
vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "#5f87af" })
vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "#5f87af" })

