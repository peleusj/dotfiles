require("nightfox").setup({
    options = {
        transparent = true,
    }
})

require("vscode").setup({
    transparent = true,
    italic_comments = true,
})

-- preferred themes
local themes = {
    "nightfox",
    "terafox",
    "nordfox",
    "carbonfox",
    "duskfox"
}

math.randomseed(os.time())

-- pick a random theme
local function pickRandomTheme()
    local randomIndex = math.random(1, #themes)
    return themes[randomIndex]
end

-- set the random theme
vim.cmd("colorscheme " .. pickRandomTheme())
