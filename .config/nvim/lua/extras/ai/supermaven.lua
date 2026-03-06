return {
	"supermaven-inc/supermaven-nvim",
	config = function()
		require("supermaven-nvim").setup({
			keymaps = {
				accept_suggestion = "<Tab>",
				clear_suggestion = "<C-]>",
				accept_word = "<C-j>",
			},
			log_level = "off",
			-- disable_inline_completion = true,
			color = {
				suggestion_color = "#A0A0A0", -- #d160d1 #6A6A6A,
				cterm = 13,
			},
			-- return true to disable supermaven
			condition = function()
				return string.match(vim.fn.expand("%:t"), "Avante")
			end,
		})
	end,
}
