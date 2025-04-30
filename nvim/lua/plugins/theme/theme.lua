local default_mode = "dark"
local theme_light = "catppuccin"
local theme_dark = "sonokai"

local function update_theme(mode)
	vim.api.nvim_set_option_value("background", mode, {})
	-- vim.o.background = mode

	if mode == "dark" then
		vim.cmd.colorscheme(theme_dark)

		vim.cmd.hi("Cursor guifg=black guibg=white")
		vim.cmd.hi("lCursor guifg=black guibg=white")
	else
		vim.cmd.colorscheme(theme_light)
	end

	vim.opt.guicursor =
		"n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175"
end

local function should_update_bg_option(mode)
	local current = vim.api.nvim_get_option_value("background", {})
	return current ~= mode
end

-- stylua: ignore start
function switch_theme(theme)
	if theme == "catppuccin" then
		theme_dark = "catppuccin"
		theme_light = "catppuccin"

	elseif theme == "sonokai" then
		theme_dark = "sonokai"
		theme_light = "sonokai"

	elseif theme == "github" then
		theme_dark = "github_dark_dimmed"
		theme_light = "github_light"

	elseif theme == "nightfox" then
		theme_dark = "carbonfox"
		theme_light = "dayfox"

	elseif theme == "vscode" then
		theme_dark = "vscode"
		theme_light = "vscode"

	end
	update_theme(default_mode)
end

-- map keys to switch themes
vim.keymap.set("n", "<leader>t5", ":lua switch_theme('nightfox')<CR>", { desc = "Theme: nightfox", noremap = true, silent = true })
vim.keymap.set("n", "<leader>t4", ":lua switch_theme('sonokai')<CR>", { desc = "Theme: sonokai", noremap = true, silent = true })
vim.keymap.set("n", "<leader>t3", ":lua switch_theme('catppuccin')<CR>", { desc = "Theme: catppuccin", noremap = true, silent = true })
vim.keymap.set("n", "<leader>t2", ":lua switch_theme('github')<CR>", { desc = "Theme: github", noremap = true, silent = true })
vim.keymap.set("n", "<leader>t1", ":lua switch_theme('vscode')<CR>", { desc = "Theme: vscode", noremap = true, silent = true })
-- stylua: ignore end

return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		enabled = true,
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
		end,
	},
	{
		"sainnhe/sonokai",
		enabled = true,
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
				override_by_extension = {
					-- ["spec.ts"] = {
					-- icon = "",
					-- color = "#f5bc40",
					-- name = "Test",
					-- },
					["stories.js"] = {
						icon = "",
						color = "#eb5685",
						name = "Storybook",
					},
				},
			})
		end,
	},
}
