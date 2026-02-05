return {
	"pwntester/octo.nvim",
	requires = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
	},
	lazy = true,
	cmd = "Octo",
	opts = {
		-- or "fzf-lua" or "snacks" or "default"
		picker = "default",
		-- bare Octo command opens picker of commands
		enable_builtin = true,
	},
	keys = {
		{
			"<leader>oo",
			"<CMD>Octo<CR>",
			desc = "Octo Command List",
		},
		{
			"<leader>oi",
			"<CMD>Octo issue list<CR>",
			desc = "List GitHub Issues",
		},
		{
			"<leader>op",
			"<CMD>Octo pr list<CR>",
			desc = "List GitHub PullRequests",
		},
		{
			"<leader>od",
			"<CMD>Octo discussion list<CR>",
			desc = "List GitHub Discussions",
		},
		{
			"<leader>on",
			"<CMD>Octo notification list<CR>",
			desc = "List GitHub Notifications",
		},
		{
			"<leader>os",
			function()
				require("octo.utils").create_base_search_command({ include_current_repo = true })
			end,
			desc = "Search GitHub",
		},
		{
			"<leader>oc",
			function()
				require("octo.utils").create_base_search_command({
					include_current_repo = true,
					query = "archived:false sort:updated-desc is:pr archived:false is:open author:@me ",
				})
			end,
			desc = "Octo my PRs",
		},
		{
			"<leader>or",
			function()
				require("octo.utils").create_base_search_command({
					include_current_repo = true,
					query = "archived:false sort:updated-desc is:pr archived:false is:open review-requested:@me ",
				})
			end,
			desc = "Octo review requests",
		},
	},
}
