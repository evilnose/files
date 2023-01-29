syntax on

" Use local .vimrc
set exrc

au BufRead,BufNewFile *.py set expandtab
au BufRead,BufNewFile *.lua set expandtab tabstop=2 softtabstop=2 shiftwidth=2
au BufRead,BufNewFile *.c set expandtab tabstop=2 softtabstop=2 shiftwidth=2
au BufRead,BufNewFile *.cpp set expandtab tabstop=2 softtabstop=2 shiftwidth=2
au BufRead,BufNewFile *.cc set expandtab tabstop=2 softtabstop=2 shiftwidth=2
au BufRead,BufNewFile *.h set expandtab tabstop=2 softtabstop=2 shiftwidth=2
au BufRead,BufNewFile Makefile* set noexpandtab
au BufRead,BufNewFile *.yaml set expandtab tabstop=2 softtabstop=2 shiftwidth=2

set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set shiftwidth=4
set autoindent
filetype plugin indent on
set nosmartindent
set cindent
set backspace=indent,eol,start
set noundofile
set textwidth=120

" set number relativenumber

set wildmenu
set wildmode=longest:full,full

set ruler

set hidden

set incsearch
set hlsearch

set ignorecase
set smartcase

set showmatch

set noerrorbells
set novisualbell
set t_vb=
set tm=500

set encoding=utf-8

" In visual mode, pressing * or # searches for the current selection
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

tnoremap <C-h> <C-\><C-n>

" Faster move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

if has('unix')
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
endif
