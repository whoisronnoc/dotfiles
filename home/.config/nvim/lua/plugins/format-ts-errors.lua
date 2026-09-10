return {
	"whoisronnoc/format-ts-errors.nvim",
	event = "VeryLazy",
	dev = true,
	config = function()
		require("format-ts-errors").setup({
			add_markdown = true,
			start_indent_level = 0,
		})
	end,
}
