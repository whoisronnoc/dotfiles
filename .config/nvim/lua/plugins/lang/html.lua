return {
	-- Extend
	{
		"nvim-treesitter/nvim-treesitter",
		optional = true,
		opts = {
			ensure_installed = {
				"html",
				"css",
				"scss",
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
		opts = { ensure_installed = { "prettierd" } },
	},
	{
		"stevearc/conform.nvim",
		optional = true,
		opts = {
			formatters_by_ft = {
				html = { "prettierd" },
				css = { "prettierd" },
			},
		},
	},
}
