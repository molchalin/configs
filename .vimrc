"
"                    /\ \__
"   ___ ___      __  \ \ ,_\  ____      __
"  /' __` __`\  /'__`\ \ \ \/ /\_ ,`\  /'__`\
"  /\ \/\ \/\ \/\ \L\.\_\ \ \_\/_/  /_/\  __/
"  \ \_\ \_\ \_\ \__/.\_\\ \__\ /\____\ \____\
"   \/_/\/_/\/_/\/__/\/_/ \/__/ \/____/\/____/
"
" Author: matthias.vogelgesang[at]gmail[dot]com
" Blog: http://bloerg.net
"

"{{{1 Settings
"{{{ General
set nocompatible    " Disable vi compatibility
set modeline        " Enable modeline
set showmatch       " Show matching parentheses
set nocursorline    " Do not highlight cursor line
set nocursorcolumn  " Do not highlight current cursor column
set ruler           " Show cursor position
set laststatus=2    " Show status line
set noerrorbells    " No beeps
set history=1000    " Maximum history
set wildmenu        " Tab completion
set wildignore+=*/.git/*,*/.bzr/*,*~,*/build/*
set hidden          " Allow buffers to be hidden
set scrolloff=2     " At least two lines and ...
set sidescrolloff=2 " two columns context
set mouse=a         " Mouse support
set tags=tags       " Tags file
set ttyfast
set dir=~/.vim      " Location for .swp files
let mapleader = ","
"}}}
"{{{ Searching
set ignorecase      " Case insensitive search
set smartcase       " Ignore ignorecase
set hlsearch        " Show search results
set wrapscan        " Continue search at the top
set incsearch       " Incremental search
"}}}
"{{{ Textformatting, indenting, tabs
set textwidth=80    " Yay, history!
set autoindent      " ...
set smartindent     " ...
set tabstop=4       " Number of spaces per tab
set shiftwidth=4    " Default number of spaces for >> and <<
set softtabstop=4   " Number of spaces per tab
set expandtab       " Spaces instead of tabs
set smarttab        " Add/remove spaces instead of tabs
set linebreak       " Break lines nicer
set number          " Show line numbers
set listchars=tab:»\ ,trail:·,eol:¬
"}}}
"{{{ Highlighting, colors, fonts
syntax on
set t_Co=256
set background=dark

try
    colorscheme lilypink
catch /^Vim\%((\a\+)\)\=:E185/
    colorscheme desert
endtry

if has("gui_running")
    set lines=60                " More lines ...
    set columns=120             " and columns in GUI mode
    set gfn=Monospace\ 9
    set guioptions-=m
    set guioptions-=T
    set guioptions-=l
    set guioptions-=L
    set guioptions-=r
    set guioptions-=R
    set guioptions-=b
endif
"}}}
"{{{ Folding
set foldenable
set foldmethod=marker
set fillchars=fold:·
"}}}
"{{{ Omni completion
set omnifunc=syntaxcomplete#Complete
set completeopt=menu
"}}}
"}}}
"{{{1 Plugins
filetype off

set rtp+=~/.vim/bundle/vundle
call vundle#rc()

Bundle 'bling/vim-airline'
Bundle 'kien/ctrlp.vim'
Bundle 'matze/neosnippet'
Bundle 'matze/vim-markdown'
Bundle 'matze/vim-move'
Bundle 'matze/vim-tex-fold'
Bundle 'mileszs/ack.vim'
Bundle 'nvie/vim-flake8'
Bundle 'Shougo/neocomplcache'
Bundle 'spolu/dwm.vim'
Bundle 'petRUShka/vim-opencl'
Bundle 'tpope/vim-commentary'
Bundle 'tpope/vim-fugitive'

filetype on
filetype plugin on
filetype indent on

"{{{ ack.vim
let g:ackprg="ack-grep -H --nocolor --nogroup --column --ignore-dir=build"
"}}}
"{{{ NeoComplCache
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_auto_select = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_enable_camel_case_completion = 1
let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplcache_auto_completion_start_length = 3
let g:neocomplcache_manual_completion_start_length = 3
let g:neocomplcache_min_syntax_length = 3

if !exists('g:neocomplcache_keyword_patterns')
    let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)

nmap <Leader>nce :NeoComplCacheEnable<CR>
nmap <Leader>ncd :NeoComplCacheDisable<CR>
"}}}
"{{{ vim-airline
let g:airline_enable_syntastic = 0
let g:airline_powerline_fonts = 1
let g:airline_theme = 'badwolf'
let g:airline_section_x = ''
let g:airline_detect_whitespace = 0
"}}}
"{{{ ctrlp.vim
let g:ctrlp_extensions = ['buffertag', 'tag']

nnoremap <Leader>pb :CtrlPBufTag<CR>
nnoremap <Leader>pt :CtrlPTag<CR>
"}}}
"{{{ dwm.vim
let g:dwm_map_keys = 0

nmap <C-J> <C-W>w
nmap <C-K> <C-W>W
nmap <C-N> <Plug>DWMNew
nmap <C-X> <Plug>DWMClose
nmap <C-@> <Plug>DWMFocus
nmap <C-L> <Plug>DWMGrowMaster
nmap <C-H> <Plug>DWMShrinkMaster
"}}}
"{{{ vim-move
let g:move_map_keys = 0

vmap <C-j> <Plug>MoveBlockDown
vmap <C-k> <Plug>MoveBlockUp
nmap j <Plug>MoveLineDown
nmap k <Plug>MoveLineUp
"}}}
"}}}
"{{{1 Functions
function! NextClosedFold(dir)
    " Stolen from http://stackoverflow.com/a/9407015/997768
    let cmd = 'norm!z' . a:dir
    let view = winsaveview()
    let [l0, l, open] = [0, view.lnum, 1]
    while l != l0 && open
        exe cmd
        let [l0, l] = [l, line('.')]
        let open = foldclosed(l) < 0
    endwhile
    if open
        call winrestview(view)
    endif
endfunction

function TryCmakeMakeprg()
    if !filereadable('Makefile')
        if filereadable('build/Makefile')
            set makeprg=make\ -C\ ./build\ --no-print-directory
        endif
    endif
endfunction

function NicerFoldText()
    " Match everything that has the Vim marker after some character (presumably
    " the comment starter.
    let foldline = getline(v:foldstart)
    let line = substitute(foldline, '^[^{]*{' . '{{\d*\([.]*\)', '\1', '') . ' '
    return '+-' . v:folddashes . line
endfunction

set foldtext=NicerFoldText()
"}}}
"{{{1 Keymaps
"{{{ Misc
nnoremap <F5> <Esc>:w!<CR>:make!<CR><CR>
nnoremap <CR> za
nnoremap <silent> <Space> :silent noh<CR>
"}}}
"{{{ Buffer and file management
nmap <Leader>w :w!<CR>
nmap cn <Esc>:cn<CR>
nmap cp <Esc>:cp<CR>
nmap <Right> :bn<CR>
nmap <Left> :bp<CR>
nmap <Leader>cl :ccl<CR>
"}}}
"{{{ Tlist and ctags stuff
nmap <Leader>gt :!ctags -R --sort=yes --c++-kinds=+p --fields=+iaS --extra=+q --exclude=build .<CR><CR>
nmap <C-o> <C-]>
"}}}
"{{{ Basic formatting
nmap <Leader>r1 yypVr=
nmap <Leader>r2 yypVr-
nmap <Leader>fw :%s/\s\+$//<CR>
"}}}
"{{{ Spellchecking
nmap <Leader>se :setlocal spell spelllang=en_us<CR>
nmap <Leader>sd :setlocal spell spelllang=de<CR>
nmap <Leader>sn :setlocal nospell<CR>
"}}}
"{{{ Folding
nnoremap <silent> zJ :call NextClosedFold('j')<CR>
nnoremap <silent> zK :call NextClosedFold('k')<CR>
"}}}
"}}}
"{{{1 Auto commands
au BufEnter *.c     call TryCmakeMakeprg()
"}}}
