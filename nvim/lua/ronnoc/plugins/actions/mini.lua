-- https://github.com/echasnovski/mini.nvim
return {
	{
		"echasnovski/mini.nvim",
		version = "*",
		config = function()
			-- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-pairs.md
			-- Add, delete, replace, find, highlight surrounding (like pair of parenthesis, quotes, etc.).
			require("mini.pairs").setup({})

			-- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-bufremove.md
			-- Buffer removing (unshow, delete, wipeout), which saves window layout
			require("mini.bufremove").setup({})
		end,
	},
}
