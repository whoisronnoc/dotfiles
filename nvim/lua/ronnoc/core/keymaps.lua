-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`
local keymap = vim.keymap -- for conciseness

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

keymap.set("i", "jk", "<ESC>", {
	desc = "Exit insert mode with jk",
})
keymap.set("n", "<leader>nh", ":nohl<CR>", {
	desc = "Clear search highlights",
})

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", {
	desc = "Increment number",
}) -- increment
keymap.set("n", "<leader>-", "<C-x>", {
	desc = "Decrement number",
}) -- decrement

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", {
	desc = "Split window vertically",
}) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", {
	desc = "Split window horizontally",
}) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", {
	desc = "Make splits equal size",
}) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", {
	desc = "Close current split",
}) -- close current split window

keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", {
	desc = "Open new tab",
}) -- open new tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", {
	desc = "Close current tab",
}) -- close current tab
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", {
	desc = "Go to next tab",
}) --  go to next tab
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", {
	desc = "Go to previous tab",
}) --  go to previous tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", {
	desc = "Open current buffer in new tab",
}) --  move current buffer to new tab

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--  See `:help wincmd` for a list of all window commands
keymap.set("n", "<C-h>", "<C-w><C-h>", {
	desc = "Move focus to the left window",
})
keymap.set("n", "<C-l>", "<C-w><C-l>", {
	desc = "Move focus to the right window",
})
keymap.set("n", "<C-j>", "<C-w><C-j>", {
	desc = "Move focus to the lower window",
})
keymap.set("n", "<C-k>", "<C-w><C-k>", {
	desc = "Move focus to the upper window",
})

-- Diagnostic keymaps
keymap.set("n", "[d", vim.diagnostic.goto_prev, {
	desc = "Go to previous [D]iagnostic message",
})
keymap.set("n", "]d", vim.diagnostic.goto_next, {
	desc = "Go to next [D]iagnostic message",
})
keymap.set("n", "<leader>e", vim.diagnostic.open_float, {
	desc = "Show diagnostic [E]rror messages",
})
keymap.set("n", "<leader>q", vim.diagnostic.setloclist, {
	desc = "Open diagnostic [Q]uickfix list",
})

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", {
	desc = "Exit terminal mode",
})

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

keymap.set("", "<ScrollWheelUp>", "<C-Y>", { desc = "Scroll up one line" })
keymap.set("", "<ScrollWheelDown>", "<C-E>", { desc = "Scroll down one line" })

keymap.set("n", "<leader>wt", function()
	if vim.opt.wrap:get() then
		vim.cmd("set nowrap")
	else
		vim.cmd("set wrap")
	end
end, { desc = "[w]rap [t]ext" })

-- map left-alt plus left arrow to 'h'
keymap.set("n", "<Esc-b>", "B", { desc = "Move cursor to the left one word" })
keymap.set("n", "<Esc-f>", "E", { desc = "Move cursor to the right one word" })

keymap.set("n", "<D-x>", "dd<CR>", { desc = "Delete current line" })
keymap.set("n", "<D-c>", "yy<CR>", { desc = "Copy current line" })

keymap.set("n", "<M-w>", "<cmd>bdelete<CR>", { desc = "Close current buffer" })
