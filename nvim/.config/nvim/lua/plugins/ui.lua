return {
  {
    "EdenEast/nightfox.nvim",
    config = function()
      require("nightfox").setup({
        options = {
          transparent = true,
        }
      })

      vim.cmd.colorscheme "nightfox"
    end
  },

  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    opts = {},
  },
}
