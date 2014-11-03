
" vundle setup
set nocompatible
filetype off

" Color terminal problems - instead of set t_Co, make this the custom shell
" command in the terminal prefs: "env TERM=xterm-256color /bin/bash"
" set t_Co=256
let g:CSApprox_attr_map = { 'bold' : 'bold', 'italic' : '', 'sp' : '' }

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

"let Vundle manage vundle
Bundle 'gmarik/vundle'

" bundles:
" original repos on github
Bundle 'tpope/vim-fugitive'
Bundle 'int3/vim-extradite'
Bundle 'klen/python-mode'
Bundle 'godlygeek/csapprox'
Bundle 'scrooloose/syntastic'
Bundle 'scrooloose/nerdtree'
Bundle 'sjl/gundo.vim' 
Bundle 'depuracao/vim-darkdevel'
Bundle 'benmills/vimux.git'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-abolish'
Bundle 'vim-scripts/no_quarter'
Bundle 'kien/ctrlp.vim'
Bundle 'vim-scripts/DirDiff.vim'
" add [q, ]q, [Q, ]Q  for :cnext, :cprev, :cfirst, :clast
Bundle 'tpope/vim-unimpaired'
Bundle 'tikhomirov/vim-glsl'

" Notes on things to try later:
"
" TabBar is like minibufexpl, it interferes with fugitive diff
"Bundle 'vim-scripts/TabBar'
" Ok, but interrupts a bit by only showing sometimes:
"Bundle 'vim-scripts/buftabs'

" Gdiff doesn't work with minibuf
"Bundle 'fholgado/minibufexpl.vim.git'


filetype plugin indent on  " required
" end vundle

" disable pymode's error checking
let g:pymode_lint = 0
" let g:pymode_run = 0
" let g:pymode_folding = 0
let g:pymode_syntax = 1
let g:pymode_syntax_all = 1
let g:pymode_syntax_indent_errors = g:pymode_syntax_all
let g:pymode_syntax_space_errors = g:pymode_syntax_all

" syntastic
"let g:syntastic_python_checker="flake8"

" nerdtree
map <C-n> :NERDTreeToggle<CR>

" python:
autocmd BufRead *.py set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class

colors no_quarter

" Switch color schemes for comparison
let s:mycolors = ['blackdust', 'darkdevel', 'jellybeans', 'mustang', 'inkpot', 'wombat', 'darkbone', 'darktango', 'eclm_wombat', 'kib_darktango', 'mint', 'nightVision', 'settlemyer', 'slate', 'tango-desert', 'tango2', 'combat', 'zenburn']

function Rand()
    " Return a random number
    return str2nr(matchstr(reltimestr(reltime()), '\v\.@<=\d+')[1:])
endfunction

function! RandColor()
    let s:randomColorIndex = Rand() % len(s:mycolors)
    let s:currentColor = s:mycolors[s:randomColorIndex]
    echo "Colorscheme: ".s:currentColor
    :execute 'colors '.s:currentColor
endfunction

nmap <C-u> :execute RandColor()<CR>


" enter spaces when tab is pressed:
set expandtab
" do not break lines when line length increases
set textwidth=0
" user 4 spaces to represent a tab
set tabstop=8
set softtabstop=4

" number of space to use for auto indent
" you can use >> or << keys to indent current line or selection
" in normal mode.
set shiftwidth=4

" Copy indent from current line when starting a new line.
"set autoindent
" makes backspace key more powerful.
set backspace=indent,eol,start
" shows the match while typing
set incsearch
set hlsearch
" smartcase: Both case insenstive and case sensitive search .
" Add \c or \C on search line to override
"set smartcase
set ignorecase
" show line and column number
set ruler
" show some autocomplete options in status bar
set wildmenu

" automatically save and restore folds
" don't use for now
"au BufWinLeave * mkview
"au BufWinEnter * silent loadview

":set foldmethod=indent
" default fold level, all open, set it 200 or something
" to make it all closed.
set foldlevelstart=200

"Remappings
:imap jj <Esc>
map 99 :set nonumber!<CR>

"let g:miniBufExplMapWindowNavVim = 1
"let g:miniBufExplMapWindowNavArrows = 1
"let g:miniBufExplMapCTabSwitchBufs = 1
"let g:miniBufExplModSelTarget = 1

"set winminwidth=0      " Allow windows to get fully squashed
" Replace minibuf shortcuts
map <C-J> <C-W>j
map <C-K> <C-W>k
map <C-H> <C-W>h
map <C-L> <C-W>l

"Shortcut to insert set_trace()
nmap ,, oimport pdb; pdb.set_trace()<ESC>


"Git and fugitive.
map <C-G>s :Gstatus<CR>
map <C-G>c :Gcommit<CR>


let g:pydiction_location='$HOME/.vim/after/ftplugin/pydiction/complete-dict'
map T :TaskList<CR>
map P :TlistToggle<CR>

filetype on
filetype plugin on
set ofu=syntaxcomplete#Complete
autocmd FileType python set omnifunc=pythoncomplete#Complete
"set omnifunc=pythoncomplete#Complete
":syntax on

:set tags=./tags;../tags;../../tags;

" # use zm and zr to change fold level

"set nocompatible
"map :tabnew  # ctrl-t for new tab

" press F2 before and after pasting from another app
" with no feedback
set pastetoggle=<F2>

" with status feedback
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
set showmode

" use system clipboard
set clipboard+=unnamed

""" abolish plugin shortcut keys
"    crc to convert to fooBar
"    crm to convert to FooBar
"    cr_ or
"    crs to convert to foo_bar
"    cru to convert to FOO_BAR
"    cr- to convert to foo-bar

" If you prefer the Omni-Completion tip window to close when a selection is
" made, these lines close it on movement in insert mode or when leaving
" insert mode
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" fix problem with fugitive :Gdiff showing entire file as a diff
" might not be necessary with latest fugitive
autocmd BufNewFile,BufRead fugitive://* set bufhidden=delete

"Make cntrl-p not show pyc files
set wildignore+=*.pyc

"Enable spelling
set spell

" Handle .cuh files as cuda header files.
au BufNewFile,BufRead *.cuh set ft=cuda
