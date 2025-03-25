-- [[ Setting options ]]
-- See `:help vim.opt`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`
local opt = vim.opt -- for conciseness

-- sets the listing style to a tree view, which displays files and directories in a hierarchical tree format.
vim.cmd("let g:netrw_liststyle = 3")
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- Make line numbers default
opt.number = true
-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
-- opt.relativenumber = false
opt.signcolumn = "yes"
opt.colorcolumn = "80,120"

-- turn on termguicolors for tokyonight colorscheme to work
-- (have to use iterm2 or any other true color terminal)
opt.termguicolors = true
opt.background = "dark" -- colorschemes that can be light or dark will be made dark

-- backspace
opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position

-- turn off swapfile
opt.swapfile = false

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
opt.list = true
opt.listchars = {
	tab = "» ",
	trail = "·",
	nbsp = "␣",
	space = "·",
}

-- Enable mouse mode, can be useful for resizing splits for example!
opt.mouse = "a"

-- Don't show the mode, since it's already in the status line
opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
opt.clipboard = "unnamedplus"

-- Enable break indent
opt.breakindent = true

-- Save undo history
opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
opt.ignorecase = true
opt.smartcase = true

-- Keep signcolumn on by default so that text doesn't shift
opt.signcolumn = "yes"

-- Decrease update time
opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
opt.timeoutlen = 300

-- Configure how new splits should be opened
opt.splitright = true
opt.splitbelow = true

-- Preview substitutions live, as you type!
opt.inccommand = "split"

-- Show which line your cursor is on
opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
-- opt.scrolloff = 10

-- tabs & indentation
opt.smarttab = true -- make tab insert indents in leading whitespace
opt.tabstop = 2 -- number of spaces that a <Tab> in the file counts for
opt.softtabstop = 2 -- number of spaces that a <Tab> key in the file counts for
opt.shiftwidth = 2 -- number of spaces to use for each step of (auto)indent
opt.expandtab = true -- expand tab to spaces
opt.autoindent = true -- copy indent from current line when starting new one
opt.encoding = "utf-8"

opt.wrap = false -- wrap lines

opt.conceallevel = 1 -- Concealed text is shown with a placeholder character.

opt.title = true
opt.titlestring = [[%f]]
