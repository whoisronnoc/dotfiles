return {
	-- { "https://github.com/kamykn/spelunker.vim" },
	--- @type LazyPluginSpec
	{
		"ravibrock/spellwarn.nvim",
		event = "VeryLazy",
		enabled = true,
		config = true,
		opts = {
			{
				event = { -- event(s) to refresh diagnostics on
					"CursorHold",
					"InsertLeave",
					"TextChanged",
					"TextChangedI",
					"TextChangedP",
				},
				enable = true, -- enable diagnostics on startup
				ft_config = { -- spellcheck method: "cursor", "iter", or boolean
					alpha = false,
					help = false,
					lazy = false,
					lspinfo = false,
					mason = false,
				},
				ft_default = true, -- default option for unspecified filetypes
				max_file_size = nil, -- maximum file size to check in lines (nil for no limit)
				severity = { -- severity for each spelling error type (false to disable diagnostics for that type)
					spellbad = "WARN",
					spellcap = "HINT",
					spelllocal = "HINT",
					spellrare = "INFO",
				},
				prefix = "possible misspelling(s): ", -- prefix for each diagnostic messagez
				diagnostic_opts = { severity_sort = true }, -- options for diagnostic display
			},
		},
	},
	{
		"psliwka/vim-dirtytalk",
		build = ":DirtytalkUpdate",
		config = function()
			vim.opt.spelllang = { "en", "programming" }
		end,
	},
}
