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

" Set system specific font/color enables
if has('mac')

    set gfn=Liberation\ Mono:h13

elseif has('win32') || has('win64')

    set gfn=Liberation\ Mono:h10

elseif has('unix')

    " this turns on 24bit color for terminal, does not work on Mac
    set termguicolors
    set gfn=Liberation\ Mono\ 11

endif

" Set system specific paths
if has('unix')
    let s:cache_dir = "$HOME/.cache/vim"
elseif has('win32') || has('win64')
    if has('nvim')
        let s:cache_dir = "%HOMEPATH%/AppData/Local/share/nvim"
    else
        let s:cache_dir = "%HOMEPATH%/vimfiles"
    endif
endif
let s:cache_dir = expand(s:cache_dir)

" store all the .swp files in one place
let s:swap_dir = s:cache_dir . "/swap"
if !isdirectory(s:swap_dir)
    call mkdir(s:swap_dir, 'p')
endif
execute "set dir=" . s:swap_dir

" store all the backup files in one place
let s:backup_dir = s:cache_dir . "/bkup"
if !isdirectory(s:backup_dir)
    call mkdir(s:backup_dir, 'p')
endif
execute "set bdir=" . s:backup_dir

" store all the undo files in one place
let s:undo_dir = s:cache_dir . "/undo"
if !isdirectory(s:undo_dir)
    call mkdir(s:undo_dir, 'p')
endif
execute "set udir=" . s:undo_dir

" set locations where to find tags
let s:tag_dirs = "./tags,tags," . s:cache_dir . "/tags"
execute "set tags=" . s:tag_dirs


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
