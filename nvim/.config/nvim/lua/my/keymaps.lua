vim.g.mapleader = ' '

local map = vim.keymap.set

-- Use Esc as Esc in neovim terminal mode
map("t", "<Esc><Esc>", "<C-\\><C-n>")

-- Move visual block selection with <C-[jk]> in visual mode
map("v", "<C-j>", ":m '>+1<CR>gv=gv")
map("v", "<C-k>", ":m '<-2<CR>gv=gv")

-- Keep matches center screen when cycling with n|N
map('n', 'n', 'nzzzv')
map('n', 'N', 'Nzzzv')

-- Center cursor after join
map("n", "J", "mzJ`z")

-- Toggle hlsearch
map("n", "<space>th", ":set invhlsearch<CR>")
map("n", "<space>tc", ":set invignorecase<CR>")

-- Switch or create new tmux session
map("n", "<space>ts", ":silent !tmux neww tmux-sessionizer<CR>")
