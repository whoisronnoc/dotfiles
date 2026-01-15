return {
	"pwntester/octo.nvim",
	requires = {
		"nvim-lua/plenary.nvim",
		-- "nvim-telescope/telescope.nvim",
		"nvim-tree/nvim-web-devicons",
	},
	lazy = true,
	cmd = "Octo",
	config = function()
		vim.treesitter.language.register("markdown", "octo")

		require("octo").setup({
			picker = "snacks", -- "telescope" or "fzf-lua" or "snacks"
		})
	end,
}
