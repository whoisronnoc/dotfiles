-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`
-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", {
		clear = true,
	}),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- vim.cmd([[2match WhiteSpaceBol /^ \+/]])
-- vim.cmd('match WhiteSpaceMol / /')
-- vim.api.nvim_set_hl(0, 'WhiteSpaceMol', {
--     fg = string.format('#%x', vim.api.nvim_get_hl(0, { name = 'Normal' }).bg)
-- })

-- vim.cmd([[2match WhiteSpaceBol /^ \+/]])
-- vim.cmd('match WhiteSpaceMol / /')
-- vim.api.nvim_set_hl(0, 'WhiteSpaceMol', {
--     fg = string.format('#%x', vim.api.nvim_get_hl(0, { name = 'Normal' }).bg)
-- })
-- vim.api.nvim_create_autocmd('ColorScheme', {
--     callback = function()
--         vim.api.nvim_set_hl(0, 'WhiteSpaceMol', {
--             fg = string.format('#%x', vim.api.nvim_get_hl(0, { name = 'Normal' }).bg)
--         })
--     end
-- })
