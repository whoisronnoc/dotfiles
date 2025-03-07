return {
	{
		{
			"rcarriga/nvim-notify",
			opts = {
				top_down = false,
			},
		},
		{
			"folke/noice.nvim",
			event = "VeryLazy",
			opts = {
				-- add any options here
			},
			dependencies = {
				-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
				"MunifTanjim/nui.nvim",
				-- OPTIONAL:
				--   `nvim-notify` is only needed, if you want to use the notification view.
				--   If not available, we use `mini` as the fallback
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
