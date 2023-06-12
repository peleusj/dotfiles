return {
  {
    "williamboman/mason.nvim",
    config = true
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require('mason-lspconfig').setup({
        automatic_installation = true,
      })
    end
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      -- Mappings.
      -- See `:help vim.diagnostic.*` for documentation on any of the below functions
      local opts = { noremap = true, silent = true }
      vim.keymap.set('n', '<space>do', vim.diagnostic.open_float, opts)
      vim.keymap.set('n', '<space>dp', vim.diagnostic.goto_prev, opts)
      vim.keymap.set('n', '<space>dn', vim.diagnostic.goto_next, opts)
      vim.keymap.set('n', '<space>dl', vim.diagnostic.setloclist, opts)

      -- Use an on_attach function to only map the following keys
      -- after the language server attaches to the current buffer
      local custom_attach = function(_, bufnr)
        vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

        -- Mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
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

      -- https://github.com/neovim/nvim-lspconfig/wiki/Autocompletion
      -- Add additional capabilities supported by nvim-cmp
      local updated_capabilities = require('cmp_nvim_lsp').default_capabilities()

      local lspconfig = require('lspconfig')

      -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#lua_ls
      -- https://github.com/LuaLS/lua-language-server/wiki/Settings
      -- https://github.com/ii14/emmylua-nvim
      lspconfig.lua_ls.setup {
        on_attach = custom_attach,
        capabilities = updated_capabilities,
        settings = {
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

      -- Enable some language servers with the additional completion capabilities offered by nvim-cmp
      local servers = { 'tsserver' }
      for _, server_name in ipairs(servers) do
        lspconfig[server_name].setup {
          on_attach = custom_attach,
          capabilities = updated_capabilities,
        }
      end
    end
  },
}
