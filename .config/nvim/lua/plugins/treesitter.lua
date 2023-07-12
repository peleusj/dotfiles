return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require('nvim-treesitter.configs').setup {
        ensure_installed = {
          "lua", "python", "typescript", "rust", "go"
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
