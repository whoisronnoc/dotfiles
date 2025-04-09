local default_mode = "dark"
local theme_light = "vscode"
local theme_dark = "vscode"

local function update_theme(mode)
	vim.api.nvim_set_option_value("background", mode, {})

	if mode == "dark" then
		vim.cmd.colorscheme(theme_dark)

		vim.cmd.hi("Cursor guifg=black guibg=white")
		vim.cmd.hi("lCursor guifg=black guibg=white")
	else
		vim.cmd.colorscheme(theme_light)

		vim.cmd.hi("Cursor guifg=white guibg=lightgrey")
		vim.cmd.hi("lCursor guifg=white guibg=lightgrey")

		vim.cmd.hi("NeoTreeNormal guibg=lightgrey")
		vim.cmd.hi("NeoTreeNormalNC guibg=lightgrey")
		vim.cmd.hi("NeoTreeVertSplit guibg=lightgrey")
	end

	vim.opt.guicursor =
		"n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175"
end

local function should_update_bg_option(mode)
	local current = vim.api.nvim_get_option_value("background", {})
	return current ~= mode
end

return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		enabled = false,
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				flavour = "auto", -- latte, frappe, macchiato, mocha
				background = { -- :h background
					light = "latte",
					dark = "mocha",
				},
				custom_highlights = function(colors)
					return {
						NeoTreeDirectoryIcon = { fg = colors.yellow },
						NeoTreeDirectoryName = { fg = colors.yellow },
					}
				end,
			})
			update_theme(default_mode)
		end,
	},
	{
		"sainnhe/sonokai",
		enabled = false,
		config = function()
			vim.api.nvim_create_autocmd("ColorScheme", {
				group = vim.api.nvim_create_augroup("custom_highlights_sonokai", {}),
				pattern = "sonokai",
				callback = function()
					local config = vim.fn["sonokai#get_configuration"]()
					local palette = vim.fn["sonokai#get_palette"](config.style, config.colors_override)
					local set_hl = vim.fn["sonokai#highlight"]

					set_hl("Directory", palette.none, palette.none)
					set_hl("Title", palette.none, palette.none)
				end,
			})

			vim.g.sonokai_style = "atlantis"
			update_theme(default_mode)
		end,
	},
	{
		"EdenEast/nightfox.nvim",
		enabled = false,
		config = function()
			require("nightfox").setup({})
			update_theme(default_mode)
		end,
	},
	{
		"projekt0n/github-nvim-theme",
		name = "github-theme",
		enabled = false,
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			require("github-theme").setup({})
			update_theme(default_mode)
		end,
	},
	--- @type LazyPluginSpec
	{
		"Mofiqul/vscode.nvim",
		enabled = true,
		dependencies = {
			-- "nvim-tree/nvim-web-devicons",
			-- "nvim-neo-tree/neo-tree.nvim",
		},
		config = function()
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

					GitSignsCurrentLineBlame = { fg = "#a0a0a0" },

					-- Normal = { bg = "#181818" },
					-- StatusLine = { bg = "#181818" },
					-- StatusLineNC = { bg = "#181818" },
				},
			})
			require("vscode").load()
			update_theme(default_mode)
		end,
	},
	{
		"f-person/auto-dark-mode.nvim",
		event = "VeryLazy",
		opts = {
			set_dark_mode = function()
				local mode = "dark"
				local should_update = should_update_bg_option(mode)
				if should_update then
					update_theme(mode)
				end
			end,
			set_light_mode = function()
				local mode = "light"
				local should_update = should_update_bg_option(mode)
				if should_update then
					update_theme(mode)
				end
			end,
			update_interval = 5000,
			fallback = "dark",
		},
	},
	{
		"nvim-tree/nvim-web-devicons",
		lazy = true,
		event = "VeryLazy",
		config = function()
			require("nvim-web-devicons").setup({
				color_icons = true,
				default = true,
			})
		end,
	},
}
