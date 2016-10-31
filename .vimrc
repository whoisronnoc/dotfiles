" Doesn't need to be Vi compatible the improved part of Vim
set nocompatible

" Remove splash
" set shortmess=I

" Enable everything
execute pathogen#infect()
filetype plugin indent on

" give support for 256bit coloring
set t_Co=256
set background=light

" This is for the CursorShape changin in modes in iTerm
" This also has the workaround for runnning in a tmux session
" if exists('$TMUX')
    " let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<ESC>\\"
    " let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<ESC>\\"
" else
    " let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    " let &t_EI = "\<Esc>]50;CursorShape=0\x7"
" end


" Syntax coloring
syntax on

" Always show the statusline
set laststatus=2

" Show line numbers
set number

" Spacing
set backspace=2
set tabstop=4
set softtabstop=0
set expandtab
set shiftwidth=4

" Enable mouse suppourt
set mouse=a
" Mouse fix for tmux
if has("mouse_sgr")
    set ttymouse=sgr
else
    set ttymouse=xterm2
end
" Smooth scroll
nnoremap <ScrollWheelUp> <C-Y>
nnoremap <ScrollWheelDown> <C-E>

" Arrow don't skip lines
nnoremap <Up> gk
nnoremap <Down> gj

" Use system clipboard
if !exists('$TMUX')
    set clipboard=unnamed "unnamedplus
endif

" Vim column line
" highlight ColorColumn ctermbg=233
" let &colorcolumn=join(range(81,999),",")

" cursor line
set cursorline
highlight CursorLine cterm=bold ctermbg=234
highlight CursorLineNr cterm=bold ctermfg=3
set scrolloff=2

" Highlight search
set hlsearch
highlight Search cterm=underline ctermbg=NONE
set incsearch

" gutter backgroung colors
highlight SignColumn ctermbg=237
set fillchars+=vert:\ 

" show position in the document reg statusline
set ruler

" Vim popup for autocomplete
set omnifunc=syntaxcomplete#Complete
set completeopt=longest,menuone

" AirLine configuration
" set noshowmode
" let g:airline_theme='dark'
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

" Maps nerd tree for easy access
inoremap <silent> <C-\> <C-o>:NERDTreeToggle<cr>
noremap <silent> <C-\> :NERDTreeToggle<cr>
let g:nerdtree_tabs_focus_on_files=1
let g:nerdtree_tabs_open_on_console_startup=1

noremap <silent> // :call NERDComment(0,"toggle")<cr>
let g:NERDSpaceDelims = 1 
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1

" Synastic java fix
let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['java'] }
" Syntastic Basic setup removing the list
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_aggregate_errors = 1

"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif

syntax on
colorscheme onedark
let g:airline_theme='onedark'

nmap <silent> <C-D> :NERDTreeToggle<CR>
