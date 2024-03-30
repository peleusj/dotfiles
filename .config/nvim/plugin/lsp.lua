require("mason").setup()
require("mason-lspconfig").setup({
    automatic_installation = true,
})

vim.keymap.set("n", "<space>do", vim.diagnostic.open_float)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "<space>dl", vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

        -- Buffer local mappings.
        local opts = { buffer = ev.buf }
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
        vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
        vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
        vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
        vim.keymap.set("n", "<space>wl", function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, opts)
        vim.keymap.set("n", "<space>ld", vim.lsp.buf.type_definition, opts)
        vim.keymap.set("n", "<space>lr", vim.lsp.buf.rename, opts)
        vim.keymap.set({ "n", "v" }, "<space>la", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "<space>lf", function()
            vim.lsp.buf.format { async = true }
        end, opts)
    end,
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- See https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#lua_ls
-- See https://github.com/LuaLS/lua-language-server/wiki/Settings
-- See https://github.com/CppCXY/EmmyLuaCodeStyle/blob/master/lua.template.editorconfig
require("lspconfig").lua_ls.setup {
    capabilities = capabilities,
    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT",
            },
            diagnostics = {
                globals = { "vim" },
            },
            telemetry = { enable = false },
            format = {
                enable = true,
                defaultConfig = {
                    quote_style = "double",
                    indent_style = "tab",
                    tab_width = "2"
                }
            },
        }
    }
}

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#pyright
require'lspconfig'.pyright.setup{
    capabilities = capabilities
}
