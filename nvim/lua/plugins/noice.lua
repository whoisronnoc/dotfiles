return {
	{
		{
			enabled = true,
			"rcarriga/nvim-notify",
			event = "VeryLazy",
			opts = {
				top_down = false,
				background_colour = "#1e222a",
			},
		},
		{
			enabled = true,
			"folke/noice.nvim",
			event = "VeryLazy",
			opts = {
				presets = {
					long_message_to_split = true,
				},
			},
			dependencies = {
				"MunifTanjim/nui.nvim",
				"rcarriga/nvim-notify",
			},
			keys = {
				{
					"<leader>nl",
					function()
						require("noice").cmd("last")
					end,
					desc = "Show last notification",
				},
				{
					"<leader>nh",
					function()
						require("noice").cmd("history")
					end,
					desc = "Show notification history",
				},
			},
		},
	},
}
