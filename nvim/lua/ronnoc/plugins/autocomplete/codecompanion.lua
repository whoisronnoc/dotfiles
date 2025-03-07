return {
	{
		{
			enabled = false,
			"ravitemer/mcphub.nvim",
			dependencies = {
				"nvim-lua/plenary.nvim",
				"j-hui/fidget.nvim",
			},
			build = "npm install -g mcp-hub@latest",
			config = function()
				require("mcphub").setup({
					port = 3000,
					config = vim.fn.expand("~/mcpservers.json"),
				})
			end,
		},
	},
	{
		"olimorris/codecompanion.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("codecompanion").setup({
				strategies = {
					inline = {
						adapter = "copilot",
					},
					chat = {
						adapter = "copilot",
						-- agents = {
						-- 	tools = {
						-- 		["mcp"] = {
						-- 			callback = require("mcphub.extensions.codecompanion"),
						-- 			description = "Call tools and resources from the MCP Servers",
						-- 			opts = {
						-- 				user_approval = true,
						-- 			},
						-- 		},
						-- 	},
						-- },
					},
				},
			})
		end,
	},
}
