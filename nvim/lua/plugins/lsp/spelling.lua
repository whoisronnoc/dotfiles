return {
	-- { "https://github.com/kamykn/spelunker.vim" },
	--- @type LazyPluginSpec
	{
		"ravibrock/spellwarn.nvim",
		event = "VeryLazy",
		enabled = false,
		config = function()
			require("spellwarn").setup({
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
					spellbad = "HINT",
					spellcap = "HINT",
					spelllocal = "HINT",
					spellrare = "HINT",
				},
				prefix = "spellwarn: ", -- prefix for each diagnostic message
				diagnostic_opts = { severity_sort = true }, -- options for diagnostic display
			})

			-- misspelledd wordz
		end,
	},

	{
		"psliwka/vim-dirtytalk",
		enabled = false,
		build = ":DirtytalkUpdate",
		config = function()
			vim.opt.spelllang = "en,programming"
			vim.opt.spelloptions = "noplainbuffer,camel"
		end,
	},
	{
		"nvimtools/none-ls.nvim",
		enabled = true,
		event = "VeryLazy",
		dependencies = {
			"davidmh/cspell.nvim",
		},
		opts = function(_, opts)
			-- https://github.com/streetsidesoftware/cspell-dicts
			local cspell = require("cspell")

			-- opts.sources = opts.sources or {}
			-- table.insert(
			-- 	opts.sources,
			-- 	cspell.diagnostics.with({
			-- 		diagnostics_postprocess = function(diagnostic)
			-- 			diagnostic.severity = vim.diagnostic.severity.HINT
			-- 		end,
			-- 	})
			-- )
			-- table.insert(opts.sources, cspell.code_actions)

			require("null-ls").setup({
				sources = {
					cspell.diagnostics.with({
						diagnostics_postprocess = function(diagnostic)
							diagnostic.severity = vim.diagnostic.severity.HINT
						end,
					}),
					cspell.code_actions,
				},
			})
		end,
	},
}
