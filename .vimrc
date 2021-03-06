set nocompatible              
filetype off

set laststatus=2
set number
set backspace=indent,eol,start
set list
set listchars=tab:>-
set ignorecase
set wildignore+=**/node_modules/**
set noexpandtab shiftwidth=4 tabstop=4

let g:auto_save = 1
let g:ctrlp_reuse_window  = 'startify'
let g:ctrlp_split_window = 0
let g:ale_sign_column_always = 1

let mapleader = "\<Space>"

"   fuzzy finder
set rtp+=/usr/local/opt/fzf
nnoremap <Leader>a :Ag <C-R><C-W><CR>:cw<CR>
nmap <Leader>f :Files<cr>|     " fuzzy find files in the working directory (where you launched Vim from)
nmap <Leader><Space> :BLines<cr>|    " fuzzy find lines in the current file
nmap <Leader>r :Ag |           " fuzzy find text in the working directory
nmap <Leader>c :Commands<cr>|  " fuzzy find Vim commands (like Ctrl-Shift-P in Sublime/Atom/VSC)

"   prettier format on save
let g:prettier#autoformat = 0
autocmd BufWritePre *.js,*.json,*.css,*.scss,*.less,*.graphql,*.ts,*.tsx PrettierAsync

runtime! plugin/sensible.vim

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
autocmd BufRead,BufNewFile *.vue setlocal filetype=vue.html.javascript.css

Plugin 'VundleVim/Vundle.vim'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'tpope/vim-fugitive'
Plugin 'sheerun/vim-polyglot'
Plugin 'w0rp/ale'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'tpope/vim-sensible'
Plugin 'mitermayer/vim-prettier'
Plugin 'jparise/vim-graphql'
Plugin 'junegunn/fzf.vim'

call vundle#end()            
filetype plugin indent on

colorscheme apprentice
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

