return {
	"snacks.nvim",
	--- @module 'snacks'
	--- @type snacks.Config
	opts = {},
	init = function()
		vim.g.snacks_animate = false
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
				vim.print = _G.dd -- Override print to use snacks for `:=` command

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

				Snacks.toggle.indent():map("<leader>tg")
				Snacks.toggle.dim():map("<leader>tD")
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
