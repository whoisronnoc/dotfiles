local machine_options = require("core.machine_options")
local explorer = machine_options:getOption("explorer")
return {
	"rmagatti/auto-session",
	enabled = true,
	lazy = false,
	---@module "auto-session"
	---@type AutoSession.Config
	opts = {
		suppressed_dirs = { "~/", "~/dev", "~/Downloads", "/" },
		pre_save_cmds = {
			explorer == "neo-tree" and "Neotree close" or "",
			explorer == "snacks" and "lua Snacks.close()" or "",
		},
		post_restore_cmds = {
			explorer == "neo-tree" and "Neotree" or "",
			explorer == "snacks" and "lua Snacks.explorer()" or "",
		},
		bypass_save_filetypes = { "alpha", "dashboard" },
	},
}
