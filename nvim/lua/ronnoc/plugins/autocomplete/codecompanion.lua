return {
	{
		"olimorris/codecompanion.nvim",
		version = "*",
		enabled = true,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			-- Progress options optional
			"j-hui/fidget.nvim",
		},
		config = true,
		cmd = {
			"CodeCompanion",
			"CodeCompanionChat",
			"CodeCompanionCmd",
			"CodeCompanionActions",
		},
		keys = {
			{ "<leader>aa", "<cmd>CodeCompanionChat Toggle<cr>", desc = "Toggle Chat", mode = { "n", "v" } },
			{ "<leader>ap", "<cmd>CodeCompanionActions<cr>", desc = "Actions", mode = { "n", "v" } },
		},
		opts = {
			strategies = {
				chat = {
					adapter = "copilot",
				},
				inline = {
					adapter = "copilot",
				},
			},
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
		init = function()
			require("ronnoc.plugins.autocomplete.codecompanion.fidget-spinner"):init()
		end,
	},
}
