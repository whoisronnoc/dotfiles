return {
	{
		"loctvl842/monokai-pro.nvim",
		priority = 1000,
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("monokai-pro").setup({
				devicons = true,
				filter = "spectrum", -- classic | octagon | pro | machine | ristretto | spectrum
				background_clear = { "toggleterm", "telescope", "notify" },
			})
			vim.cmd([[colorscheme monokai-pro]])
		end,
	},
}
