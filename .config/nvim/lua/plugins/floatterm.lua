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
		{
			"<leader>lb",
			"<cmd>FloatermNew --height=0.8 --width=0.8 --name=lazybut --title=lazybut but tui<cr>",
			desc = "LazyBut",
		},
		{ "<leader>y", "<cmd>FloatermNew --height=0.8 --width=0.8 --name=yazi --title=yazi yazi<cr>", desc = "Yazi" },
		{
			"<leader>ld",
			"<cmd>FloatermNew --height=0.8 --width=0.8 --name=lazydiff --title=lazydiff hunk diff<cr>",
			desc = "LazyDiff",
		},
		{
			"<leader>lh",
			"<cmd>FloatermNew --height=0.8 --width=0.8 --name=lazyhunk --title=lazyhunk hunk show<cr>",
			desc = "LazyHunk",
		},
	},
}
