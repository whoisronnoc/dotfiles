return {
	enabled = false,
	"Pocco81/auto-save.nvim",
	config = function()
		require("auto-save").setup({})
	end,
	keys = {
		{
			"<leader>tw",
			"<cmd>ASToggle<cr>",
			desc = "Toggle auto [s]ave",
		},
	},
}
