require("mason").setup()
local lspconfig = require("lspconfig")


local keymap = vim.keymap -- for conciseness

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(ev)
        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf, silent = true }

        -- set keybinds
        opts.desc = "Show LSP references"
        keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

        opts.desc = "Go to declaration"
        keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

        opts.desc = "Show LSP definitions"
        keymap.set("n", "gd", "<cmd>vsplit | Telescope lsp_definitions<CR>", opts) -- show lsp definitions

        opts.desc = "Show LSP implementations"
        keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementationslsp

        opts.desc = "Show LSP type definitions"
        keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

        opts.desc = "See available code actions"
        keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

        opts.desc = "Smart rename"
        keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

        opts.desc = "Show buffer diagnostics"
        keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

        opts.desc = "Show line diagnostics"
        keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

        opts.desc = "Go to previous diagnostic"
        keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

        opts.desc = "Go to next diagnostic"
        keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

        opts.desc = "Show documentation for what is under cursor"
        keymap.set("n", "F", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

        opts.desc = "Restart LSP"
        keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
        vim.keymap.set("n", "<leader>fr", function()
            vim.lsp.buf.format({ async = true })
        end, { buffer = bufnr, desc = "[F]ormat buffer" })
    end,
})

-- for function help
require("lsp_signature").setup({
    bind = true,
    floating_window = true,
    hint_enable = true,
    handler_opts = {
        border = "rounded"
    }
})

-- 👇 Add this line before setting up LSP servers
local capabilities = require("cmp_nvim_lsp").default_capabilities()
-- List of servers
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
    -- "ts_ls", -- using volar
    "rust_analyzer",
    "grammarly",
    "markdown_oxide",
    "nginx_language_server",
    "jdtls",
    "lemminx",
}
for _, server_name in ipairs(servers) do
    lspconfig[server_name].setup({
        capabilities = capabilities,
    })
end
vim.lsp.config('*', {
    capabilities = capabilities
})
vim.lsp.enable('kotlin_lsp')
lspconfig["svelte"].setup({
    capabilities = capabilities,
    on_attach = function(client, bufnr)
        -- Notify change on JS/TS file write
        vim.api.nvim_create_autocmd("BufWritePost", {
            pattern = { "*.js", "*.ts" },
            callback = function(ctx)
                client.notify("$/onDidChangeTsOrJsFile", {
                    uri = vim.uri_from_fname(ctx.match)
                })
            end,
        }) -- Custom user command
    end,
})


lspconfig.volar.setup({
    capabilities = capabilities,
    filetypes = { "vue", "javascript", "typescript", "javascriptreact", "typescriptreact" },
    init_options = {
        vue = {
            hybridMode = false, -- set to false to fully enable take-over mode
        },
        typescript = {
            tsdk = vim.fn.stdpath("data") .. "/mason/packages/typescript-language-server/node_modules/typescript/lib",
            -- This is the key addition:
            plugins = {
                {
                    name = "@vue/typescript-plugin",
                    location = vim.fn.stdpath("data") ..
                        "/mason/packages/@vue/typescript-plugin/node_modules/@vue/typescript-plugin",
                    languages = { "javascript", "typescript", "vue" },
                },
            },
        },
    },
})

local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end


-- Change the Diagnostic symbols in the sign column (gutter)
-- (not in youtube nvim video)
vim.diagnostic.config({
    virtual_text = {
        prefix = function(diagnostic)
            local icons = {
                Error = " ",
                Warn  = " ",
                Hint  = "󰠠 ",
                Info  = " ",
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
