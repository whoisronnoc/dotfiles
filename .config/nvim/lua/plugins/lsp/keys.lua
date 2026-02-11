---@module "lazy"
---@type LazyPluginSpec
return {
	"neovim/nvim-lspconfig",
	optional = true,
	---@type LspOptions
	---@class LspOptions configs to change when the popup is shown
	opts = {
		---@type table<string, LspServerConfig?>
		servers = {
			["*"] = {
				-- stylua: ignore
				---@type LazyKeysLspSpec[]
				keys = {
					-- { "K", vim.lsp.buf.hover, desc = "Hover" },
					{ "gd", vim.lsp.buf.definition, desc = "Goto Definition", method = "textDocument/definition" },
					{ "gD", vim.lsp.buf.declaration, desc = "Goto Declaration" },
					{ "gr", vim.lsp.buf.references, desc = "References", nowait = true },
					{ "gI", vim.lsp.buf.implementation, desc = "Goto Implementation" },
					{ "gy", vim.lsp.buf.type_definition, desc = "Goto T[y]pe Definition" },
					{ "gK", vim.lsp.buf.signature_help, desc = "Signature Help", method = "textDocument/signatureHelp" },
					{ "<c-k>", vim.lsp.buf.signature_help, mode = "i", desc = "Signature Help", method = "textDocument/signatureHelp" },
					{ "<leader>cr", vim.lsp.buf.rename, desc = "Rename", method = "rename" },
					{ "<leader>ca", vim.lsp.buf.code_action, desc = "Code Action", mode = { "n", "x" }, method = "textDocument/codeAction" },
					{ "<leader>cc", vim.lsp.codelens.run, desc = "Run Codelens", mode = { "n", "x" }, method = "textDocument/codeLens" },
					{ "<leader>cC", vim.lsp.codelens.refresh, desc = "Refresh & Display Codelens", mode = { "n" }, method = "textDocument/codeLens" },
					{ "<leader>ch", function()
						vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
						end, desc = "Toggle Inlay [C]ode [H]ints", method = "textDocument/inlayHint"
					},
					--
					{ "<leader>e", vim.diagnostic.open_float, desc = "Open Floating Diagnostic", method = "textDocument/publishDiagnostics" },
					{ "]g", vim.diagnostic.goto_next, desc = "Next Diagnostic", method = "textDocument/publishDiagnostics" },
					{ "[g", vim.diagnostic.goto_prev, desc = "Previous Diagnostic", method = "textDocument/publishDiagnostics" },
					--
					{ "<leader>rn", vim.lsp.buf.rename, desc = "[R]e[n]ame", method = "textDocument/rename" },
					{"<D-.>", vim.lsp.buf.code_action, desc = "[R]e[n]ame", method = "textDocument/codeAction" },
				},
			},
		},
	},
}
