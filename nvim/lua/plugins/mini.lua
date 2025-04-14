-- https://github.com/echasnovski/mini.nvim
return {
	{
		"echasnovski/mini.nvim",
		event = "VeryLazy",
		version = "*",
		config = function()
			-- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-pairs.md
			-- automatically insert or delete pairs of characters (like parentheses, brackets, etc.)
			require("mini.pairs").setup({})

			-- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-surround.md
			-- Add, delete, replace, find, highlight surrounding (like pair of parenthesis, quotes, etc.).
			require("mini.surround").setup({})

			-- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-bufremove.md
			-- Buffer removing (unshow, delete, wipeout), which saves window layout
			require("mini.bufremove").setup({})

			require("mini.icons").setup({
				-- No need to copy this inside `setup()`. Will be used automatically.
				{
					-- Icon style: 'glyph' or 'ascii'
					style = "glyph",

					-- Customize per category. See `:h MiniIcons.config` for details.
					default = {},
					directory = {},
					extension = {},
					file = {},
					filetype = {},
					lsp = {},
					os = {},

					-- Control which extensions will be considered during "file" resolution
					use_file_extension = function(ext, file)
						return true
					end,
				},
			})
		end,
	},
}
