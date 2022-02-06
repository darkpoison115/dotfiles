syntax on

let mapleader=" "

set hidden
set nohlsearch
set termguicolors
set noerrorbells
set nowrap
set incsearch
set scrolloff=8
set spelllang=es
set mouse=a
set ignorecase
set smartcase
set splitbelow

" Tabs
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set smartindent

" numbers
set nu
set relativenumber

" Backup
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile

" Maps
nnoremap <leader>ev :edit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
nnoremap <leader>sc :set spell!<cr>

" Plugins
call plug#begin('~/.vim/plugged')
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'vim-airline/vim-airline'
call plug#end()

set colorcolumn=80
highlight ColorColumn ctermbg=0 guibg=lightgrey

colorscheme dracula

augroup myAutogroup
    autocmd!
    autocmd BufWritePre * :%s/\s\+$//e " Removes trailing whitespace.
augroup END
