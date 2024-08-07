" setup vundle"
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
" PLUGINS
Plugin 'sjl/gundo.vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'vim-airline/vim-airline'
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'
Plugin 'sheerun/vim-polyglot'
Plugin 'tpope/vim-sensible'
Plugin 'joshdick/onedark.vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
syntax enable

" color scheme
colorscheme onedark

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

" vim splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
set splitbelow
set splitright

" nerd commenter
noremap <silent> // :call NERDComment(0,"toggle")<cr>

let g:NERDSpaceDelims=1
let g:NERDCommentEmptyLines=1
let g:NERDTrimTrailingWhitespace=1

" toggle nerdtree
map <C-d> :NERDTreeToggle<CR>

" toggle gundo
nnoremap <F5> :GundoToggle<CR>

" airline
set laststatus=2
let g:airline_theme = 'onedark'
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

" fugitive
map <C-g> :Gdiff<CR>

" enable spellcheck
" set spell spelllang=en_us
" word wrap
set wrap linebreak nolist
" show line at column 80
set colorcolumn=80
" Toggle spellchecking
function! ToggleSpellCheck()
	set spell!
	if &spell
		echo "Spellcheck ON"
	else
		echo "Spellcheck OFF"
	endif
endfunction
nnoremap <silent> <Leader>s :call ToggleSpellCheck()<CR>
nnoremap <Leader>w :w<CR>
command Wq :wq
command WQ :wq
"command wQ :wq
