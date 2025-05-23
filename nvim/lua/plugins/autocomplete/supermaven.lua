local machine_options = require("core.machine_options")
local enable_supermaven = machine_options:getOption("ai_source") == "supermaven"

return {
	enabled = enable_supermaven,
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
				suggestion_color = "#d160d1",
				cterm = 13,
			},
			-- return true to disable supermaven
			condition = function()
				return string.match(vim.fn.expand("%:t"), "Avante")
			end,
		})
	end,
}
