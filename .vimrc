colorscheme default
syntax on

set mouse=a

set ai

set nowrap

set clipboard=unnamedplus

vnoremap <C-c> "+y
map <C-c> "+p

if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif
