return {
	{"nvim-treesitter/nvim-treesitter",
    branch = 'main',
    lazy = false, -- main branch doesn't support lazy-loading
    build = ":TSUpdate"}
}
