---@module "lazy"
---@type LazyPluginSpec
return {
	"folke/snacks.nvim",
	optional = true,
	--- @module 'snacks'
	--- @type snacks.Config
	-- stylua: ignore
	init = function()
		vim.api.nvim_create_autocmd("User", {
			pattern = "VeryLazy",
			callback = function()
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
				Snacks.toggle
					.new({
						id = "toggle_autoformat_imports",
						name = "Auto [o]rganize imports",
						get = function()
							return vim.g.autoformat_imports
						end,
						set = function(state)
							vim.g.autoformat_imports = state
						end,
					})
					:map("<leader>to")
			end,
		})
	end,
}
