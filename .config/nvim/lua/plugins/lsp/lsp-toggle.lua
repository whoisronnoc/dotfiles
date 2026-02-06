return {
	"whoisronnoc/lsp-toggle.nvim",
	event = "VeryLazy",
	dev = true,
	cmd = { "ToggleLSP", "ToggleNullLSP" },
	keys = {
		-- { "<leader>ma", "<cmd>ToggleLSP<CR>", desc = "ToggleLSP" },
		-- { "<leader>mS", "<cmd>ToggleNullLSP<CR>", desc = "ToggleNullLSP" },
		-- { "<leader>ts", "<cmd>ToggleNullLSP cspell<CR>", desc = "ToggleNullLSP cspell" },
		{ "<leader>ts", "<cmd>ToggleLSP<CR>", desc = "ToggleLSP" },
	},
	config = function()
		require("lsp-toggle").setup()
	end,
}
