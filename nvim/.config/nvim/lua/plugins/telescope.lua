return {
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.1',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local telescope = require('telescope')
      local actions = require('telescope.actions')
      local builtin = require('telescope.builtin')

      telescope.setup({
        defaults = {
          -- `hidden = true` is not supported in text grep commands.
          vimgrep_arguments = {
            'rg',
            '--color=never',
            '--no-heading',
            '--with-filename',
            '--line-number',
            '--column',
            '--smart-case',
            '--hidden',
            '--glob',
            '!**/.git/*'
          },
          sorting_strategy = 'ascending',
          -- layout_strategy = 'flex',
          layout_config = {
            horizontal = {
              prompt_position = 'top',
              preview_cutoff = 1,
              preview_width = 0.6,
              width = 0.9,
            },
            vertical = {
              preview_cutoff = 1,
              preview_height = 0.6,
            },
            bottom_pane = {
              height = 0.4
            }
          },
          mappings = {
            i = {
              ['<C-j>'] = actions.cycle_history_prev,
              ['<C-k>'] = actions.cycle_history_next,
            },
          },
        },
        pickers = {
          find_files = {
            -- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
            find_command = { 'rg', '--files', '--hidden', '--glob', '!**/.git/*' },
          },
          live_grep = {
            debounce = 100,
            -- previewer = false,
          }
        },
      })

      vim.keymap.set('n', '<leader>fd', builtin.diagnostics)

      vim.keymap.set('n', '<leader>ff', builtin.find_files)
      vim.keymap.set('n', '<leader>fg', builtin.git_files)

      vim.keymap.set('n', '<leader>fs', builtin.live_grep)
      vim.keymap.set('n', '<leader>fw', function()
        builtin.grep_string({
          search = vim.fn.input('Grep > ')
        })
      end)

      vim.keymap.set('n', '<leader>fh', builtin.help_tags)
      vim.keymap.set('n', '<leader>fb', builtin.buffers)

      vim.keymap.set('n', '<leader>fo', builtin.oldfiles)
      vim.keymap.set('n', '<leader>fr', function()
        builtin.oldfiles({
          prompt_title = 'Oldfiles cwd',
          only_cwd = true
        })
      end)

      vim.keymap.set('n', '<space>ft', function()
        builtin.colorscheme({ layout_strategy = 'bottom_pane' })
      end)

      vim.keymap.set('n', '<space>fv', function()
        builtin.find_files({
          prompt_title = 'NVIMRC',
          cwd = os.getenv('HOME') .. '/.config/nvim',
        })
      end)
    end
  },

  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
    config = function()
      require('telescope').load_extension 'fzf'
    end
  },

}
