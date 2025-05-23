-- LSP Plugins
--- @module 'lazy'
--- @return LazyPluginSpec[]
return {
	{ "dmmulroy/ts-error-translator.nvim" },
	-- {
	-- 	"davidosomething/format-ts-errors.nvim",
	-- 	config = function()
	-- 		require("format-ts-errors").setup({
	-- 			add_markdown = true, -- wrap output with markdown ```ts ``` markers
	-- 			start_indent_level = 0, -- initial indent
	-- 		})
	-- 	end,
	-- },
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
			require("plugins.lsp.config.diagnostic")

			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
				callback = function(event)
					local m = require("plugins.lsp.config.keymaps")
					m.setup(event.buf)

					local client = vim.lsp.get_client_by_id(event.data.client_id)
					if
						client
						and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf)
					then
						m.setup_document_highlight(event)
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
					if
						client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf)
					then
						m.map_inlay_hints(event.buf)
					end
				end,
			})

			-- installation of LSP servers and tools
			local servers = require("plugins.lsp.config._lsp_servers")
			local tools = require("plugins.lsp.config._install_tools")
			local install = {}

			local function tableMerge(table1, table2, result)
				for _, v in ipairs(table1) do
					table.insert(result, v)
				end
				for _, v in ipairs(table2) do
					table.insert(result, v)
				end
			end
			tableMerge(servers, tools, install)

			require("mason-lspconfig").setup({
				ensure_installed = servers,
				automatic_installation = false,
				automatic_enable = false,
			})

			require("mason-tool-installer").setup({
				ensure_installed = install,
				auto_update = true,
			})

			vim.lsp.config("*", {
				capabilities = vim.tbl_extend(
					"force",
					vim.lsp.protocol.make_client_capabilities(),
					require("blink.cmp").get_lsp_capabilities()
				),
			})

			vim.lsp.enable(servers)
		end,
	},
}
