
return {
  {
    "github/copilot.vim",
    lazy = false, -- load the plugin
    init = function()
      vim.g.copilot_enabled = false -- start disabled
      vim.g.copilot_no_tab_map = true
    end,
    config = function()
      -- Custom keymap for accepting suggestions
      vim.api.nvim_set_keymap("i", "<C-j>", 'copilot#Accept("<CR>")', {
        silent = true,
        expr = true,
        script = true,
      })
    end,
  },
}

