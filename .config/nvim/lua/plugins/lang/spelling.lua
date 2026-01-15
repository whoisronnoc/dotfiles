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
		opts_extend = { "ensure_installed" },
		opts = { ensure_installed = { "cspell_ls" } },
	},
}
