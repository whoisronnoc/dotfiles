return {
	-- Extend
	{
		"nvim-treesitter/nvim-treesitter",
		optional = true,
		opts = {
			ensure_installed = {
				"xml",
				"html",
				"css",
				"scss",
			},
		},
	},
	{
		"mason-org/mason-lspconfig.nvim",
		optional = true,
		opts = {
			ensure_installed = {
				"html",
				"lemminx",
				"css_variables",
				"stylelint_lsp",
				"cssls",
				"tailwindcss",
			},
		},
	},
	{
		"neovim/nvim-lspconfig",
		optional = true,
		opts = {
			servers = {
				html = {},
				lemminx = {},
				css_variables = {},
				stylelint_lsp = {},
				cssls = {},
				tailwindcss = {},
			},
		},
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		optional = true,
		opts = { ensure_installed = { "prettierd", "xmlformatter" } },
	},
	{
		"stevearc/conform.nvim",
		optional = true,
		opts = {
			formatters_by_ft = {
				html = { "prettierd" },
				css = { "prettierd" },
				xml = { "xmlformatter" },
				scss = { "prettierd" },
				sass = { "prettierd" },
			},
		},
	},
}
