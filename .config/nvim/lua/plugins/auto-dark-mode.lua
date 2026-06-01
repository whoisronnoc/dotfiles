return {
	"f-person/auto-dark-mode.nvim",
	opts = {
		set_dark_mode = function()
			vim.api.nvim_set_option_value("background", "dark", {})
			vim.cmd.colorscheme(vim.g.theme_dark)
		end,
		set_light_mode = function()
			vim.api.nvim_set_option_value("background", "light", {})
			vim.cmd.colorscheme(vim.g.theme_light)
		end,
		update_interval = 3000,
		fallback = "dark",
	},
	config = function(_, opts)
		-- On macOS the plugin has no monitor_command, so it polls via vim.system()
		-- every update_interval ms. After system sleep, subprocesses can accumulate
		-- with open file descriptors, eventually hitting the OS EMFILE limit.
		--
		-- Patch poll_dark_mode to:
		--   1. Skip if a poll is already in-flight (prevents descriptor accumulation)
		--   2. Catch errors and route through vim.notify instead of blocking dialogs
		local interval = require("auto-dark-mode.interval")
		local original_poll = interval.poll_dark_mode
		local in_progress = false

		interval.poll_dark_mode = function(callback)
			if in_progress then
				return
			end
			in_progress = true

			local wrapped_callback = function(stdout, stderr)
				in_progress = false
				if callback then
					callback(stdout, stderr)
				end
			end

			local ok, err = pcall(original_poll, wrapped_callback)
			if not ok then
				in_progress = false
				vim.schedule(function()
					vim.notify(
						"auto-dark-mode: " .. tostring(err),
						vim.log.levels.WARN,
						{ title = "auto-dark-mode.nvim" }
					)
				end)
			end
		end

		require("auto-dark-mode").setup(opts)
	end,
}
