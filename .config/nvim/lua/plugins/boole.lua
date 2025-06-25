-- https://github.com/nat-418/boole.nvim
return {
	-- Boole is a simple Neovim plugin that extends the default increment and decrement
	-- functionality of CTRL-A and CTRL-X to allow for toggling boolean values like on, yes, and true as well as cycling through:
	--
	-- Days of the week and their abbreviations (e.g., Monday → Tuesday)
	-- Months of the year and their abbreviations (e.g., Jan → Feb)
	-- X11 / Web color names (e.g., Orange → OrangeRed)
	-- Canonical hours (e.g., Compline → Vigil)
	-- Letter + number "words" (e.g., F1 → F2)

	-- This plugin ships one command:
	--
	-- :Boole {increment|decrement}
	--
	"nat-418/boole.nvim",
	lazy = true,
	keys = {
		{ "<C-x>", "<cmd>Boole increment<cr>", mode = "n", desc = "Boole increment" },
		{ "<C-X>", "<cmd>Boole decrement<cr>", mode = "n", desc = "Boole decrement" },
	},
	cmd = {
		"Boole",
	},
	opts = {
		mappings = {
			increment = "<C-x>",
			decrement = "<C-X>",
		},
		-- User defined loops
		additions = {
			{ "Foo", "Bar" },
			{ "tic", "tac", "toe" },
			{ "const", "let", "var" },
		},
		allow_caps_additions = {
			{ "enable", "disable" },
			-- enable → disable
			-- Enable → Disable
			-- ENABLE → DISABLE
		},
	},
}
