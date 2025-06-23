return {
	enabled = false,
	"mfussenegger/nvim-lint",
	event = {
		"BufReadPre",
		"BufNewFile",
	},
	config = function()
		local lint = require("lint")
		lint.linters_by_ft = require("plugins.lsp.config._linters_ft")

		local lint_all = vim.api.nvim_create_augroup("lint", { clear = true })
		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			group = lint_all,
			callback = function()
				lint.try_lint()
				-- lint.try_lint("cspell")
			end,
		})

		vim.keymap.set("n", "<leader>me", function()
			lint.try_lint()
			lint.try_lint("cspell")
		end, {
			desc = "Trigger linting",
		})
	end,
}
