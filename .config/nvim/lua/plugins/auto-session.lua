local explorer = Options:getOption("explorer")

return {
	"rmagatti/auto-session",
	enabled = true,
	lazy = false,
	---@module "auto-session"
	---@type AutoSession.Config
	opts = {
		lazy_support = true, -- Automatically detect if Lazy.nvim is being used and wait until Lazy is done to make sure session is restored correctly. Does nothing if Lazy isn't being used. Can be disabled if a problem is suspected or for debugging
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
