-- https://github.com/echasnovski/mini.nvim
return {
	{
		"echasnovski/mini.nvim",
		event = "VeryLazy",
		version = "*",
		config = function()
			-- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-pairs.md
			-- automatically insert or delete pairs of characters (like parentheses, brackets, etc.)
			-- require("mini.pairs").setup()

			-- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-surround.md
			-- Add, delete, replace, find, highlight surrounding (like pair of parenthesis, quotes, etc.).
			require("mini.surround").setup()

			-- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-bufremove.md
			-- Buffer removing (unshow, delete, wipeout), which saves window layout
			require("mini.bufremove").setup()

			-- https://github.com/echasnovski/mini.icons
			require("mini.icons").setup()
		end,
	},
}
