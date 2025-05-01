return {
	"rmagatti/auto-session",
	enabled = false,
	lazy = false,
	---@module "auto-session"
	---@type AutoSession.Config
	opts = {
		suppressed_dirs = { "~/", "~/dev", "~/Downloads", "/" },
		pre_save_cmds = {
			-- "Neotree close",
		},
		post_restore_cmds = {
			-- "Neotree",
		},
		bypass_save_filetypes = { "alpha", "dashboard" },
	},
}
