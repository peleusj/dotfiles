require("nvim-treesitter.configs").setup {
    ensure_installed = {
        "lua",
        "python",
        "go",
        "rust",
        "typescript",
        "sql",
        "bash",
        "yaml",
        "toml"
    },
    sync_install = false,
    highlight = {
        enable = true,
    },
    indent = {
        enable = false,
    },
}
