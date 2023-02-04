return {
  {
    "EdenEast/nightfox.nvim",
    lazy = false,
    priority = 1000,
    config = function() vim.cmd([[colorscheme carbonfox]]) end,
  },

  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },

  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      { "nvim-telescope/telescope-file-browser.nvim" },
      { "tsakirist/telescope-lazy.nvim" },
    },
  },

  {
    "hrsh7th/nvim-cmp",
    -- event = "InsertEnter",
    dependencies = {
      "L3MON4D3/LuaSnip",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "uga-rosa/cmp-dictionary",
    },
  },

  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  "neovim/nvim-lspconfig",

  "numToStr/Comment.nvim",
  "JoosepAlviste/nvim-ts-context-commentstring",

  "windwp/nvim-autopairs",

  "tpope/vim-fugitive",
  "lewis6991/gitsigns.nvim",

  "ii14/emmylua-nvim",
  "fladson/vim-kitty",
}
