--- @return LazyPluginSpec
return {
	"folke/snacks.nvim",
	---@type snacks.config
	opts = {
		terminal = {},
		toggle = {},
		scratch = {},
	},
	keys = {
		{
			"<c-/>",
			function()
				Snacks.terminal()
			end,
			desc = "Toggle Terminal",
		},
		{
			"<leader>bs",
			function()
				Snacks.scratch()
			end,
			desc = "Toggle Scratch Buffer",
		},
		{
			"<leader>bS",
			function()
				Snacks.scratch.select()
			end,
			desc = "Scratch Buffer",
		},
	},
}
