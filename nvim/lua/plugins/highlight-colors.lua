-- https://github.com/brenoprata10/nvim-highlight-colors
-- block highlights text detected as colors e.g. #ffffff
return {
	"brenoprata10/nvim-highlight-colors",
	event = "VeryLazy",
	config = function()
		require("nvim-highlight-colors").setup({})
	end,
}
