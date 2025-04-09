-- LSP Plugins
--- @module 'lazy'
--- @return LazyPluginSpec[]
return {
	--- @type LazyPluginSpec
	{
		"Bilal2453/luvit-meta",
		lazy = true,
	},
	--- @type LazyPluginSpec
	{
		"folke/lazydev.nvim",
		dependencies = { "Bilal2453/luvit-meta" },
		ft = "lua",
		opts = {
			library = {
				{ path = "lazy.nvim", words = { "Lazy" } },
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
				{ path = "luvit-meta/library", words = { "vim%.uv" } },
			},
			integrations = {
				cmp = true,
				lspconfig = true,
			},
		},
	},
	--- @type LazyPluginSpec
	{
		-- Main LSP Configuration
		"neovim/nvim-lspconfig",
		version = "*",
		lazy = true,
		event = { "BufReadPost", "BufNewFile" },
		cmd = { "LspInfo", "LspInstall", "LspUninstall" },
		dependencies = {
			-- Automatically install LSPs and related tools to stdpath for Neovim
			"williamboman/mason.nvim", -- NOTE: Must be added on the top level
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",

			-- Useful status updates for LSP.
			"j-hui/fidget.nvim",

			-- Allows extra capabilities provided by blink
			"saghen/blink.cmp",

			"b0o/schemastore.nvim",
		},
		config = function()
			vim.fn.sign_define("DiagnosticSignError", { text = "", texthl = "DiagnosticSignError" })
			vim.fn.sign_define("DiagnosticSignWarn", { text = "", texthl = "DiagnosticSignWarn" })
			vim.fn.sign_define("DiagnosticSignInfo", { text = "", texthl = "DiagnosticSignInfo" })
			vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint" })

			vim.diagnostic.config({
				update_in_insert = false,
				-- virtual_text = { current_line = true },
				underline = true,
				severity_sort = true,
				-- virtual_lines = true,
				-- virtual_lines = { current_line = true },
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = "",
						[vim.diagnostic.severity.WARN] = "",
						[vim.diagnostic.severity.INFO] = "",
						[vim.diagnostic.severity.HINT] = "󰌵",
					},
				},
			})

			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
				callback = function(event)
					local map = function(keys, func, desc, mode)
						mode = mode or "n"
						vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end
					map("gd", "<cmd>Telescope lsp_definitions<cr>", "[G]oto [D]efinition")
					map("gr", "<cmd>Telescope lsp_references<cr>", "[G]oto [R]eferences")
					map("gI", "<cmd>Telescope lsp_implementations<cr>", "[G]oto [I]mplementation")
					map("<leader>cD", "<cmd>Telescope lsp_type_definitions<cr>", "Type [D]efinition")
					map("<leader>cs", "<cmd>Telescope lsp_document_symbols<cr>", "[C]ode [S]ymbols")
					map("<leader>ws", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", "[W]orkspace [S]ymbols")
					map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
					map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "x" })
					map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

					local client = vim.lsp.get_client_by_id(event.data.client_id)
					if
						client
						and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf)
					then
						vim.api.nvim_create_augroup("lsp_document_highlight", {
							clear = false,
						})
						vim.api.nvim_clear_autocmds({
							buffer = event.buf,
							group = "lsp_document_highlight",
						})
						vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
							group = "lsp_document_highlight",
							buffer = event.buf,
							callback = vim.lsp.buf.document_highlight,
						})
						vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
							group = "lsp_document_highlight",
							buffer = event.buf,
							callback = vim.lsp.buf.clear_references,
						})
					end

					-- The following auto commands trigger the diagnostics for what you are hovering
					vim.api.nvim_create_autocmd("CursorHold", {
						buffer = event.buf,
						callback = function()
							-- Check if there are any visible floating windows already
							for _, win in ipairs(vim.api.nvim_list_wins()) do
								if vim.api.nvim_win_get_config(win).relative ~= "" then
									-- A float exists, don't create another one
									return
								end
							end

							local opts = {
								focusable = false,
								close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
								border = vim.g.border,
								source = "always",
								prefix = " ",
								scope = "cursor",
							}
							vim.diagnostic.open_float(nil, opts)
						end,
					})

					if
						client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf)
					then
						map("<leader>ch", function()
							vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
						end, "Toggle Inlay [C]ode [H]ints")
					end
				end,
			})

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

			-- LSP servers and clients are able to communicate to each other what features they support.
			--  By default, Neovim doesn't support everything that is in the LSP specification.
			--  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
			--  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
			--- @type lsp.ClientCapabilities
			-- local capabilities = vim.lsp.protocol.make_client_capabilities()

			local capabilities = require("blink.cmp").get_lsp_capabilities({}, true)
			local servers = require("plugins.lsp.servers._servers")

			local mason_tool_installer = require("mason-tool-installer")
			local tools = require("plugins.lsp.formatters._tools")
			mason_tool_installer.setup({
				ensure_installed = tools,
			})

			local lspconfig = require("lspconfig")
			for server_name, config in pairs(servers) do
				config.capabilities = vim.tbl_deep_extend("force", {}, capabilities, config.capabilities or {})
				lspconfig[server_name].setup(config)
			end
		end,
	},
}
