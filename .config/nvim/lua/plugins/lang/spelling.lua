return {
	-- Extend
	{
		"neovim/nvim-lspconfig",
		optional = true,
		opts = {
			servers = {
				cspell_ls = {},
			},
		},
	},
	{
		"mason-org/mason-lspconfig.nvim",
		optional = true,
		opts = { ensure_installed = { "cspell_ls" } },
	},
}
