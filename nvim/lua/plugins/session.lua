return {
	"rmagatti/auto-session",
	lazy = false,
	---enables autocomplete for opts
	---@module "auto-session"
	---@type AutoSession.Config
	opts = {
		suppressed_dirs = { "~/", "~/dev", "~/Downloads", "/" },
		pre_save_cmds = {
			"Neotree close",
		},
		post_restore_cmds = {
			"Neotree",
		},
		pre_cwd_changed_cmds = {
			"Neotree close",
		},
		bypass_save_filetypes = { "alpha", "dashboard" }, -- or whatever dashboard you use
	},
}
