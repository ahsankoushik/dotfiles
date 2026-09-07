-- nvim-treesitter `main` branch: the old `master` branch (with
-- `nvim-treesitter.configs`) is frozen and doesn't track Neovim's evolving
-- treesitter API — on Neovim 0.12 it crashed the highlighter with
-- "attempt to call method 'range' (a nil value)" on markdown fenced code
-- blocks (neovim/neovim#39032, nvim-treesitter/nvim-treesitter#8618).
-- `main` requires Neovim 0.12+ and replaces `.setup{}` with `.install{}`
-- plus a `FileType` autocmd that calls `vim.treesitter.start()`.

local parsers = {
    "c", "lua", "vim", "vimdoc", "query",
    "markdown", "markdown_inline",
    "typescript", "go", "python", "rust", "svelte", "vue",
}

require("nvim-treesitter").install(parsers)

vim.api.nvim_create_autocmd("FileType", {
    -- filetypes, not parser names: `vimdoc` -> `help`, `markdown_inline`
    -- has no filetype of its own (it's only used via injection).
    pattern = { "c", "lua", "vim", "help", "query", "markdown", "typescript", "go", "python", "rust", "svelte", "vue" },
    callback = function()
        -- pcall guards the first BufRead before an async install finishes
        pcall(vim.treesitter.start)
    end,
})
