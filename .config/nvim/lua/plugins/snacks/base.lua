---@module "lazy"
---@type LazyPluginSpec
return {
	"folke/snacks.nvim",
	optional = true,
	--- @module 'snacks'
	--- @type snacks.Config
	opts = {
		bigfile = { enabled = true },
		indent = {
			enabled = false,
			indent = {
				char = "▎",
			},
			scope = {
				enabled = false,
				char = "▎",
				only_current = true,
			},
			animate = {
				enabled = false,
			},
		},
		input = { enabled = true },
		notifier = {
			enabled = true,
			timeout = 3000,
		},
		dim = {
			animate = { enabled = false },
		},
		quickfile = { enabled = true },
		scope = { enabled = false },
		statuscolumn = { enabled = true },
		image = { enabled = true },
		-- Disabled modules
		scroll = { enabled = false },
		-- styles = {
		-- 	notification = {
		-- 		-- wo = { wrap = true } -- Wrap notifications
		-- 	},
		-- },
	},
	init = function()
		vim.api.nvim_create_autocmd("User", {
			pattern = "VeryLazy",
			callback = function()
				-- Setup some globals for debugging (lazy-loaded)
				_G.dd = function(...)
					Snacks.debug.inspect(...)
				end
				_G.bt = function()
					Snacks.debug.backtrace()
				end
				-- Override print to use snacks for `:=` command
				if vim.fn.has("nvim-0.11") == 1 then
					vim._print = function(_, ...)
						_G.dd(...)
					end
				else
					vim.print = _G.dd
				end

				require("plugins.snacks.progress.notify").create_autocmd()
			end,
		})
	end,
}
