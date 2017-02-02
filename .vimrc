" setup pathogen
execute pathogen#infect()

filetype plugin indent on
syntax enable

" colorscheme
set background=dark
let g:solarized_termcolors=256
colorscheme solarized

" spaces and tabs
set backspace=indent,eol,start " working backspace functionality
set tabstop=2 " number of visual spaces per TAB

" ui config
set mouse=a " enable mouse
set lazyredraw " redraw only when needed
set number " show line numbers
set cursorline " highlight current line
set showmatch " highlight matching [{()}]
set wildmenu " visual autocomplete for command menu

" searching
set incsearch " search as characters are entered
set hlsearch " highlight matches
" turn off search highlight
nnoremap <leader><space> :nohlsearch<CR>

" folding
set foldenable " enable folding
" space open/closes folds
nnoremap <space> za
set foldmethod=indent   " fold based on indent level

" movement
" move vertically by visual line
nnoremap j gj
nnoremap k gk
" move to beginning/end of line
nnoremap B ^
nnoremap E $
" $/^ doesn't do anything
nnoremap $ <nop>
nnoremap ^ <nop>
" highlight last inserted text
nnoremap gV `[v`]

let mapleader="," " leader is comma
" jk is escape
inoremap jk <esc>

" toggle nerdtree
map <C-d> :NERDTreeToggle<CR>

" toggle gundo
nnoremap <F5> :GundoToggle<CR>
