return {
	{
		"MeanderingProgrammer/render-markdown.nvim",
		event = "VeryLazy",
		enabled = true,
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
		---@module 'render-markdown'
		---@type render.md.UserConfig
		opts = {
			file_types = {
				"markdown",
				"codecompanion",
				"Avante",
			},
			bullet = {
				right_pad = 1,
			},
			code = {
				language_name = false,
				language_icon = false,
			},
		},
		ft = { "markdown", "Avante" },
	},
	-- Extend
	{
		"nvim-treesitter/nvim-treesitter",
		optional = true,
		opts = {
			ensure_installed = {
				"markdown",
				-- "markdown-inline",
			},
		},
	},
}
