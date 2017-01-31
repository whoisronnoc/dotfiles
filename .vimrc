python from powerline.vim import setup as powerline_setup
python powerline_setup()
python del powerline_setup

execute pathogen#infect()

syntax on
filetype plugin indent on

set nocompatible
set shortmess=I
set laststatus=2
set number

" spacing
set backspace=2
set tabstop=4
set softtabstop=0
set expandtab
set shiftwidth=4

" enable mouse
set mouse=a

" vim column line
highlight ColorColumn ctermbg=233
" let &colorcolumn=join(range(81,999),",")

" cursor line
set cursorline
highlight CursorLine cterm=bold ctermbg=234
highlight CursorLineNr cterm=bold ctermfg=3

" highlight search
set hlsearch
highlight Search cterm=underline ctermbg=NONE
set incsearch

" gutter background colors
highlight SignColumn ctermbg=237
set fillchars+=vert:\ 

" show position in the document reg statusline
set ruler

" Vim popup for autocomplete
set omnifunc=syntaxcomplete#Complete
set completeopt=longest,menuone

" airLine configuration
set noshowmode

" setup custom symbols
let g:airline_symbols = {}

" compatible without powerline fonts
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_symbols.crypt = '🔒'
let g:airline_symbols.linenr = '␤' " Original symbol
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.maxlinenr = '☰'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.spell = 'Ꞩ'
let g:airline_symbols.notexists = '∄'
let g:airline_symbols.whitespace = 'Ξ'

" Signify signs and colors
let g:signify_sign_add = '+'
let g:signify_sign_delete = '-'
let g:signify_sign_change = '~'
let g:signify_sign_delete_first_line = g:signify_sign_delete
let g:signify_sign_changedelete = g:signify_sign_change

" Signify gutter coloring
highlight SignifySignAdd    cterm=bold ctermbg=237 ctermfg=119
highlight SignifySignDelete cterm=bold ctermbg=237 ctermfg=167
highlight SignifySignChange cterm=bold ctermbg=237 ctermfg=227

" map nerd tree
noremap <silent> <C-D> :NERDTreeToggle<cr>
let g:nerdtree_tabs_focus_on_files=1
let g:nerdtree_tabs_open_on_console_startup=1
let g:NERDSpaceDelims = 1 
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1

" color scheme
colorscheme onedark
let g:airline_theme='onedark'
