local machine_options = require("core.machine_options")
local default_mode = machine_options:getOption("theme_default_mode")
local theme_dark = machine_options:getOption("theme_dark")
local theme_light = machine_options:getOption("theme_light")

local function update_theme(mode)
	vim.api.nvim_set_option_value("background", mode, {})

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

return {
	{
		"ferdinandrau/carbide.nvim",
		enabled = theme_light == "carbide",
		priority = 1000,
		opts = { --[[ your options here ]]
			palette_overrides = {
				light = {
					-- bg1 = "#17131C",
					-- bg2 = "#222028",
					-- fgc_green = "#0F5722",
					-- fgc_blue = "#0B4AED",
				},
			},
		},
		config = function(_, opts)
			require("carbide").setup(opts)
			require("carbide").apply()
		end,
	},
	-- {
	-- 	"NLKNguyen/papercolor-theme",
	-- },
	{
		"catppuccin/nvim",
		name = "catppuccin",
		enabled = theme_light == "catppuccin",
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				flavour = "latte", -- latte, frappe, macchiato, mocha
				background = { -- :h background
					light = "latte",
					dark = "mocha",
				},
				custom_highlights = function(colors)
					return {
						-- ["@property"] = { fg = colors.text },

						-- neo-tree color config
						NeoTreeDirectoryIcon = { fg = colors.yellow },
						NeoTreeDirectoryName = { fg = "#000000" },
						NeoTreeFileName = { fg = "#000000" },

						NeoTreeDimText = { fg = colors.crust },
						NeoTreeHiddenByName = { fg = colors.mantle },
						NeoTreeGitAdded = { fg = colors.green },
						NeoTreeGitConflict = { fg = colors.red },
						NeoTreeGitDeleted = { fg = colors.red },
						NeoTreeGitIgnored = { fg = colors.base },
						NeoTreeGitModified = { fg = colors.yellow },
						NeoTreeGitRenamed = { fg = colors.yellow },
						NeoTreeGitStaged = { fg = colors.lavender },
						NeoTreeGitUnstaged = { fg = colors.teal },
						NeoTreeGitUntracked = { fg = colors.green },

						-- NeoTreeNormal = { bg = "#181818" },
						-- NeoTreeNormalNC = { bg = "#181818" },
						-- NeoTreeVertSplit = { fg = "#2b2b2b", bg = "#222222" },
					}
				end,
			})
		end,
	},
	{
		"sainnhe/sonokai",
		enabled = theme_dark == "sonokai",
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
		enabled = theme_dark == "github",
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
		enabled = theme_dark == "vscode",
		dependencies = {
			-- "nvim-tree/nvim-web-devicons",
			-- "nvim-neo-tree/neo-tree.nvim",
		},
		config = function()
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
					GitSignsCurrentLineBlame = { fg = "#a0a0a0" },

					-- neo-tree color config
					NeoTreeDirectoryIcon = { fg = c.vscYellowOrange },
					NeoTreeDimText = { fg = c.vscDimHighlight },
					NeoTreeHiddenByName = { fg = c.vscDimHighlight },
					NeoTreeGitAdded = { fg = c.vscGitAdded },
					NeoTreeGitConflict = { fg = c.vscGitConflicting },
					NeoTreeGitDeleted = { fg = c.vscGitDeleted },
					NeoTreeGitIgnored = { fg = c.vscGitIgnored },
					NeoTreeGitModified = { fg = c.vscGitModified },
					NeoTreeGitRenamed = { fg = c.vscGitRenamed },
					NeoTreeGitStaged = { fg = c.vscGitStageModified },
					NeoTreeGitUnstaged = { fg = c.vscGitStageDeleted },
					NeoTreeGitUntracked = { fg = c.vscGitUntracked },

					NeoTreeNormal = { bg = "#181818" },
					NeoTreeNormalNC = { bg = "#181818" },
					NeoTreeVertSplit = { fg = "#2b2b2b", bg = "#222222" },

					-- snacks picker
					-- SnacksPickerDirectory = { fg = c.vscYellowOrange },
					SnacksPickerGitStatusUntracked = { fg = c.vscGitUntracked },
					SnacksPickerGitStatusIgnored = { fg = c.vscGitIgnored },
					SnacksPickerPathIgnored = { fg = c.vscGitIgnored },
					SnacksPickerPathHidden = { fg = "#bbbbbb" },
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
