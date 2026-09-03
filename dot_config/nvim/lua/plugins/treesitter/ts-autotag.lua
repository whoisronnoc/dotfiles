-- https://github.com/windwp/nvim-ts-autotag
-- Use treesitter to autoclose and autorename html tag
return {
	"windwp/nvim-ts-autotag",
	lazy = true,
	event = { "BufReadPre", "BufNewFile" },
	opts = {},
}
