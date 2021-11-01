source ~/.vimrc
set nocompatible              
filetype off
filetype plugin indent on

set laststatus=2
set number
set rnu
set backspace=indent,eol,start
set list
set listchars=tab:>-
set ignorecase
set wildignore+=**/node_modules/**
set expandtab
set shiftwidth=2 " governs identation via >> and friends
set tabstop=4 " governs tab 
set scrolloff=8

"nvim specific
set runtimepath^=~/.vim runtimepath+=~/.vim/after

let g:auto_save = 1
let g:ctrlp_reuse_window  = 'startify'
let g:ctrlp_split_window = 0
let g:ale_sign_column_always = 1
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
let mapleader = "\<Space>"

" nvim specific
let &packpath = &runtimepath

colorscheme apprentice

"   fuzzy finder
set rtp+=/usr/local/opt/fzf

" fzf remaps
nnoremap <Leader>a :Ag <C-R><C-W><CR>:cw<CR>
nmap <Leader>f :Files<cr>|     " fuzzy find files in the working directory (where you launched Vim from)
nmap <Leader><Space> :BLines<cr>|    " fuzzy find lines in the current file
nmap <Leader>r :Ag |           " fuzzy find text in the working directory
nmap <Leader>c :Commands<cr>|  " fuzzy find Vim commands (like Ctrl-Shift-P in Sublime/Atom/VSC)

" custom remaps
nnoremap <Leader>pv :Vex<CR>
nnoremap <Leader>b <C-^><CR>
  " paste without losing the clipboards content
vnoremap <Leader>p "_dP
   " copy to the system clipboard
vnoremap <Leader>y "*y 
nnoremap <Leader>y "*y
  " yank the entire file
nnoremap <Leader>Y ggyG

vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv


" closing tags
inoremap " ""<left>
inoremap ' ''<left>
inoremap [ []<left>
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O

"   prettier format on save
let g:prettier#autoformat = 1
autocmd BufWritePre *.js,*.json,*.css,*.scss,*.less,*.graphql,*.ts,*.tsx PrettierAsync
autocmd BufRead,BufNewFile *.vue setlocal filetype=vue.html.javascript.css

"   set the defaults
runtime! plugin/sensible.vim

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

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
Plugin 'neovim/nvim-lspconfig'

call vundle#end()            

" language server
lua << EOF
require'lspconfig'.tsserver.setup{}
local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'tsserver' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end
EOF
