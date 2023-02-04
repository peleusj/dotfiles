local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<space>do', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '<space>du', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', '<space>dd', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>dl', vim.diagnostic.setloclist, opts)

require("mason").setup()

require("mason-lspconfig").setup({
  automatic_installation = true,
})

local lspconfig = require('lspconfig')
local util = require('lspconfig.util')

local on_attach = function(_, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>lt', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>lr', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>lc', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>lf', function() vim.lsp.buf.format { async = true } end, bufopts)
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#sumneko_lua
-- https://github.com/ii14/emmylua-nvim
lspconfig.sumneko_lua.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  root_dir = util.root_pattern(".luarc.json", ".luacheckrc", ".stylua.toml", "stylua.toml", "selene.toml", ".git",
    "init.lua"),
  settings = { -- https://github.com/sumneko/lua-language-server/wiki/Settings
    Lua = {
      runtime = {
        version = 'LuaJIT',
      },
      diagnostics = {
        globals = { 'vim' },
        neededFileStatus = {
          ['codestyle-check'] = 'Any',
        },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file('', true),
        checkThirdParty = false
      },
      telemetry = { enable = false },
      format = {
        defaultConfig = {
          indent_style = 'space',
          indent_size = '2',
        }
      },
    },
  },
}
