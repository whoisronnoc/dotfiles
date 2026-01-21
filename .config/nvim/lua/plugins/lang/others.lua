---@module "lazy"
---@return LazyPluginSpec[]
return {
	{
		"nvim-treesitter/nvim-treesitter",
		optional = true,
		opts = {
			ensure_installed = {
				"bash",
				"c",
				"diff",
				"make",
				"printf",
				"query",
				"regex",
				"vim",
				"vimdoc",
				"swift",
				"graphql",
				"prisma",
				"dockerfile",
				"gitignore",
			},
		},
	},
	{
		"neovim/nvim-lspconfig",
		optional = true,
		opts = {
			servers = {
				sourcekit = {},
				clangd = {},
				gdscript = {},
				graphql = {},
				texlab = {},
			},
		},
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		optional = true,
		opts = {
			ensure_installed = {
				"prettierd",
				"eslint_d",
				"commitlint",
				"texlab",
			},
		},
	},
}
