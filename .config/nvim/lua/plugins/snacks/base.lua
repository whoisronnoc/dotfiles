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
  -- stylua: ignore
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

        -- Create some toggle mappings
        -- stylua: ignore start
        -- Snacks.toggle.option("spell", { name = "[s]pelling" }):map("<leader>ts")
        Snacks.toggle.option("wrap", { name = "[w]rap" }):map("<leader>tw")
        Snacks.toggle.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map("<leader>tc")
        Snacks.toggle.option("mousescroll", { off = "ver:3,hor:0", on = "ver3,hor:1", name = "Horizontal Scroll" }):map("<leader>tm")

        Snacks.toggle.line_number():map("<leader>tl")
        Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>tL")

        Snacks.toggle.diagnostics():map("<leader>td")
        Snacks.toggle.treesitter():map("<leader>tT")
        Snacks.toggle.inlay_hints():map("<leader>th")

        Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark [b]ackground" }):map("<leader>tb")
				-- stylua: ignore end

				Snacks.toggle
					.new({
						id = "toggle_autoformat",
						name = "Auto [f]ormat",
						get = function()
							return vim.g.autoformat
						end,
						set = function(state)
							vim.g.autoformat = state
						end,
					})
					:map("<leader>tf")
			end,
		})
	end,
}
