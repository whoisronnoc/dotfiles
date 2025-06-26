--- @module 'lazy'
--- @return LazyPluginSpec[]
return {
	{
		"christoomey/vim-tmux-navigator",
		cmd = {
			"TmuxNavigateLeft",
			"TmuxNavigateDown",
			"TmuxNavigateUp",
			"TmuxNavigateRight",
			"TmuxNavigatePrevious",
			"TmuxNavigatorProcessList",
		},
		keys = {
			{ "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
			{ "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
			{ "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
			{ "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
			{ "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
		},
	},
	-- Notifications provider
	{
		"j-hui/fidget.nvim",
		version = "*",
		lazy = true,
		opts = {},
		config = function(_, opts)
			require("fidget").setup(opts)
			require("plugins.autocomplete.codecompanion.fidget-spinner"):init()
		end,
	},
	-- Detect tabstop and shiftwidth automatically
	{
		"tpope/vim-sleuth",
		lazy = true,
		event = "BufReadPre",
	},
}
