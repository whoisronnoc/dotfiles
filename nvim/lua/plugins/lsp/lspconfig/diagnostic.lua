-- vim.fn.sign_define("DiagnosticSignError", { text = "", texthl = "DiagnosticSignError" })
-- vim.fn.sign_define("DiagnosticSignWarn", { text = "", texthl = "DiagnosticSignWarn" })
-- vim.fn.sign_define("DiagnosticSignInfo", { text = "", texthl = "DiagnosticSignInfo" })
-- vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint" })
--
-- vim.diagnostic.config({
-- 	update_in_insert = false,
-- 	-- virtual_text = { current_line = true },
-- 	underline = true,
-- 	severity_sort = true,
-- 	-- virtual_lines = true,
-- 	-- virtual_lines = { current_line = true },
-- 	signs = {
-- 		text = {
-- 			[vim.diagnostic.severity.ERROR] = "",
-- 			[vim.diagnostic.severity.WARN] = "",
-- 			[vim.diagnostic.severity.INFO] = "",
-- 			[vim.diagnostic.severity.HINT] = "󰌵",
-- 		},
-- 	},
-- })
--

if vim.g.border then
	-- To override globally the opts if none are provided
	-- https://github.com/neovim/nvim-lspconfig/wiki/UI-Customization#borders
	local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
	function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
		opts = opts or {}
		opts.border = opts.border or vim.g.border
		return orig_util_open_floating_preview(contents, syntax, opts, ...)
	end
end

--- @type vim.diagnostic.Opts
local diag_opts = {
	float = {
		border = vim.g.border,
		source = "if_many",
		prefix = " ",
		scope = "cursor",
	},
	update_in_insert = false,
	virtual_text = {
		severity = {
			min = vim.diagnostic.severity.ERROR,
		},
	},
	signs = {
		-- linehl = {
		-- 	[vim.diagnostic.severity.ERROR] = "DiagnosticVirtualTextError",
		-- 	[vim.diagnostic.severity.WARN] = "DiagnosticVirtualTextWarn",
		-- 	[vim.diagnostic.severity.HINT] = "DiagnosticVirtualTextHint",
		-- 	[vim.diagnostic.severity.INFO] = "DiagnosticVirtualTextInfo",
		-- },
		numhl = {
			[vim.diagnostic.severity.ERROR] = "DiagnosticError",
			[vim.diagnostic.severity.WARN] = "DiagnosticWarn",
			[vim.diagnostic.severity.HINT] = "DiagnosticHint",
			[vim.diagnostic.severity.INFO] = "DiagnosticInfo",
		},
	},
	underline = true,
	severity_sort = true,
	virtual_lines = false,
	focusable = false,
}

if vim.g.have_nerd_font then
	vim.fn.sign_define("DiagnosticSignError", { text = "", texthl = "DiagnosticError" })
	vim.fn.sign_define("DiagnosticSignWarn", { text = "", texthl = "DiagnosticWarn" })
	vim.fn.sign_define("DiagnosticSignInfo", { text = "", texthl = "DiagnosticInfo" })
	vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticHint" })
	diag_opts.signs.text = {
		[vim.diagnostic.severity.ERROR] = "",
		[vim.diagnostic.severity.WARN] = "",
		[vim.diagnostic.severity.INFO] = "",
		[vim.diagnostic.severity.HINT] = "",
	}
end

vim.diagnostic.config(diag_opts)
