return {
	"rmagatti/auto-session",
	enabled = true,
	lazy = false,
	---@module "auto-session"
	---@type AutoSession.Config
	opts = {
		suppressed_dirs = { "~/", "~/dev", "~/Downloads", "/" },
		pre_save_cmds = {
			-- "Neotree close",
			"lua Snacks.explorer()",
		},
		post_restore_cmds = {
			-- "Neotree",
			"lua Snacks.explorer()",
		},
		bypass_save_filetypes = { "alpha", "dashboard" },
	},
}
