return {
	"olimorris/codecompanion.nvim",
	version = "*",
	enabled = false,
	event = "VeryLazy",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
		-- Progress options optional
		"nvim-telescope/telescope.nvim",
		"j-hui/fidget.nvim",
		"ravitemer/mcphub.nvim",
	},
	config = true,
	lazy = true,
	cmd = {
		"CodeCompanion",
		"CodeCompanionChat",
		"CodeCompanionCmd",
		"CodeCompanionActions",
	},
	keys = {
		{ "<leader>aa", "<cmd>CodeCompanionChat Toggle<cr>", desc = "Toggle Chat", mode = { "n", "v" } },
		{ "<leader>ap", "<cmd>CodeCompanionActions<cr>", desc = "Prompt Actions", mode = { "n", "v" } },
	},
	opts = {
		strategies = {
			inline = {
				adapter = "copilot",
			},
			chat = {
				adapter = "copilot",
				tools = {
					["mcp"] = {
						-- calling it in a function would prevent mcphub from being loaded before it's needed
						callback = function()
							return require("mcphub.extensions.codecompanion")
						end,
						description = "Call tools and resources from the MCP Servers",
					},
				},
			},
		},
		show_defaults = false,
		adapters = {
			copilot = function()
				-- lua print(vim.inspect(require("codecompanion.adapters").extend("copilot").schema.model.choices()))
				local adapters = require("codecompanion.adapters")
				return adapters.extend("copilot", {
					schema = {
						model = {
							default = "claude-3.7-sonnet",
						},
					},
				})
			end,
		},
	},
}
