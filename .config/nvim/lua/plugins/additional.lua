return {
    { 'mbbill/undotree' },
    { "christoomey/vim-tmux-navigator" },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 500
        end,
        opts = {

        }
    },
    { "mg979/vim-visual-multi" },
    { "lewis6991/gitsigns.nvim" },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' }
    },
    {
        "ray-x/lsp_signature.nvim",
    }
}
