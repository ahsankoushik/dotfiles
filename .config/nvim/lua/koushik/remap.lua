vim.g.mapleader = " "
--vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc ="Exploer"})
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fd', function()
    builtin.find_files({ hidden = true})
end, { desc = "Telescope find hidden files too"})
vim.keymap.set('n', '<leader>gf', builtin.git_files, { desc = "Git files"})
vim.keymap.set('n', '<leader>gc', builtin.git_commits, { desc = "Git Commits"})
vim.keymap.set('n', '<leader>gs', builtin.git_status,{ desc = "Git Status"})
-- vim.keymap.set('i', '<C-z>' , vim.cmd.undo, { desc = "Undo" })

vim.keymap.set('n', '<C-s>', ':w<CR>', { desc = 'Save file' }) -- Normal mode
vim.keymap.set('i', '<C-s>', '<Esc>:w<CR>a', { desc = 'Save file (insert mode)' }) -- Insert mode



vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")


-- split screen
vim.keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Virtial Split"})
vim.keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Horizonal Split"})
vim.keymap.set("n", "<leader>se", "<C-w>=", { desc = "Split Justificcation"})
vim.keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close Split Screen"})


-- tabs 
vim.keymap.set("n", "<leader>tn", vim.cmd.tabnew, { desc = "New tab"})
vim.keymap.set("n", "<Tab>", vim.cmd.tabn, { desc = "tab next"})
vim.keymap.set("n", "<S-Tab>", vim.cmd.tabp, { desc = "tab previous"})
vim.keymap.set("n", "<leader>tx", vim.cmd.tabclose, { desc = "tab close"})


-- git
vim.keymap.set("n", "<leader>gt", vim.cmd.Git, { desc = "Git Explorer" })

-- themery 
vim.keymap.set("n", "<leader>th", "<cmd>Themery<CR>", { desc = "Themery"})
