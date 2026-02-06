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
			"Neotree close",
			-- "lua Snacks.close()"
		},
		post_restore_cmds = {
			"Neotree",
			-- "lua Snacks.explorer()",
		},
		bypass_save_filetypes = { "alpha", "dashboard", "sidekick_terminal" },
	},
}
