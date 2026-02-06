return {
	"b0o/schemastore.nvim",
	-- Extend
	{
		"nvim-treesitter/nvim-treesitter",
		optional = true,
		opts = {
			ensure_installed = {
				"json",
				"jsonc",
				"yaml",
				"toml",
			},
		},
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		optional = true,
		opts = {
			ensure_installed = {
				"yamllint",
			},
		},
	},
}
