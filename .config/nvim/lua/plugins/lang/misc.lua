---@module "lazy"
---@return LazyPluginSpec[]
return {
	{
		"nvim-treesitter/nvim-treesitter",
		optional = true,
		opts_extend = { "ensure_installed" },
		opts = {
			ensure_installed = {
				"bash",
				"c",
				"diff",
				"html",
				"json",
				"jsonc",
				"make",
				"markdown",
				"markdown_inline",
				"printf",
				"query",
				"regex",
				"toml",
				"tsx",
				"vim",
				"vimdoc",
				"xml",
				"yaml",
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
		"mason-org/mason-lspconfig.nvim",
		optional = true,
		opts_extend = { "ensure_installed" },
		opts = {
			ensure_installed = {
				"texlab",
				"prettierd",
				"eslint_d",
				"xmlformatter",
				"commitlint",
				"sonarlint-language-server",
			},
		},
	},
}
