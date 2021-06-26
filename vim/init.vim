" Use jj to switch to normal mode
imap jj <Esc>
filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab
" set zz to save the file
nnoremap zz :update<cr>
inoremap zz :update<cr>
