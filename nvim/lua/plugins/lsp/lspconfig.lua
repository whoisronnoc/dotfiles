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
		keys = {
			{ "<leader>ms", "<cmd>LspInfo<CR>", desc = "LSP Info" },
			{ "<leader>mm", "<cmd>Mason<CR>", desc = "Manage Mason" },
		},
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
		config = function(_, opts)
			require("plugins.lsp.lspconfig.diagnostic")

			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
				callback = function(event)
					local m = require("plugins.lsp.lspconfig.keymaps")
					m.setup(event.buf)

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
						-- vim.api.nvim_create_autocmd("BufWritePre", {
						-- 	callback = function()
						-- 		vim.lsp.buf.code_action({
						-- 			context = {
						-- 				only = { "source.organizeImports" },
						-- 			},
						-- 			apply = true,
						-- 		})
						-- 	end,
						-- 	buffer = event.buf,
						-- })
					end

					-- The following auto commands trigger the diagnostics for what you are hovering
					vim.api.nvim_create_autocmd("CursorHold", {
						buffer = event.buf,
						callback = function()
							-- Check if there are any visible floating windows already
							-- for _, win in ipairs(vim.api.nvim_list_wins()) do
							-- 	if vim.api.nvim_win_get_config(win).relative ~= "" then
							-- 		-- A float exists, don't create another one
							-- 		return
							-- 	end
							-- end

							vim.diagnostic.open_float(nil, { focus = false, scope = "cursor" })
						end,
					})

					-- The following code creates a keymap to toggle inlay hints in your
					-- code, if the language server you are using supports them
					--
					-- This may be unwanted, since they displace some of your code
					if
						client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf)
					then
						m.map_inlay_hints(event.buf)
					end
				end,
			})

			local servers = require("plugins.lsp.lspconfig._lsp_servers")

			require("mason-lspconfig").setup({
				ensure_installed = servers,
				automatic_installation = false,
				automatic_enable = false,
			})

			local mason_tool_installer = require("mason-tool-installer")
			local tools = require("plugins.lsp.formatters._install_tools")
			mason_tool_installer.setup({
				auto_update = true,
				ensure_installed = tools,
			})

			--- @type lsp.ClientCapabilities
			local capabilities = require("blink.cmp").get_lsp_capabilities({}, true)

			vim.lsp.config("*", {
				capabilities = vim.tbl_extend(
					"force",
					vim.lsp.protocol.make_client_capabilities(),
					require("blink.cmp").get_lsp_capabilities()
				),
			})
			vim.lsp.enable(servers)

			-- local lspconfig = require("lspconfig")
			-- for server_name, config in pairs(servers) do
			-- 	-- config.capabilities = vim.tbl_deep_extend("force", {}, capabilities, config.capabilities or {})
			-- 	-- lspconfig[server_name].setup(config)
			-- 	-- vim.lsp.config(server_name, {
			-- 	-- 	settings = {
			-- 	-- 		[server_name] = config,
			-- 	-- 	},
			-- 	-- })
			-- end
		end,

		--
		-- local ensure_installed = vim.tbl_filter(function(server)
		-- 	return not vim.tbl_contains(opts.exclude, server)
		-- end, opts.servers)
		-- require("mason-lspconfig").setup({
		-- 	ensure_installed = ensure_installed,
		-- 	automatic_installation = false,
		-- })

		-- vim.lsp.config("*", {
		-- 	--- @type lsp.ClientCapabilities
		-- 	capabilities = vim.tbl_extend(
		-- 		"force",
		-- 		vim.lsp.protocol.make_client_capabilities(),
		-- 		require("blink.cmp").get_lsp_capabilities()
		-- 	),
		-- })
		-- vim.lsp.enable(opts.servers)
	},
}
