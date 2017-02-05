" setup pathogen
execute pathogen#infect()

filetype plugin indent on
syntax enable

" color scheme
set background=dark
let g:solarized_termcolors=256
colorscheme solarized

" spaces and tabs
set tabstop=2 " number of visual spaces per TAB
set shiftwidth=2 " how many columns text is indented with the reindent operations

" ui config
set mouse=a " enable mouse
set lazyredraw " redraw only when needed
set number " show line numbers
set cursorline " highlight current line
set showmatch " highlight matching [{()}]
set wildmenu " visual auto complete for command menu

" searching
set incsearch " search as characters are entered
set hlsearch " highlight matches
" turn off search highlight
nnoremap <leader><space> :nohlsearch<CR>

" folding
set foldenable " enable folding
" space open/closes folds
nnoremap <space> za

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

" airline
set laststatus=2
let g:airline_theme = 'dark'
let g:airline_powerline_fonts = 1
let g:airline_left_sep = ''
let g:airline_right_sep = ''

" syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
