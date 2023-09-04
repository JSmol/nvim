set termguicolors
syntax enable

" python 2 space tab "
" let g:python_recommended_style = 0
filetype plugin indent on

" nice stuff "
" set wrap is default "
" set nowrap
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

" panes "
map <C-\> :vsp<CR>
map <C-k> :wincmd k<CR>
map <C-j> :wincmd j<CR>
map <C-h> :wincmd h<CR>
map <C-l> :wincmd l<CR>

set splitbelow
set splitright

" tex spell checker "
au Filetype tex set spell

" motion "
nmap s <Plug>(easymotion-s)
map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)

" These `n` & `N` mappings are options. You do not have to map `n` & `N` to EasyMotion.
" Without these mappings, `n` & `N` works fine. (These mappings just provide
" different highlight method and have some other features )
map  n <Plug>(easymotion-next)
map  N <Plug>(easymotion-prev)

