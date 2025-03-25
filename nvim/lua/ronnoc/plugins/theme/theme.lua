local function update_cursor_theme(mode)
	if mode == "dark" then
		vim.cmd.hi("Cursor guifg=black guibg=white")
		vim.cmd.hi("lCursor guifg=black guibg=white")
	else
		vim.cmd.hi("Cursor guifg=white guibg=black")
		vim.cmd.hi("lCursor guifg=white guibg=black")
	end
	-- vim.opt.guicursor = "a:Cursor"
	-- vim.opt.guicursor = "n-v-c:block-Cursor/lCursor,i-ci:hor20-Cursor/lCursor"

	vim.opt.guicursor =
		"n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175"
	-- "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,sm:block"
end

local function should_update_bg_option(mode)
	local current = vim.api.nvim_get_option_value("background", {})
	return current ~= mode
end

return {
	--- @type LazyPluginSpec
	{
		"Mofiqul/vscode.nvim",
		config = function()
			-- Lua:
			-- For dark theme (neovim's default)
			vim.o.background = "dark"
			-- For light theme
			-- vim.o.background = "light"

			local c = require("vscode.colors").get_colors()
			require("vscode").setup({
				-- Alternatively set style in setup
				-- style = 'light'

				-- Enable transparent background
				transparent = true,

				-- Enable italic comment
				italic_comments = true,

				-- Underline `@markup.link.*` variants
				underline_links = true,

				-- Disable nvim-tree background color
				disable_nvimtree_bg = true,

				-- Apply theme colors to terminal
				terminal_colors = true,

				-- Override colors (see ./lua/vscode/colors.lua)
				-- color_overrides = {
				-- 	vscLineNumber = "#FFFFFF",
				-- },

				-- Override highlight groups (see ./lua/vscode/theme.lua)
				group_overrides = {
					-- this supports the same val table as vim.api.nvim_set_hl
					-- use colors from this colorscheme by requiring vscode.colors!
					Cursor = { fg = c.vscDarkBlue, bg = c.vscLightGreen, bold = true },
				},
			})
			require("vscode").load()

			-- load the theme without affecting devicon colors.
			vim.cmd.colorscheme("vscode")
		end,
	},
	-- {
	-- 	"loctvl842/monokai-pro.nvim",
	-- 	dependencies = { "nvim-tree/nvim-web-devicons" },
	-- 	config = function()
	-- 		require("monokai-pro").setup({
	-- 			devicons = true,
	-- 			filter = "spectrum", -- classic | octagon | pro | machine | ristretto | spectrum
	-- 			background_clear = { "toggleterm", "telescope", "notify" },
	-- 		})
	-- 		local mode = "dark"
	-- 		vim.api.nvim_set_option_value("background", mode, {})
	-- 		vim.cmd([[colorscheme monokai-pro-spectrum]])
	-- 		update_cursor_theme(mode)
	-- 	end,
	-- },
	-- --- @type LazyPluginSpec
	-- {
	-- 	"NLKNguyen/papercolor-theme",
	-- },
	--- @type LazyPluginSpec
	{
		"f-person/auto-dark-mode.nvim",
		-- dependencies = {
		-- 	"loctvl842/monokai-pro.nvim",
		-- 	"NLKNguyen/papercolor-theme",
		-- },
		opts = {
			set_dark_mode = function()
				local mode = "dark"
				local should_update = should_update_bg_option(mode)
				if should_update then
					vim.api.nvim_set_option_value("background", mode, {})
					vim.cmd([[colorscheme vscode]])
					update_cursor_theme(mode)
				end
			end,
			set_light_mode = function()
				local mode = "light"
				local should_update = should_update_bg_option(mode)
				if should_update then
					vim.api.nvim_set_option_value("background", mode, {})
					vim.cmd([[colorscheme vscode]])
					update_cursor_theme(mode)
				end
			end,
			update_interval = 5000,
			fallback = "dark",
		},
	},
	-- {
	-- 	"nvimdev/indentmini.nvim",
	-- 	event = "BufEnter",
	-- 	config = function()
	-- 		require("indentmini").setup({
	-- 			char = "▏",
	-- 		})
	-- 		-- Colors are applied automatically based on user-defined highlight groups.
	-- 		vim.cmd.highlight("IndentLine guifg=#123456")
	-- 		-- vim.cmd.highlight("default link IndentLine Comment") -- use comment color
	-- 		-- Current indent line highlight
	-- 		vim.cmd.highlight("IndentLineCurrent guifg=#545680")
	-- 	end,
	-- },
	-- 	{
	-- 		"lukas-reineke/indent-blankline.nvim",
	-- 		main = "ibl",
	-- 		config = function()
	-- 			local highlight = {
	-- 				"CursorColumn",
	-- 				"Whitespace",
	-- 			}
	-- 			require("ibl").setup({
	-- 				indent = { highlight = highlight, char = "" },
	-- 				whitespace = {
	-- 					highlight = highlight,
	-- 					remove_blankline_trail = false,
	-- 				},
	-- 				scope = { enabled = false },
	-- 			})
	-- 		end,
	-- 	},
}
