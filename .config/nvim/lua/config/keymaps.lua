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

-- Map Cmd+Left/Right for beginning/end of line
vim.keymap.set({ "n", "v" }, "<Esc>[1;5D", "^", { desc = "Move to start of line" })
vim.keymap.set({ "n", "v" }, "<Esc>[1;5C", "$", { desc = "Move to end of line" })
vim.keymap.set("i", "<Esc>[1;5D", "<C-o>^", { desc = "Move to start of line" })
vim.keymap.set("i", "<Esc>[1;5C", "<C-o>$", { desc = "Move to end of line" })

-- Map Cmd+Up/Down for top/bottom of file
vim.keymap.set({ "n", "v" }, "<Esc>[1;5A", "gg", { desc = "Move to top of file" })
vim.keymap.set({ "n", "v" }, "<Esc>[1;5B", "G", { desc = "Move to bottom of file" })
vim.keymap.set("i", "<Esc>[1;5A", "<C-o>gg", { desc = "Move to top of file" })
vim.keymap.set("i", "<Esc>[1;5B", "<C-o>G", { desc = "Move to bottom of file" })

-- Map Alt+Left/Right for word navigation (Ghostty sends esc:b and esc:f)
vim.keymap.set({ "n", "v" }, "<M-b>", "b", { desc = "Move backward by word" })
vim.keymap.set({ "n", "v" }, "<M-f>", "w", { desc = "Move forward by word" })
vim.keymap.set("i", "<M-b>", "<C-o>b", { desc = "Move backward by word" })
vim.keymap.set("i", "<M-f>", "<C-o>w", { desc = "Move forward by word" })

-- misc
vim.keymap.set("n", "<leader>ml", "<cmd>Lazy<CR>", { desc = "Manage [L]azy Config" })
