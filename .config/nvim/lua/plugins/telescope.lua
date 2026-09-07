return {
	'nvim-telescope/telescope.nvim', tag = '0.1.8',
	-- or                              , branch = '0.1.x',
	dependencies = { 'nvim-lua/plenary.nvim' },
	config = function()
		require('telescope').setup({
			defaults = {
				-- telescope's built-in treesitter previewer still calls
				-- `nvim-treesitter.parsers`'s old `ft_to_lang`/`get_parser`
				-- API, which the `main` branch of nvim-treesitter dropped
				-- (nvim-telescope/telescope.nvim#3487, #3547). Until
				-- telescope updates for the new API, fall back to
				-- regex-based highlighting in the preview window instead
				-- of crashing.
				preview = {
					treesitter = false,
				},
			},
		})
	end,
}
