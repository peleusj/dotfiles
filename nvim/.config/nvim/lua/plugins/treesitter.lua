return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require('nvim-treesitter.configs').setup {
        ensure_installed = {
          "lua", "vim", "help", "query", "python", "typescript", "tsx", "rust", "go",
        },
        sync_install = false,
        highlight = {
          enable = true,
        },
        indent = {
          enable = false,
        },
        context_commentstring = {
          enable = true,
          enable_autocmd = false,
        }
      }
    end
  },
}
