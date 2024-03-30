local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    {
        -- "EdenEast/nightfox.nvim",
        "craftzdog/solarized-osaka.nvim",
        -- "rebelot/kanagawa.nvim",
        -- 'kepano/flexoki-neovim',
        -- name = 'flexoki',
        -- "savq/melange-nvim",
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd("colorscheme solarized-osaka")
        end
    },

    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" }
    },

    -- plugin/treesitter.lua
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        dependencies = {
            "JoosepAlviste/nvim-ts-context-commentstring",
        }
    },

    -- plugin/cmp.lua
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            "L3MON4D3/LuaSnip",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "uga-rosa/cmp-dictionary",
            "saadparwaiz1/cmp_luasnip",
            "windwp/nvim-autopairs",
        },
    },

    -- plugin/lsp.lua
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
        }
    },

    -- plugin/telescope.lua
    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" }
        },
    },

    {
        "numToStr/Comment.nvim",
        config = function()
            require("Comment").setup {
                pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
            }
        end
    },

    {
        "nvim-tree/nvim-tree.lua",
        version = "*",
        lazy = false,
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            require("nvim-tree").setup {
                view = {
                    width = 30,
                }
            }
            vim.keymap.set("n", "<leader>ww", ":NvimTreeToggle<CR>")
        end,
    },

    -- plugin/git.lua
    "tpope/vim-fugitive",
    "lewis6991/gitsigns.nvim",

    -- miscellaneous
    "fladson/vim-kitty",
})
