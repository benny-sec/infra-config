" highlight syntax
syntax on 
" show line numbers
set number  
" disable the swapfile
set noswapfile
" highlight all results
set hlsearch
" ignore case in search
set ignorecase
" show search results as you type
set incsearch
filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab

let mapleader=","

" Use jj to switch to normal mode
imap jj <Esc>
" set zz to save the file in both normal and insert mode
nnoremap zz :update<CR>
inoremap zz <C-O>:update<CR>
" set ZZ to save and quit in normal mode
inoremap ZZ <C-O>:x<CR>
" set xxx to quit vim disregarding all changes
nnoremap xxx :q!<CR>
inoremap xxx <C-O>:q!<CR>

" fzf find files 
nnoremap <Leader>f :Files<CR>

" install plugins using vim-plug, this is to be replaced with default plugin manager in neovim
" we also have fzf installed in ~/.fzf, so this should ideally be Plug '~/.fzf' 
call plug#begin('~/.config/plugged')
      Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
      Plug 'junegunn/fzf.vim'
call plug#end()
