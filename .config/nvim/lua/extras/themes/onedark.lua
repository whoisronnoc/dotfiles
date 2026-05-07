return {
	"navarasu/onedark.nvim",
	config = function()
		require("onedark").setup({
			-- style can be one of "dark", "darker", "cool", "deep", "warm", "warmer"
			style = vim.g.theme_onedark_style or "dark",
			-- colors = {
			-- 	red = "#A5131E",
			-- },
			-- highlights = {
			-- 	Identifier = { fg = "$red" },
			-- },
		})
		require("onedark").load()
	end,
}
