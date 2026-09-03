-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "markdown", "codecompanion", "Avante" },
	callback = function()
		vim.opt_local.conceallevel = 2
	end,
	desc = "Set conceallevel for markdown files",
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "gitcommit" },
	callback = function()
		vim.cmd("normal! $")
		-- vim.cmd("startinsert")
	end,
	desc = "Move cursor to end of git commit message prefix",
})
