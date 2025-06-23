-- https://github.com/nvim-treesitter/nvim-treesitter
-- syntax highlighting
return {
	{
		"nvim-treesitter/nvim-treesitter",
		event = "VeryLazy",
		build = ":TSUpdate",
		main = "nvim-treesitter.configs",
		opts = {
			ensure_installed = require("plugins.lsp.config._treesitter_langs"),

			-- Autoinstall languages that are not installed
			auto_install = true,
			highlight = {
				enable = true,
				-- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
				--  If you are experiencing weird indenting issues, add the language to
				--  the list of additional_vim_regex_highlighting and disabled languages for indent.
				additional_vim_regex_highlighting = { "ruby" },
			},

			playground = {
				enable = true,
				disable = {},
				updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
				persist_queries = false, -- Whether the query persists across vim sessions
			},

			indent = {
				enable = true,
				disable = { "ruby" },
			},
		},
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		event = "VeryLazy",
		dependencies = "nvim-treesitter/nvim-treesitter",
		config = function()
			require("treesitter-context").setup({
				-- enable = true, -- Enable this plugin (can be toggled with `:TSContextToggle`)
				-- max_lines = 0, -- How many lines the window should span (0 means no limit)
				-- min_window_height = 0, -- Minimum editor window height to enable context
				-- line_numbers = true, -- Show line numbers in context window
				-- multiline_threshold = 20, -- Maximum number of lines to show for a single context
				-- trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded
				-- mode = "cursor", -- Line used to calculate context (choices: 'cursor', 'topline')
				-- -- Separator between context and content (default: "‾")
				-- separator = nil,
				-- -- Patterns to exclude certain contexts
				-- zindex = 20, -- The Z-index of the context window
			})

			-- Optional: add keymaps for navigating contexts
			vim.keymap.set("n", "[c", function()
				require("treesitter-context").go_to_context()
			end, { silent = true, desc = "Go to context" })
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		event = "VeryLazy",
		lazy = true,
		config = function()
			-- When in diff mode, we want to use the default
			-- vim text objects c & C instead of the treesitter ones.
			local move = require("nvim-treesitter.textobjects.move") ---@type table<string,fun(...)>
			local configs = require("nvim-treesitter.configs")
			for name, fn in pairs(move) do
				if name:find("goto") == 1 then
					move[name] = function(q, ...)
						if vim.wo.diff then
							local config = configs.get_module("textobjects.move")[name] ---@type table<string,string>
							for key, query in pairs(config or {}) do
								if q == query and key:find("[%]%[][cC]") then
									vim.cmd("normal! " .. key)
									return
								end
							end
						end
						return fn(q, ...)
					end
				end
			end
		end,
	},
	-- https://github.com/folke/ts-comments.nvim
	-- Easily override the comment string for a given treesitter language
	{
		"folke/ts-comments.nvim",
		opts = {},
		event = "VeryLazy",
		enabled = vim.fn.has("nvim-0.10.0") == 1,
	},
	-- https://github.com/windwp/nvim-ts-autotag
	-- Use treesitter to autoclose and autorename html tag
	{
		"windwp/nvim-ts-autotag",
		lazy = true,
		event = { "BufReadPre", "BufNewFile" },
		opts = {},
	},
}
