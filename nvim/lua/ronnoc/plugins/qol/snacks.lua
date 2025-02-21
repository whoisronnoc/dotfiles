--- @return LazyPluginSpec
return {
	"folke/snacks.nvim",
	---@type snacks.config
	opts = {
		image = {},
		terminal = {},
		toggle = {},
		scratch = {},
	},
	keys = {
		{
			"<leader>.",
			function()
				Snacks.scratch()
			end,
			desc = "Toggle Scratch Buffer",
		},
		{
			"<leader>S",
			function()
				Snacks.scratch.select()
			end,
			desc = "Select Scratch Buffer",
		},
	},
}
