local status, telescope = pcall(require, 'telescope')
if (not status) then return end

local actions = require('telescope.actions')
local builtin = require('telescope.builtin')

telescope.setup {
  defaults = {
    file_ignore_patterns = { "node_modules/*" },
    sorting_strategy = "ascending",
    layout_strategy = "flex",
    layout_config = {
      width = 0.95,
      height = 0.95,
      prompt_position = "top",
      bottom_pane = {
        height = 8,
      },
      horizontal = {
        preview_width = function(_, cols, _)
          if cols > 200 then
            return math.floor(cols * 0.4)
          else
            return math.floor(cols * 0.6)
          end
        end,
      },
      vertical = {
        preview_cutoff = 1,
        preview_height = 0.6,
      },
    },
    mappings = {
      i = {
        ["<C-h>"] = "which_key",
        ["<C-s>"] = actions.cycle_previewers_next,
        ["<C-a>"] = actions.cycle_previewers_prev,
        ["<C-j>"] = actions.cycle_history_prev,
        ["<C-k>"] = actions.cycle_history_next,
      },
    },
  },
}

local map = vim.keymap.set

-- File pickers
map('n', '<space>ff', '<cmd>Telescope find_files<cr>')
map('n', '<space>fg', '<cmd>Telescope git_files<cr>')
map('n', '<space>fs', '<cmd>Telescope grep_string<cr>')
map('n', '<space>fl', '<cmd>Telescope live_grep<cr>')

-- Vim pickers
map('n', '<space>sb', '<cmd>Telescope buffers<cr>')
map('n', '<space>so', '<cmd>Telescope oldfiles<cr>')
map('n', '<space>sc', '<cmd>Telescope commands<cr>')
map('n', '<space>sh', '<cmd>Telescope help_tags<cr>')
map('n', '<space>sm', '<cmd>Telescope man_pages<cr>')

map('n', '<space>st', function() builtin.colorscheme({ layout_strategy = 'bottom_pane' }) end)

map('n', '<space>sq', '<cmd>Telescope quickfix<cr>')
map('n', '<space>sk', '<cmd>Telescope keymaps<cr>')

-- Neovim LSP pickers
map('n', '<space>sd', '<cmd>Telescope diagnostics<cr>')

-- Git pickers
map('n', '<space>vs', '<cmd>Telescope git_status<cr>')
map('n', '<space>vc', '<cmd>Telescope git_commits<cr>')
map('n', '<space>vb', '<cmd>Telescope git_branches<cr>')

-- Custom pickers
map('n', '<space>fr', function()
  require('telescope.builtin').oldfiles({
    prompt_title = 'CWD Recent',
    only_cwd = true
  })
end)

map('n', '<space>fv', function()
  require("telescope.builtin").find_files({
    prompt_title = 'Neovim Config',
    cwd = os.getenv('HOME') .. "/.config/nvim",
  })
end)

map('n', '<space>fa', function()
  require("telescope.builtin").find_files({
    prompt_title = 'Hidden Files',
    find_command = { 'fd', '--type', 'f', '--strip-cwd-prefix', '--no-ignore' },
    file_ignore_patterns = { '.git', 'node_modules' },
    hidden = true
  })
end)

telescope.load_extension 'fzf'

telescope.load_extension 'file_browser'
map("n", "<space>fb", ":Telescope file_browser", { noremap = true })

telescope.load_extension 'lazy'
