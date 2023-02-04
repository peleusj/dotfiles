local status, ts = pcall(require, 'nvim-treesitter.configs')
if (not status) then return end

ts.setup {
  ensure_installed = {
    'vim',
    'lua',
    'javascript',
    'typescript',
    'python',
  },
  highlight = {
    enable = true,
  },
  indent = {
    enable = false,
  },
  context_commentstring = {
    -- https://github.com/JoosepAlviste/nvim-ts-context-commentstring#commentnvim
    enable = true,
    enable_autocmd = false,
  }
}
