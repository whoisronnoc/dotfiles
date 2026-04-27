return {
	"voldikss/vim-floaterm",
	lazy = true,
	commands = {
		"FloatermNew",
		"FloatermToggle",
	},
	keys = {
		{ "<leader>ft", "<cmd>FloatermToggle<cr>", desc = "Toggle Floaterm" },
		{ "<leader>fn", "<cmd>FloatermNew<cr>", desc = "New Floaterm" },
		-- custom floatterm commands
		{ "<leader>lb", "<cmd>FloatermNew --name=lazybut --title=lazybut but tui<cr>", desc = "LazyBut" },
		{ "<leader>y", "<cmd>FloatermNew --name=yazi --title=yazi yazi<cr>", desc = "Yazi" },
	},
}
