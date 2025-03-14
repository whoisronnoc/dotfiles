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
	{
		"NLKNguyen/papercolor-theme",
		lazy = true,
	},
	{
		"f-person/auto-dark-mode.nvim",
		opts = {
			set_dark_mode = function()
				vim.api.nvim_set_option_value("background", "dark", {})
				vim.cmd([[colorscheme monokai-pro-spectrum]])
			end,
			set_light_mode = function()
				vim.api.nvim_set_option_value("background", "light", {})
				vim.cmd([[colorscheme PaperColor]])
			end,
			update_interval = 3000,
			fallback = "dark",
		},
	},
}
