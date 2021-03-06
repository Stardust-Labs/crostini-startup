## create vim settings file
cat > ~/.vimrc <<- EOM

call plug#begin('~/.vim/plugged')

Plug 'dart-lang/dart-vim-plugin'

call plug#end()

:set tabstop=4
:syntax on

autocmd Filetype dart setlocal tabstop=2
autocmd Filetype json setlocal tabstop=2

EOM

