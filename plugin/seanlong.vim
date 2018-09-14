" My standard vim configuration

set nocompatible
set modeline
filetype plugin indent on

" use 256 terminal colors for full glory
set t_Co=256
" use custom color scheme
color seanlong

" don't treat 007 as octal when using <C-a> and <C-x>
set nrformats=
" fixes garbage display issue with airline and xterm
set t_RV=
" keep 200 lines of command line history
set history=200
" show the cursor position all the time
set ruler
" display incomplete commands
set showcmd
" do incremental searching
set incsearch
" turn on line numbering
set number 
set smarttab
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
" allow backspacing over everything in insert mode
set backspace=indent,eol,start
" default to unix file format
set ff=unix

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
    syntax on
    set hlsearch
endif

" Set system spacific settings
if has('mac')

    set gfn=Liberation\ Mono:h13

    " store all the .swp files in one place
    set dir=~/.vim/swap

    " set where to find tags
    " dir of current file, current dir, home/.vim/tags
    set tags=./tags,tags,~/.vim/tags

elseif has('win32') || has('win64')

    set gfn=Liberation_Mono:h10

    " store all the .swp files in one place
    set dir=~/vimfiles/swap

    " set where to find tags
    " dir of current file, current dir, home/vimfiles/tags
    set tags=./tags,tags,~/vimfiles/tags

elseif has('unix')

    set gfn=Liberation\ Mono\ 11

    " store all the .swp files in one place
    set dir=~/.vim/swap

    " set where to find tags
    " dir of current file, current dir, home/.vim/tags
    set tags=./tags,tags,~/.vim/tags

endif

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
    set mouse=a
endif

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
    command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis
endif

let g:netrw_banner=1
let g:netrw_liststyle=3
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'
"
" Make tab complete more like a shell
set wildmode=list:longest,list:full

" This will show a vertical line at column x while in insert mode
highlight ColorColumn ctermbg=5
highlight ColorColumn guibg=DarkMagenta
augroup ColorcolumnOnlyInInsertMode
autocmd!
autocmd InsertEnter * setlocal colorcolumn=120
autocmd InsertLeave * setlocal colorcolumn=0
augroup END

" have this to clear previous search highlighing
nnoremap <leader><space> :noh<cr>

" map <Leader>p or and <Leader>y to copy & paste to system clipboard
vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P

" Map keys to easily move between windows without using arrow keys
nmap <silent> <C-h> :wincmd h<CR>
nmap <silent> <C-j> :wincmd j<CR>
nmap <silent> <C-k> :wincmd k<CR>
nmap <silent> <C-l> :wincmd l<CR>

" Remap F1 to esc for times when miss hitting esc, can use :h for help
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

" Make it easy to open the vimrc for editing & sourcing
nnoremap <Leader>ev :vsplit $MYVIMRC<CR>
nnoremap <Leader>sv :source $MYVIMRC<CR>
