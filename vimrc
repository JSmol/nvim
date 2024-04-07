set termguicolors
syntax enable

nnoremap <space> <Nop>
let mapleader=' '

set clipboard+=unnamedplus

" in your .vimrc (_vimrc for Windows)
autocmd! BufNewFile,BufRead *.vs,*.fs set ft=glsl

" python 2 space tab "
" let g:python_recommended_style = 0
filetype plugin indent on

" nice stuff "
set nowrap
set hidden
set nobackup
set nowritebackup
set smarttab
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set number relativenumber
set ai
set si

set fdm=indent
set fdo-=block
set foldlevel=99

set inccommand=nosplit

" fix shift O lag on some systems "
set timeout timeoutlen=5000 ttimeoutlen=100

let g:netrw_banner = 0        " no banner
let g:netrw_liststyle = 3     " tree style listing
let g:netrw_dirhistmax = 0    " no netrw history

set splitbelow
set splitright

