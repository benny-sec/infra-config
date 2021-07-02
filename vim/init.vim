filetype plugin indent on

set tabstop=4 # show existing tab with 4 spaces width
set shiftwidth=4 # when indenting with '>', use 4 spaces width
set expandtab # On pressing tab, insert 4 spaces
syntax on # highlight syntax
set number # show line numbers
set noswapfile # disable the swapfile
set hlsearch # highlight all results
set ignorecase # ignore case in search
set incsearch # show search results as you type

imap jj <Esc>                    # Use jj to switch to normal mode
inoremap ZZ <C-O>:x<CR>          # set ZZ to save and quit in normal mode

" set zz to save the file in both normal and insert mode
nnoremap zz :update<CR>
inoremap zz <C-O>:update<CR>

" set xxx to quit vim disregarding all changes
nnoremap xxx :q!<CR>
inoremap xxx <C-O>:q!<CR>

