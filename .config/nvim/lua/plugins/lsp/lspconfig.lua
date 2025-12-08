local diagnostic_display = Options:getOption("diagnostic_display")
local workspace_diagnostics = Options:getOption("workspace_diagnostics")

-- LSP Plugins
--- @module 'lazy'
--- @return LazyPluginSpec[]
return {
	{
		"whoisronnoc/lsp-toggle.nvim",
		event = "VeryLazy",
		dev = true,
		cmd = { "ToggleLSP", "ToggleNullLSP" },
		keys = {
			{ "<leader>ma", "<cmd>ToggleLSP<CR>", desc = "ToggleLSP" },
			{ "<leader>mS", "<cmd>ToggleNullLSP<CR>", desc = "ToggleNullLSP" },
			{ "<leader>ts", "<cmd>ToggleNullLSP cspell<CR>", desc = "ToggleNullLSP cspell" },
		},
		config = function()
			require("lsp-toggle").setup()
		end,
	},
	{
		"artemave/workspace-diagnostics.nvim",
		event = "VeryLazy",
		enabled = workspace_diagnostics,
	},
	{
		"whoisronnoc/format-ts-errors.nvim",
		event = "VeryLazy",
		dev = true,
		config = function()
			require("format-ts-errors").setup({
				add_markdown = true,
				start_indent_level = 0,
			})
		end,
	},
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
		lazy = false,
		event = { "BufReadPost", "BufNewFile", "VeryLazy" },
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

			"nvimtools/none-ls.nvim",

			"jay-babu/mason-null-ls.nvim",

			"https://gitlab.com/schrieveslaach/sonarlint.nvim",
		},
		config = function(_, opts)
			require("plugins.lsp.config.diagnostic")
			require("plugins.lsp.config.progress"):create_autocmd()

			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
				callback = function(event)
					local m = require("plugins.lsp.config.lsp_utils")
					m.setup_keybinds(event.buf)

					local client = vim.lsp.get_client_by_id(event.data.client_id)
					if workspace_diagnostics and client and client.name ~= "GitHub Copilot" then
						require("workspace-diagnostics").populate_workspace_diagnostics(client, event.buf)
					end

					if
						client
						and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf)
					then
						m.setup_document_highlight(event)
					end

					if diagnostic_display == "float" then
						m.setup_float_diagnostics(event)
					end

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

			-- require("mason-null-ls").setup({
			-- 	handlers = {},
			-- })

			vim.lsp.config("*", {
				capabilities = vim.tbl_extend(
					"force",
					vim.lsp.protocol.make_client_capabilities(),
					require("blink.cmp").get_lsp_capabilities()
				),
			})

			vim.lsp.enable(servers)

			if
				os.getenv("SONARQUBE_ID")
				and os.getenv("SONARQUBE_KEY")
				and os.getenv("SONARQUBE_URL")
				and os.getenv("SONARQUBE_TOKEN")
			then
				require("sonarlint").setup({
					server = {
						cmd = {
							"sonarlint-language-server",
							"-stdio",
							"-analyzers",
							vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarjs.jar"),
							vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarhtml.jar"),
						},
						settings = {
							sonarlint = {
								disableTelemetry = true,
								output = {
									showAnalyzerLogs = true,
									showVerboseLogs = true,
								},
								connectedMode = {
									projects = {
										{
											connectionId = os.getenv("SONARQUBE_ID"),
											projectKey = os.getenv("SONARQUBE_KEY"),
										},
									},
									servers = {
										{

											connectionId = os.getenv("SONARQUBE_ID"),
											serverUrl = os.getenv("SONARQUBE_URL"),
										},
									},
									connections = {
										sonarqube = {
											{
												connectionId = os.getenv("SONARQUBE_ID"),
												serverUrl = os.getenv("SONARQUBE_URL"),
												token = os.getenv("SONARQUBE_TOKEN"),
											},
										},
									},
								},
								rules = {
									["typescript:S6019"] = { level = "on" },
									["typescript:S6035"] = { level = "on" },
									["typescript:S2933"] = { level = "on" },
									["typescript:S1607"] = { level = "on" },
									["typescript:S6079"] = { level = "on" },
								},
							},
						},
					},
					filetypes = {
						"javascript",
						"typescript",
						"javascriptreact",
						"typescriptreact",
						"html",
						"htmlangular",
					},
				})
			end
		end,
	},
}
