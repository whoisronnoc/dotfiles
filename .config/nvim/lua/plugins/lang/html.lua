return {
	-- Extend
	{
		"nvim-treesitter/nvim-treesitter",
		optional = true,
		opts_extend = { "ensure_installed" },
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
		"mason-org/mason-lspconfig.nvim",
		optional = true,
		opts_extend = { "ensure_installed" },
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
