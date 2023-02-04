vim.opt.number = true
-- vim.opt.relativenumber = true

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.shiftround = true
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.autowrite = true
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.backup = true
vim.opt.backupdir:remove { '.' }

vim.opt.mouse = 'a'

vim.opt.wrap = false
vim.opt.sidescrolloff = 5
vim.opt.scrolloff = 10

vim.opt.showmatch = true
vim.opt.colorcolumn = '80'
vim.opt.signcolumn = 'yes'

vim.opt.shortmess:remove { 'F' }
vim.opt.shortmess:append { c = true }

vim.opt.wildignore:append { '.git', '*/node_modules/*', '*/target/*' }
vim.opt.wildignorecase = true

vim.opt.updatetime = 100
vim.opt.timeoutlen = 600
-- vim.opt.lazyredraw = true

vim.opt.clipboard:prepend { 'unnamed', 'unnamedplus' }

vim.opt.termguicolors = true

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.cursorline = true

-- pseudo transparency for floating window
vim.opt.winblend = 5

-- pseudo transparency for completion menu
vim.opt.pumblend = 10

-- https://github.com/neovim/neovim/pull/16251
vim.opt.cmdheight = 0

-- https://github.com/neovim/neovim/pull/17266
vim.opt.laststatus = 3

vim.g.loaded_python_provider  = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider    = 0
vim.g.loaded_perl_provider    = 0
vim.g.loaded_node_provider    = 0

if vim.loop.os_uname().sysname == 'Darwin' then
  vim.g.python3_host_prog = '/usr/local/bin/python3'
else
  vim.g.python3_host_prog = '/usr/bin/python3'
end

if vim.fn.executable('rg') == 1 then
  vim.opt.grepprg = 'rg --vimgrep --no-heading --smart-case --hidden'
  vim.opt.grepformat = '%f:%l:%c:%m'
end
