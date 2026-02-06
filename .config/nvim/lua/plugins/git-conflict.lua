return {
	"akinsho/git-conflict.nvim",
	version = "*",
	config = true,
	event = { "BufReadPost" },
	commands = {
		"GitConflictListQf",
		"GitConflictChooseOurs",
		"GitConflictChooseTheirs",
		"GitConflictChooseBoth",
		"GitConflictChooseNone",
		"GitConflictNextConflict",
		"GitConflictPrevConflict",
	},
	opts = {
		{
			default_mappings = true,
			default_commands = true,
			disable_diagnostics = true,
			list_opener = "copen",
			highlights = {
				incoming = "DiffAdd",
				current = "DiffText",
			},
		},
	},
}
