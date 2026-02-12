---@module "lazy"
---@return LazyPluginSpec
return {
	"folke/sidekick.nvim",
	enabled = true,
	event = { "BufWinEnter", "VeryLazy" },
	opts = {
		-- add any options here
		cli = {
			mux = {
				backend = "tmux",
				enabled = true,
			},
		},
	},
	keys = {
		{
			"<tab>",
			function()
				-- if there is a next edit, jump to it, otherwise apply it if any
				if not require("sidekick").nes_jump_or_apply() then
					return "<Tab>" -- fallback to normal tab
				end
			end,
			expr = true,
			mode = { "n", "i" },
			desc = "Goto/Apply Next Edit Suggestion",
		},
		{
			"<leader>ae",
			function()
				require("sidekick.nes").update()
			end,
			desc = "Sidekick request [e]dits",
		},
		{
			"<leader>aa",
			function()
				require("sidekick.cli").toggle()
				vim.cmd("stopinsert")
			end,
			desc = "Sidekick Toggle CLI",
		},
		{
			"<leader>as",
			function()
				require("sidekick.cli").select({ filter = { installed = true } })
			end,
			desc = "Select CLI",
		},
		{
			"<leader>ad",
			function()
				require("sidekick.cli").close()
			end,
			desc = "Detach a CLI Session",
		},
		{
			"<leader>at",
			function()
				require("sidekick.cli").send({ msg = "{this}" })
			end,
			mode = { "x", "n" },
			desc = "Send This",
		},
		{
			"<leader>af",
			function()
				require("sidekick.cli").send({ msg = "{file}" })
			end,
			desc = "Send File",
		},
		{
			"<leader>av",
			function()
				require("sidekick.cli").send({ msg = "{selection}" })
			end,
			mode = { "x" },
			desc = "Send Visual Selection",
		},
		{
			"<leader>ap",
			function()
				require("sidekick.cli").prompt()
			end,
			mode = { "n", "x" },
			desc = "Sidekick Select Prompt",
		},
	},
}
