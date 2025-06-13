return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	keys = {
		{ "<leader>mc", "<cmd>ConformInfo<CR>", desc = "Conform Info" },
	},
	config = function()
		local conform = require("conform")
		vim.g.autoformat = true

		conform.setup({
			formatters_by_ft = require("plugins.lsp.config._formatters_ft"),
			format_on_save = function()
				if not vim.g.autoformat then
					return
				end
				return { timeout_ms = 1000, async = false, lsp_format = "fallback" }
			end,
		})

		-- manual toggle command
		vim.api.nvim_create_user_command("FormatToggle", function()
			vim.g.autoformat = not vim.g.autoformat
		end, {
			desc = "Toggle autoformat-on-save",
		})
		-- vim.keymap.set({ "n", "v" }, "<leader>tf", "<cmd>FormatToggle<CR>", { desc = "Toggle autoformat-on-save" })

		vim.keymap.set({ "n", "v" }, "<leader>mp", function()
			conform.format({
				lsp_format = "fallback",
				async = false,
				timeout_ms = 1000,
			})
		end, {
			desc = "Format file or range (in visual mode)",
		})
	end,
}
