return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	keys = {
		{ "<leader>mc", "<cmd>ConformInfo<CR>", desc = "Conform Info" },
	},
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters_by_ft = require("plugins.lsp.formatters._formatters"),
			format_on_save = {
				lsp_fallback = true,
				async = false,
				timeout_ms = 1000,
			},
		})

		vim.keymap.set({ "n", "v" }, "<leader>mp", function()
			conform.format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 1000,
			})
		end, {
			desc = "Format file or range (in visual mode)",
		})
	end,
}
