-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move focus to the upper window" })

-- tab stuff
vim.keymap.set("n", "<leader>tn", "<cmd>tabnew<CR>", { desc = "[T]ab [N]ew" })
vim.keymap.set("n", "<leader>tq", "<cmd>tabclose<CR>", { desc = "[T]ab Close" })
vim.keymap.set("n", "<leader>tl", "<cmd>tabnext +<CR>", { desc = "[T]ab Next" })
vim.keymap.set("n", "<leader>th", "<cmd>tabnext -<CR>", { desc = "[T]ab Previous" })
vim.keymap.set("n", "<leader>tb", "<cmd>tabnext #<CR>", { desc = "[T]ab [B]ack" })

-- -- Set <space> as the leader key
-- -- See `:help mapleader`
-- --  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
-- vim.g.mapleader = " "
-- vim.g.maplocalleader = " "
--
-- -- [[ Basic Keymaps ]]
-- --  See `:help vim.keymap.set()`
-- local map = vim.keymap.set
--
-- vim.opt.hlsearch = true -- Set highlight on search, but clear on pressing <Esc> in normal mode
--
-- -- stylua: ignore start
-- map("n", "<Esc>", "<cmd>nohlsearch<CR>") -- FIX:
--
-- map("i", "jk", "<ESC>", { desc = "Exit insert mode with jk", })
-- map("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights", })
--
-- map("n", "<leader>+", "<C-a>", { desc = "Increment number" })
-- map("n", "<leader>-", "<C-x>", { desc = "Decrement number" })
--
-- -- window management
-- -- map("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
-- -- map("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
-- -- map("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })
-- -- map("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })
--
-- map("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" })
-- map("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" })
-- map("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" })
-- map("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" })
-- -- map("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" })
--
-- -- Keybinds to make split navigation easier.
-- --  Use CTRL+<hjkl> to switch between windows
-- --  See `:help wincmd` for a list of all window commands
-- map("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
-- map("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
-- map("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
-- map("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })
--
-- -- Diagnostic keymaps
-- map("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
-- map("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
-- map("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
-- map("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })
--
-- -- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- -- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- -- is not what someone will guess without a bit more experience.
-- --
-- -- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- -- or just use <C-\><C-n> to exit terminal mode
-- map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
--
-- -- TIP: Disable arrow keys in normal mode
-- -- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- -- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- -- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- -- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')
--
-- map("", "<ScrollWheelUp>", "<C-Y>", { desc = "Scroll up one line" })
-- map("", "<ScrollWheelDown>", "<C-E>", { desc = "Scroll down one line" })
--
-- map("n", "<Esc-b>", "B", { desc = "Move cursor to the left one word" })
-- -- map("n", "<Esc-f>", "E", { desc = "Move cursor to the right one word" }) -- FIX:
-- -- vim.api.nvim_del_keymap("n", "f")
-- vim.api.nvim_set_keymap("n", "<Esc-f>", "E", { noremap = true, silent = true })
--
-- map("n", "<Esc-d>", "dd", { desc = "Delete current line" })
-- map("n", "<Esc-c>", "yy", { desc = "Copy current line" })
--
-- map("n", "<M-w>", "<cmd>bdelete<CR>", { desc = "Close current buffer" })
-- map({ "i", "x", "n", "s" }, "<D-s>", "<cmd>w<cr><esc>", { desc = "Save file" })
--
vim.keymap.set("n", "<leader>ml", "<cmd>Lazy<CR>", { desc = "Manage Lazy Config" })
