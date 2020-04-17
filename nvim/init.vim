set number
set nowrap

set laststatus=0

hi VertSplit cterm=NONE ctermbg=NONE
hi LineNr ctermfg=8
hi LineNr ctermbg=NONE

hi CursorLine term=NONE cterm=bold "ctermbg=8
hi EndOfBuffer term=NONE cterm=NONE ctermfg=8 ctermbg=NONE

set fcs+=eob:\ 
set fillchars+=vert:\ 

set mouse=a

set nobackup

set tabstop=4
set shiftwidth=4
set expandtab

let g:netrw_liststyle = 3
let g:netrw_banner = 0
let g:netrw_browse_split = 4
let g:netrw_winsize = 25
let g:netrw_altv = 1
augroup ProjectDrawer
	autocmd!
	autocmd VimEnter * :Vexplore
augroup END
