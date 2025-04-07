return {
	{
		{
			"rcarriga/nvim-notify",
			event = "VeryLazy",
			opts = {
				top_down = false,
				background_colour = "#1e222a",
			},
		},
		{
			"folke/noice.nvim",
			event = "VeryLazy",
			opts = {},
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
