return {
	"snacks.nvim",
	--- @module 'snacks'
	--- @type snacks.Config
	opts = {
		indent = {
			enabled = false,
			indent = {
				char = "▎",
			},
			scope = {
				char = "▎",
				only_current = true,
			},
			animate = {
				enabled = false,
			},
		},
	},
}
