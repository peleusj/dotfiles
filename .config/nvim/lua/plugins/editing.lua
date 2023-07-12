return {
    {
        "JoosepAlviste/nvim-ts-context-commentstring",
        dependencies = {
            { "nvim-treesitter/nvim-treesitter" }
        }
    },

    {
        "numToStr/Comment.nvim",
        config = function()
            require("Comment").setup {
                pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
            }
        end
    },

    "fladson/vim-kitty",
}
