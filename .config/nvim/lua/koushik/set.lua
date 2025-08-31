vim.opt.nu = true
vim.opt.relativenumber = true


vim.opt.incsearch = true

vim.cmd("let g:netrw_liststyle = 3")

vim.opt.wrap = false
-- search
vim.opt.ignorecase = true -- ingnores case sensetive search
vim.opt.smartcase = true  -- when Hello auto does case sensetive search

vim.opt.clipboard:append("unnamedplus")

vim.opt.splitright = true
vim.opt.splitbelow = true


-- Function to set 2-space indentation
function SetTabsTo2()
    vim.opt.tabstop = 2
    vim.opt.softtabstop = 2
    vim.opt.shiftwidth = 2
    vim.opt.expandtab = true -- converts tabs to spaces (recommended)
    vim.opt.smarttab = true
end

-- Function to set 4-space indentation
function SetTabsTo4()
    vim.opt.tabstop = 4
    vim.opt.softtabstop = 4
    vim.opt.shiftwidth = 4
    vim.opt.expandtab = true
    vim.opt.smarttab = true
end

vim.api.nvim_create_user_command("Tabs2", function() SetTabsTo2() end, {})
vim.api.nvim_create_user_command("Tabs4", function() SetTabsTo4() end, {})
SetTabsTo4()
