-- Use Esc as Esc in neovim terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>")

-- Move visual block selection with <C-[jk]> in visual mode
vim.keymap.set("v", "<C-j>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<C-k>", ":m '<-2<CR>gv=gv")

-- Keep matches center screen when cycling with n|N
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

-- Center cursor after join
vim.keymap.set("n", "J", "mzJ`z")

-- Toggle hlsearch
vim.keymap.set("n", "<space>th", ":set invhlsearch<CR>")
vim.keymap.set("n", "<space>tc", ":set invignorecase<CR>")

-- Switch or create new tmux session
vim.keymap.set("n", "<space>ts", ":silent !tmux neww tmux-sessionizer<CR>")
