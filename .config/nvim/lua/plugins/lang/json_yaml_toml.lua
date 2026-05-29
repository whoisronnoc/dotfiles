return {
	-- MARK: Pugins
	"b0o/schemastore.nvim",

	-- MARK: Extend
	-- MARK: Syntax Highlighting
	{
		"nvim-treesitter/nvim-treesitter",
		optional = true,
		opts = {
			ensure_installed = {
				"json",
				"yaml",
				"toml",
				"helm",
			},
		},
	},

	-- MARK: LSP
	{
		"neovim/nvim-lspconfig",
		optional = true,
		opts = {
			servers = {
				jsonls = {},
				yamlls = {},
				helm_ls = {},
				tombi = {},
			},
		},
	},
	{
		"mason-org/mason-lspconfig.nvim",
		optional = true,
		opts = {
			ensure_installed = {
				"jsonls",
				"yamlls",
				"helm_ls",
				"tombi",
			},
		},
	},

	-- MARK: Linters
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		optional = true,
		opts = {
			ensure_installed = {
				"yamllint",
			},
		},
	},

	-- MARK: Formatters
	{
		"stevearc/conform.nvim",
		optional = true,
		opts = {
			formatters_by_ft = {
				json = { "prettierd", "prettier", stop_after_first = true },
				jsonc = { "prettierd", "prettier", stop_after_first = true },
				yaml = { "prettierd", "prettier", stop_after_first = true },
				helm = { "prettierd", "prettier", stop_after_first = true },
			},
		},
	},
}
