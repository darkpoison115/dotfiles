local set = vim.opt

-- map leader
vim.g.mapleader = " "

-- Editor basics
set.hidden = true
set.termguicolors = true
set.errorbells = false
set.wrap = false
set.splitbelow = true
set.scrolloff = 8
set.mouse = 'a'

-- languages
set.spelllang = 'es'

-- search
set.incsearch = true
set.hlsearch = false
set.ignorecase = true
set.smartcase = true

-- tabs
set.tabstop = 4
set.softtabstop = 4
set.shiftwidth = 4
set.expandtab = true
set.smartindent = true

-- numbers
set.nu = true
set.relativenumber = true

-- backup
set.swapfile = false
set.backup = false
set.undofile = true
set.undodir = vim.fn.expand('~/.vim/undodir')

set.colorcolumn = '89'
