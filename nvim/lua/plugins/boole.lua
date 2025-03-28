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
	config = function()
		require("boole").setup({
			mappings = {
				increment = "<C-a>",
				decrement = "<C-x>",
			},
			-- User defined loops
			additions = {
				{ "Foo", "Bar" },
				{ "tic", "tac", "toe" },
			},
			allow_caps_additions = {
				{ "enable", "disable" },
				-- enable → disable
				-- Enable → Disable
				-- ENABLE → DISABLE
			},
		})
	end,
}
