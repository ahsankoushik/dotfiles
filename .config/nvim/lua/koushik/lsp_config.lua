-- Mason setup
require("mason").setup()

-- LSP capabilities from nvim-cmp
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Global diagnostic signs
local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

vim.diagnostic.config({
    virtual_text = {
        prefix = function(diagnostic)
            local icons = {
                Error = " ",
                Warn = " ",
                Hint = "󰠠 ",
                Info = " ",
            }
            return icons[vim.diagnostic.severity[diagnostic.severity]]
        end,
        spacing = 4,
    },
    signs = true,
    underline = true,
    update_in_insert = true,
    severity_sort = true,
})

-- Keybindings when LSP attaches
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(ev)
        local keymap = vim.keymap
        local opts = { buffer = ev.buf, silent = true }

        keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)
        keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
        keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)
        keymap.set("n", "gs", "<cmd>vsplit | Telescope lsp_definitions<CR>", opts)
        keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)
        keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)
        keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
        keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)
        keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
        keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
        keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
        keymap.set("n", "F", vim.lsp.buf.hover, opts)
        keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)
        keymap.set("n", "<leader>fr", function()
            vim.lsp.buf.format({ async = true })
        end, { buffer = ev.buf, desc = "[F]ormat buffer" })
    end,
})

-- Function signature helper
require("lsp_signature").setup({
    bind = true,
    floating_window = true,
    hint_enable = true,
    handler_opts = { border = "rounded" },
})

-- ✅ Define capabilities globally
vim.lsp.config('*', {
    capabilities = capabilities,
})

-- ✅ Enable servers (new style)
local servers = {
    "clangd",
    "cssls",
    "docker_compose_language_service",
    "dockerls",
    "emmet_language_server",
    "emmet_ls",
    "gopls",
    "html",
    "lua_ls",
    "prismals",
    "pyright",
    "tailwindcss",
    "rust_analyzer",
    "grammarly",
    "markdown_oxide",
    "nginx_language_server",
    "jdtls",
    "lemminx",
    "terraformls"
}

for _, server in ipairs(servers) do
    vim.lsp.enable(server)
end

vim.lsp.config('*', {
    capabilities = capabilities
})
vim.lsp.enable('kotlin_lsp')
vim.lsp.enable('dartls')
vim.lsp.enable('svelte')



--
-- lspconfig["svelte"].setup({
--     capabilities = capabilities,
--     on_attach = function(client, bufnr)
--         -- Notify change on JS/TS file write
--         vim.api.nvim_create_autocmd("BufWritePost", {
--             pattern = { "*.js", "*.ts" },
--             callback = function(ctx)
--                 client.notify("$/onDidChangeTsOrJsFile", {
--                     uri = vim.uri_from_fname(ctx.match)
--                 })
--             end,
--         }) -- Custom user command
--     end,
-- })
--

-- lspconfig.volar.setup({
--     capabilities = capabilities,
--     filetypes = { "vue", "javascript", "typescript", "javascriptreact", "typescriptreact" },
--     init_options = {
--         vue = {
--             hybridMode = false, -- set to false to fully enable take-over mode
--         },
--         typescript = {
--             tsdk = vim.fn.stdpath("data") .. "/mason/packages/typescript-language-server/node_modules/typescript/lib",
--             -- This is the key addition:
--             plugins = {
--                 {
--                     name = "@vue/typescript-plugin",
--                     location = vim.fn.stdpath("data") ..
--                         "/mason/packages/@vue/typescript-plugin/node_modules/@vue/typescript-plugin",
--                     languages = { "javascript", "typescript", "vue" },
--                 },
--             },
--         },
--     },
-- })

local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

-- for formating the doucments before saving
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    pattern = { "*.tf", "*.tfvars", "*.go", "*.dart" },
    callback = function()
        vim.lsp.buf.format()
    end,
})
