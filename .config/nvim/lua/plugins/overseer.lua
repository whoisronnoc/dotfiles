return {
	"stevearc/overseer.nvim",
	keys = {
		{ "<leader>oi", "<cmd>OverseerInfo<cr>", desc = "Overseer Info" },

		-- { "<leader>o", "<cmd>OverseerOpen<cr>", desc = "Overseer Open" },
		-- { "<leader>oc", "<cmd>OverseerClose<cr>", desc = "Overseer Close" },
		{ "<leader>ot", "<cmd>OverseerToggle<cr>", desc = "Overseer Toggle" },

		{ "<leader>or", "<cmd>OverseerRun<cr>", desc = "Overseer Run" },
		{ "<leader>o;", "<cmd>OverseerRunCmd<cr>", desc = "Overseer RunCmd" },

		{ "<leader>oob", "<cmd>OverseerBuild<cr>", desc = "Overseer Build" },
		{ "<leader>oos", "<cmd>OverseerSaveBundle<cr>", desc = "Overseer Save Bundle" },
		{ "<leader>ool", "<cmd>OverseerLoadBundle<cr>", desc = "Overseer Load Bundle" },
		{ "<leader>ood", "<cmd>OverseerDeleteBundle<cr>", desc = "Overseer Delete Bundle" },
		{ "<leader>oox", "<cmd>OverseerClearCache<cr>", desc = "Overseer Clear Cache" },

		{ "<leader>oa", "<cmd>OverseerTaskAction<cr>", desc = "Overseer Task Action" },
		{ "<leader>oq", "<cmd>OverseerQuickAction<cr>", desc = "Overseer Quick Action" },
	},
	opts = {},
}
