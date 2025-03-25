local function update_cursor_theme(mode)
	if mode == "dark" then
		vim.cmd.hi("Cursor guifg=black guibg=white")
		vim.cmd.hi("lCursor guifg=black guibg=white")
	else
		vim.cmd.hi("Cursor guifg=white guibg=black")
		vim.cmd.hi("lCursor guifg=white guibg=black")
	end
	-- vim.opt.guicursor = "a:Cursor"
	vim.opt.guicursor = "n-v-c:block-Cursor/lCursor,i-ci:ver25-Cursor/lCursor"

	-- vim.opt.guicursor =
	-- 	"n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175"
	-- "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,sm:block"
end

local function should_update_bg_option(mode)
	local current = vim.api.nvim_get_option_value("background", {})
	return current ~= mode
end

return {
	--- @type LazyPluginSpec
	{
		"loctvl842/monokai-pro.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("monokai-pro").setup({
				devicons = true,
				filter = "spectrum", -- classic | octagon | pro | machine | ristretto | spectrum
				background_clear = { "toggleterm", "telescope", "notify" },
			})
			local mode = "dark"
			vim.api.nvim_set_option_value("background", mode, {})
			vim.cmd([[colorscheme monokai-pro-spectrum]])
			update_cursor_theme(mode)
		end,
	},
	--- @type LazyPluginSpec
	{
		"NLKNguyen/papercolor-theme",
	},
	--- @type LazyPluginSpec
	{
		"f-person/auto-dark-mode.nvim",
		dependencies = {
			"loctvl842/monokai-pro.nvim",
			"NLKNguyen/papercolor-theme",
		},
		opts = {
			set_dark_mode = function()
				local mode = "dark"
				local should_update = should_update_bg_option(mode)
				if should_update then
					vim.api.nvim_set_option_value("background", mode, {})
					vim.cmd([[colorscheme monokai-pro-spectrum]])
					update_cursor_theme(mode)
				end
			end,
			set_light_mode = function()
				local mode = "light"
				local should_update = should_update_bg_option(mode)
				if should_update then
					vim.api.nvim_set_option_value("background", mode, {})
					vim.cmd([[colorscheme PaperColor]])
					update_cursor_theme(mode)
				end
			end,
			update_interval = 5000,
			fallback = "dark",
		},
	},
}
