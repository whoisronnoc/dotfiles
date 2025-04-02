local function update_theme(mode)
	if mode == "dark" then
		vim.cmd.hi("Cursor guifg=black guibg=white")
		vim.cmd.hi("lCursor guifg=black guibg=white")
	else
		vim.cmd.hi("Cursor guifg=white guibg=lightgrey")
		vim.cmd.hi("lCursor guifg=white guibg=lightgrey")

		vim.cmd.hi("NeoTreeNormal guibg=lightgrey")
		vim.cmd.hi("NeoTreeNormalNC guibg=lightgrey")
		vim.cmd.hi("NeoTreeVertSplit guibg=lightgrey")
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
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			"nvim-neo-tree/neo-tree.nvim",
		},
		config = function()
			-- Lua:
			-- For dark theme (neovim's default)
			vim.o.background = "dark"
			-- For light theme
			-- vim.o.background = "light"

			local n = require("neo-tree.ui.highlights")
			local c = require("vscode.colors").get_colors()
			require("vscode").setup({
				-- style = 'light' -- Alternatively set style in setup
				transparent = false, -- Enable transparent background
				italic_comments = true, -- Enable italic comment
				underline_links = true, -- Underline `@markup.link.*` variants
				disable_nvimtree_bg = true, -- Disable nvim-tree background color
				terminal_colors = true, -- Apply theme colors to terminal

				-- Override colors (see ./lua/vscode/colors.lua)
				-- color_overrides = {
				-- vscLineNumber = "#FFFFFF",
				-- },

				-- Override highlight groups (see ./lua/vscode/theme.lua)
				group_overrides = {
					-- this supports the same val table as vim.api.nvim_set_hl
					-- use colors from this colorscheme by requiring vscode.colors!
					Cursor = { fg = c.vscDarkBlue, bg = c.vscLightGreen, bold = true },
					-- NeoTreeDirectoryIcon = { fg = c.vscYellowOrange },
					-- [n.DIRECTORY_NAME] = { fg = c.vscBack },

					-- neo-tree color config
					[n.DIRECTORY_ICON] = { fg = c.vscYellowOrange },
					[n.DIM_TEXT] = { fg = c.vscDimHighlight },
					[n.HIDDEN_BY_NAME] = { fg = c.vscDimHighlight },

					[n.GIT_ADDED] = { fg = c.vscGitAdded },
					[n.GIT_CONFLICT] = { fg = c.vscGitConflicting },
					[n.GIT_DELETED] = { fg = c.vscGitDeleted },
					[n.GIT_IGNORED] = { fg = c.vscGitIgnored },
					[n.GIT_MODIFIED] = { fg = c.vscGitModified },
					[n.GIT_RENAMED] = { fg = c.vscGitRenamed },
					[n.GIT_STAGED] = { fg = c.vscGitStageModified },
					[n.GIT_UNSTAGED] = { fg = c.vscGitStageDeleted },
					[n.GIT_UNTRACKED] = { fg = c.vscGitUntracked },
					[n.GIT_IGNORED] = { fg = c.vscDimHighlight },

					[n.NORMAL] = { bg = "#181818" },
					[n.NORMALNC] = { bg = "#181818" },
					[n.VERTSPLIT] = { fg = "#2b2b2b", bg = "#222222" },

					-- Normal = { bg = "#181818" },
					-- StatusLine = { bg = "#181818" },
					-- StatusLineNC = { bg = "#181818" },
				},
			})
			require("vscode").load()

			local mode = "dark"
			vim.cmd.colorscheme("vscode")
			update_theme(mode)
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
					update_theme(mode)
				end
			end,
			set_light_mode = function()
				local mode = "light"
				local should_update = should_update_bg_option(mode)
				if should_update then
					vim.api.nvim_set_option_value("background", mode, {})
					vim.cmd([[colorscheme vscode]])
					update_theme(mode)
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
