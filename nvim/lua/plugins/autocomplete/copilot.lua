local machine_options = require("core.machine_options")
local enable_ai = machine_options:getOption("ai_source") ~= "none"

--- @module 'lazy'
--- @return LazyPluginSpec[]
return {
	{
		"github/copilot.vim",
		enabled = enable_ai,
		cmd = "Copilot",
		-- build = "<cmd>Copilot setup<cr>",
		-- event = "BufWinEnter",
		event = { "BufReadPost", "BufNewFile" },
		version = "*",
		init = function()
			vim.g.copilot_no_maps = true
		end,
		config = function()
			-- Block the normal Copilot suggestions
			-- This setup and the callback is required for
			-- https://github.com/fang2hou/blink-copilot
			vim.api.nvim_create_augroup("github_copilot", { clear = true })
			for _, event in pairs({ "FileType", "BufUnload", "BufEnter" }) do
				vim.api.nvim_create_autocmd({ event }, {
					group = "github_copilot",
					callback = function()
						vim.fn["copilot#On" .. event]()
					end,
				})
			end
			vim.g.copilot_filetypes = {
				["*"] = true,
				gitcommit = false,
				NeogitCommitMessage = false,
				DressingInput = false,
				TelescopePrompt = false,
				["neo-tree-popup"] = false,
				["dap-repl"] = false,
			}
		end,
	},
}
