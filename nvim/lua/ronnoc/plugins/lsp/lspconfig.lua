return {
	{
		"williamboman/mason.nvim",
		config = function()
			local mason = require("mason")
			-- local mason_lspconfig = require("mason-lspconfig")
			-- local mason_tool_installer = require("mason-tool-installer")

			-- enable mason and configure icons
			mason.setup({
				ui = {
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗"
					}
				}
			})

			-- mason_lspconfig.setup({
			-- 		-- list of servers for mason to install
			-- 		ensure_installed = {
			-- 			-- "lua_ls",
			-- 			"jsonls",
			-- 			"yamlls",
			-- 		}
			-- })

			-- mason_tool_installer.setup({
			-- 		ensure_installed = {"prettier", -- prettier formatter
			-- 		"stylua", -- lua formatter
			-- 		"isort", -- python formatter
			-- 		"black", -- python formatter
			-- 		"pylint", "eslint_d"}
			-- })
			end
	},
	-- {
	-- 	-- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
	-- 	-- used for completion, annotations and signatures of Neovim apis
	-- 	"folke/lazydev.nvim",
	-- 	ft = "lua",
	-- 	opts = {
	-- 		library = {
	-- 			-- Load luvit types when the `vim.uv` word is found
	-- 			{ path = "luvit-meta/library", words = { "vim%.uv" } },
	-- 		},
	-- 	},
	-- },
	-- {
	-- 	"Bilal2453/luvit-meta",
	-- 	lazy = true,
	-- },
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			"j-hui/fidget.nvim",
			"saghen/blink.cmp",
			"b0o/schemastore.nvim"
		},
		config = function()
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
				callback = function(event)
					-- NOTE: Remember that Lua is a real programming language, and as such it is possible
					-- to define small helper and utility functions so you don't have to repeat yourself.
					--
					-- In this case, we create a function that lets us more easily define mappings specific
					-- for LSP related items. It sets the mode, buffer and description for us each time.
					local map = function(keys, func, desc, mode)
						mode = mode or "n"
						vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end

					-- Jump to the definition of the word under your cursor.
					--  This is where a variable was first declared, or where a function is defined, etc.
					--  To jump back, press <C-t>.
					map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")

					-- Find references for the word under your cursor.
					map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")

					-- Jump to the implementation of the word under your cursor.
					--  Useful when your language has ways of declaring types without an actual implementation.
					map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")

					-- Jump to the type of the word under your cursor.
					--  Useful when you're not sure what type a variable is and you want to see
					--  the definition of its *type*, not where it was *defined*.
					map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")

					-- Fuzzy find all the symbols in your current document.
					--  Symbols are things like variables, functions, types, etc.
					map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")

					-- Fuzzy find all the symbols in your current workspace.
					--  Similar to document symbols, except searches over your entire project.
					map(
						"<leader>ws",
						require("telescope.builtin").lsp_dynamic_workspace_symbols,
						"[W]orkspace [S]ymbols"
					)

					-- Rename the variable under your cursor.
					--  Most Language Servers support renaming across files, etc.
					map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")

					-- Execute a code action, usually your cursor needs to be on top of an error
					-- or a suggestion from your LSP for this to activate.
					map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "x" })

					-- WARN: This is not Goto Definition, this is Goto Declaration.
					--  For example, in C this would take you to the header.
					map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

					-- The following two autocommands are used to highlight references of the
					-- word under your cursor when your cursor rests there for a little while.
					--    See `:help CursorHold` for information about when this is executed
					--
					-- When you move your cursor, the highlights will be cleared (the second autocommand).
					local client = vim.lsp.get_client_by_id(event.data.client_id)
					if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
						local highlight_augroup =
							vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
						vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.document_highlight,
						})

						vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.clear_references,
						})

						vim.api.nvim_create_autocmd("LspDetach", {
							group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
							callback = function(event2)
								vim.lsp.buf.clear_references()
								vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
							end,
						})
					end

					-- The following code creates a keymap to toggle inlay hints in your
					-- code, if the language server you are using supports them
					--
					-- This may be unwanted, since they displace some of your code
					if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
						map("<leader>th", function()
							vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
						end, "[T]oggle Inlay [H]ints")
					end
				end,
			})

			local capabilities = require("blink.cmp").get_lsp_capabilities({}, true)

			local servers = {
				lua_ls = {},
				jsonls = {
					settings = {
						json = {
							schemas = require('schemastore').json.schemas(),
							validate = { enable = true },
						},
					},
				},
				yamlls = {
					settings = {
						yaml = {
							schemaStore = {
								-- You must disable built-in schemaStore support if you want to use
								-- this plugin and its advanced options like `ignore`.
								enable = false,
								-- Avoid TypeError: Cannot read properties of undefined (reading 'length')
								url = "",
							},
							schemas = require('schemastore').yaml.schemas(),
							-- schemas = require("schemastore").yaml.schemas(),
							-- ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
						},
					},
				},
			}

			-- local mason = require("mason")
			-- local mason_lspconfig = require("mason-lspconfig")
			-- mason_lspconfig.setup({
			-- 	ensure_installed = vim.tbl_keys(servers or {}),
			-- })
			-- mason_tool_installer.setup({
			-- 	ensure_installed = vim.tbl_keys(formatters or {}),
			-- })
			-- NOTE: `mason-lspconfig` must be setup before servers are configured
			-- require("mason-lspconfig").setup({
			-- 	ensure_installed = {},
			-- 	automatic_installation = {},
			-- 	-- ensure_installed = vim.tbl_keys(servers or {}),
			-- 	-- automatic_installation = vim.tbl_keys(servers or {}),
			-- 	-- automatic_installation = {
			-- 	-- 	exclude = {
			-- 	-- 		"yamlls",
			-- 	-- 		"json_ls",
			-- 	-- 		"lua_ls",
			-- 	-- 	},
			-- 	-- },
			-- })

			-- Must be setup after ``mason-lspconfig``. Doing this with
			-- {@link MasonLspconfigSettings.ensure_installed} and
			-- {@link MasonLspconfigSettings.automatic_installation} excluding
			-- server keys that are not in mason-lspconfig
			local lspconfig = require("lspconfig")
			for server_name, config in pairs(servers) do
				-- This handles overriding only values explicitly passed
				-- by the server configuration above. Useful when disabling
				-- certain features of an LSP (for example, turning off formatting for ts_ls)
				config.capabilities = vim.tbl_deep_extend("force", {}, capabilities, config.capabilities or {})
				lspconfig[server_name].setup(config)
			end
		end,
	},
}