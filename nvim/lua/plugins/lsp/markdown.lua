local obsidan_vault = "~/dev/ronnocwiki/RonnocWiki"

--- @module 'lazy'
return {
	{
		"epwalsh/obsidian.nvim",
		version = "*", -- recommended, use latest release instead of latest commit
		lazy = true,
		ft = "markdown",
		-- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
		event = {
			-- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
			-- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
			-- refer to `:h file-pattern` for more examples
			"BufReadPre "
				.. vim.fn.expand(obsidan_vault)
				.. "/*.md",
		},
		keys = {
			{ "<leader>ol", "<cmd>ObsidianLinks<cr> ", desc = "Obsidian links" },
			{ "<leader>ob", "<cmd>ObsidianBacklinks<cr> ", desc = "Obsidian backlinks" },
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
			"saghen/blink.cmp",
		},
		opts = {
			workspaces = {
				{
					name = "personal",
					path = obsidan_vault,
				},
			},
		},
	},
	{
		"MeanderingProgrammer/render-markdown.nvim",
		event = "VeryLazy",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
		---@module 'render-markdown'
		---@type render.md.UserConfig
		opts = {
			file_types = { "markdown", "Avante" },
			bullet = {
				right_pad = 1,
			},
		},
		ft = { "markdown", "Avante" },
	},
}
