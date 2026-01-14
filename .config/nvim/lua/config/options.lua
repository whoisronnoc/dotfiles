-- [[ Setting options ]]
-- See `:help vim.opt`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- sets the listing style to a tree view, which displays files and directories in a hierarchical tree format.
vim.cmd("let g:netrw_liststyle = 3")
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1

-- Make line numbers default
vim.opt.number = true
vim.opt.relativenumber = false

-- disable text wrapping by default
vim.opt.wrap = false
vim.opt.conceallevel = 0

-- Keep signcolumn on by default
vim.opt.signcolumn = "yes"
vim.opt.colorcolumn = "80,120"

-- turn on termguicolors for tokyonight colorscheme to work
-- (have to use iterm2 or any other true color terminal)
vim.opt.termguicolors = true
vim.opt.background = "dark" -- colorschemes that can be light or dark will be made dark

-- backspace
vim.opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = {
	tab = "» ",
	trail = "·",
	nbsp = "␣",
	space = "·",
}

vim.opt.fillchars = {
	-- eob = " ", -- suppress ~ at EndOfBuffer
	-- horiz = "─",
	-- horizup = "╥",
	-- horizdown = "╨",
	vert = "│",
	-- verthoriz = "┼",
	-- fold = " ",
	-- foldopen = "",
	-- foldclose = "",
}

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = "a"
vim.opt.mousescroll = "ver:3,hor:0"

-- Minimal number of screen lines to keep above and below the cursor.
-- vim.opt.scrolloff = 10
-- Change the mouse scroll speed to enable smooth scrolling
-- vim.opt.mousescroll = "ver:1,hor:1"

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
	vim.opt.clipboard = "unnamedplus"
end)

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true
-- If this many milliseconds nothing is typed the swap file will be
-- written to disk (see |crash-recovery|). Also used for the
-- |CursorHold| autocommand event.
vim.opt.updatetime = 250

-- Disable swapfile for JamfProtect cause it causes lag cause we cannot handle
-- file events. So no recovery and no quick switching. Also no multiple
-- instances in the same file otherwise you are going to have a bad time.
if vim.fn.executable("protectctl") == 1 or vim.uv.fs_stat("/Applications/JamfProtect.app/") then
	vim.opt.swapfile = false
	-- Characters typed to schedule a swap file write
	-- 0 will disable the swap file feature even if the other flag is flipped
	vim.opt.updatecount = 0
end

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300
-- vim.opt.timeoutlen = 1000

-- No timeout for easymotion
-- vim.opt.timeout = false

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Spacing, tabs & indentation
vim.opt.smarttab = true -- make tab insert indents in leading whitespace
vim.opt.tabstop = 2 -- number of spaces that a <Tab> in the file counts for
vim.opt.softtabstop = 2 -- number of spaces that a <Tab> key in the file counts for
vim.opt.shiftwidth = 2 -- number of spaces to use for each step of (auto)indent
vim.opt.expandtab = true -- expand tab to spaces
vim.opt.autoindent = true -- copy indent from current line when starting new one
vim.opt.encoding = "utf-8"

-- Disable builtin spellcheck (using harper or cspell)
vim.opt.spell = false
vim.opt.spelllang = "en_us"

-- Allow setting the title
vim.opt.title = true
vim.opt.titlelen = 12
vim.opt.titlestring = [[%f]]
