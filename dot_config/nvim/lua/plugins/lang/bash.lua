return {
	-- MARK: LSP
	{
		"neovim/nvim-lspconfig",
		optional = true,
		opts = {
			servers = {
				bashls = {},
			},
		},
	},
	{
		"mason-org/mason-lspconfig.nvim",
		optional = true,
		opts = {
			ensure_installed = {
				"bashls",
			},
		},
	},
	-- MARK: Formatters
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		optional = true,
		opts = {
			ensure_installed = {
				"shfmt",
			},
		},
	},
}
