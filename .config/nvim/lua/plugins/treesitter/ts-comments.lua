-- https://github.com/folke/ts-comments.nvim
-- Easily override the comment string for a given treesitter language
return {
	"folke/ts-comments.nvim",
	opts = {},
	event = "VeryLazy",
	enabled = vim.fn.has("nvim-0.10.0") == 1,
}
