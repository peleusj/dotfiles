require("lualine").setup {
    options = {
        section_separators = { left = "", right = "" },
        component_separators = { left = "", right = "" },

    },
    sections = {
        -- lualine_b = {'branch', 'diff', 'diagnostics'},
        -- lualine_x = {'encoding', 'fileformat', 'filetype'},
        lualine_b = { "branch" },
        lualine_x = { "diagnostics" }
    },
    extensions = { "fugitive" }
}
