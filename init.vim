" Inspiration:
" https://gist.github.com/prkstaff/a8d9ab54318e462f0321444bba472504
" https://dougblack.io/words/a-good-vimrc.html
" http://www.vim-bootstrap.com/
" Consider:
" https://github.com/bag-man/dotfiles/blob/master/vimrc
" https://github.com/adelowo/dotfiles/blob/master/nvim/init.vim
" https://github.com/Siafu/dotfiles/blob/master/.vim/_vimrc

"" Plugins {{{
call plug#begin('~/.config/nvim/plugged')

" Start
Plug 'mhinz/vim-startify'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'rking/ag.vim'

" Directory Browser
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'Xuyuanp/nerdtree-git-plugin'

" Git
Plug 'tpope/vim-fugitive'          " git wrapper
Plug 'airblade/vim-gitgutter'      " git diff in the gutter
" Plug 'mhinz/vim-signify'         " VCS diff via +-

" Status bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-scripts/grep.vim'
Plug 'vim-scripts/CSApprox'
Plug 'majutsushi/tagbar'
Plug 'avelino/vim-bootstrap-updater'

" Editing
Plug 'jiangmiao/auto-pairs'     " Insert or delete " in pairs
Plug 'tpope/vim-commentary'     " Toggle comments gc
Plug 'tpope/vim-surround'       " Change pairs of "' etc.
" Plug 'Raimondi/delimitMate'
Plug 'justinmk/vim-sneak'       " s = Sneak
" Consider: https://github.com/wellle/targets.vim
Plug 'kien/rainbow_parentheses.vim'  " better rainbow parentheses

" Formatting
Plug 'Yggdroot/indentLine'         " display indentation with thin vertical lines
" Plug 'bronson/vim-trailing-whitespace'  " Highlights trailing whitespace in red and provides :FixWhitespace to fix it
Plug 'ntpeters/vim-better-whitespace'

" Ctrl-P
Plug 'ctrlpvim/ctrlp.vim'
Plug 'FelikZ/ctrlp-py-matcher'

" Languages
Plug 'scrooloose/syntastic'   " Syntax checking
Plug 'sheerun/vim-polyglot'
" w0rp/ale Asynchronous Lint Engine
" suan/vim-instant-markdown markdown preview
Plug 'elmcast/elm-vim'
Plug 'fatih/vim-go', {'do': ':GoInstallBinaries'}
Plug 'jelera/vim-javascript-syntax'
Plug 'davidhalter/jedi-vim'
Plug 'raimon49/requirements.txt.vim', {'for': 'requirements'}

" Sessions
Plug 'xolox/vim-misc'
Plug 'xolox/vim-session'

" Text objects
" wellle/targets.vim  additional text objects
Plug 'michaeljsmith/vim-indent-object'  " indentation ai ii aI

" Color and Theme
Plug 'vim-scripts/CSApprox'             " fix gvim-only colorschemes for terminal
Plug 'dracula/vim'
Plug 'tomasr/molokai'
Plug 'tomasiser/vim-code-dark'

" Editing
" Consider: https://github.com/unblevable/quick-scope

call plug#end() " }}}

"" NERDTree configuration
let g:NERDTreeChDirMode=2
let g:NERDTreeIgnore=['\.rbc$', '\~$', '\.pyc$', '\.db$', '\.sqlite$', '__pycache__']
let g:NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$', '\.bak$', '\~$']
let g:NERDTreeShowBookmarks=1
let g:nerdtree_tabs_focus_on_files=1
let g:NERDTreeMapOpenInTabSilent = '<RightMouse>'


" session management
let g:session_directory = "~/.config/nvim/session"
let g:session_autoload = "no"
let g:session_autosave = "no"
let g:session_command_aliases = 1

" Whitespace
let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=1


"" Basic Setup {{{

"" Encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8
" set bomb
set binary

"" swp file directories
set nobackup
set noswapfile

"" Tabs and Indentation {{{
filetype indent on      " load e.g. ~/.vim/indent/python.vim indent files
set tabstop=5       " number of visual spaces per TAB
set softtabstop=0   " number of spaces in tab when editing
set shiftwidth=4
set expandtab       " tabs are spaces
set backspace=indent,eol,start
"" }}}

"" Enable hidden buffers
set hidden

"" }}}

"" Folding
set foldenable          " enable folding
set foldnestmax=10      " 10 nested fold max
set foldmethod=indent   " fold based on indent level. cf. marker, manual, expr, syntax, diff

" set modelines=1
:au FocusLost * silent! wa  " r

"" Search {{{
set hlsearch    " highlight matches
set incsearch   " search as characters are entered
set ignorecase
set smartcase
nnoremap <leader><space> :nohlsearch<CR> " turn off search highlight
"" }}}

" Start nerdtree on directory
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif

"" Visual Settings {{{

syntax on
set ruler
set number

set cursorline          " highlight current line
set lazyredraw          " redraw only when we need to
" set showmatch           " highlight matching [{()}]

"" Theme
" set t_Co=256
colorscheme molokai
" colorscheme codedark

" vim-airline
let g:airline_theme = 'codedark'
let g:airline_theme = 'powerlineish'
let g:airline#extensions#syntastic#enabled = 1
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tagbar#enabled = 1
let g:airline_skip_empty_sections = 1

" Rainbow parentheses
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces
"" }}}

let no_buffers_menu=1

"" Keymap {{{
" let mapleader=','
nmap <F8> :TagbarToggle<CR>
nnoremap <space> za
"" }}}

" augroup vimrc     " Source vim configuration upon save
"   autocmd! BufWritePost $MYVIMRC source % | echom "Reloaded " . $MYVIMRC | redraw
"   autocmd! BufWritePost $MYGVIMRC if has('gui_running') | so % | echom "Reloaded " . $MYGVIMRC | endif | redraw
" augroup END

if &filetype == "vim"
  let g:AutoPairs = {'(':')', '[':']', "'":"'", '':'', '<':'>'}
  set foldmethod=marker
endif

augroup filetype_vim
    autocmd!
    autocmd BufWrite * :echom "Cats"
    autocmd FileType let g:AutoPairs = {'(':')', '[':']', "'":"'", '':'', '<':'>'}
augroup END
