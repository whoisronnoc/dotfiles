---@module "lazy"
---@return LazyPluginSpec[]
return {
	{
		"folke/todo-comments.nvim",
		event = "VeryLazy",
		dependencies = { "nvim-lua/plenary.nvim" },
		keys = {
			{
				"]t",
				function()
					require("todo-comments").jump_next()
				end,
			},
			{
				"[t",
				function()
					require("todo-comments").jump_prev()
				end,
			},
		},
		opts = {
			signs = vim.g.have_nerd_font,
			-- comments_only = true, -- uses treesitter to match keywords in comments only
			-- exclude = { "json" }, -- list of file types to exclude highlighting
			-- highlight = {
			-- 	pattern = [[.*<(KEYWORDS)\s*:?\c]], -- '\c' ignore case
			-- },
			-- search = {
			-- 	command = "rg",
			-- 	args = {
			-- 		"-i", -- '-i' ignore case
			-- 		"--color=never",
			-- 		"--no-heading",
			-- 		"--with-filename",
			-- 		"--line-number",
			-- 		"--column",
			-- 	},
			-- 	pattern = [[\b(KEYWORDS):]],
			-- },
			keywords = {
				-- stylua: ignore start
				FIX =  { icon = " ", color = "error",   alt = { "FIXME", "BUG", "FIXIT", "ISSUE", "FIX" } },
				TODO = { icon = " ", color = "info",    alt = { "DO" } },
				HACK = { icon = " ", color = "warning", alt = { "OVERRIDE" } },
				WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
				PERF = { icon = " ", color = "test",    alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
				NOTE = { icon = " ", color = "hint",    alt = { "INFO", "MARK", "HINT" } },
				TEST = { icon = "⏲ ", color = "test",    alt = { "TESTING", "PASSED", "FAILED" } },
				-- stylua: ignore end
			},
		},
	},
}
