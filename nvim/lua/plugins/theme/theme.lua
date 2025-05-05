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

		if theme_light == "carbide" then
			vim.cmd.hi("NonText guifg=#a8a8a8")
			vim.cmd.hi("Comment guifg=#0B4AED")
		end
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
				-- custom_highlights = function(colors)
				-- 	return {
				-- 		-- NeoTreeDirectoryIcon = { fg = colors.yellow },
				-- 		-- NeoTreeDirectoryName = { fg = colors.yellow },
				-- 		-- NonText = { fg = colors.flamingo },
				-- 	}
				-- end,
				-- highlight_overrides = {
				-- 	all = function(colors)
				-- 		return {
				-- 			NonText = { fg = "#3e4145" },
				-- 			-- CmpBorder = { fg = "#3e4145" },
				-- 		}
				-- 	end,
				-- 	latte = function(latte)
				-- 		return {
				-- 			Normal = { fg = latte.base },
				-- 		}
				-- 	end,
				-- 	frappe = function(frappe)
				-- 		return {
				-- 			["@comment"] = { fg = frappe.surface2, style = { "italic" } },
				-- 		}
				-- 	end,
				-- 	macchiato = function(macchiato)
				-- 		return {
				-- 			LineNr = { fg = macchiato.overlay1 },
				-- 		}
				-- 	end,
				-- 	mocha = function(mocha)
				-- 		return {
				-- 			Comment = { fg = mocha.flamingo },
				-- 		}
				-- 	end,
				-- },

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
						NeoTreeGitIgnored = { fg = colors.text },
						NeoTreeGitModified = { fg = colors.yellow },
						NeoTreeGitRenamed = { fg = colors.yellow },
						NeoTreeGitStaged = { fg = colors.lavender },
						NeoTreeGitUnstaged = { fg = colors.yellow },
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

					-- let palette = {
					-- \ 'black':      ['#181a1c',   '232'],
					-- \ 'bg_dim':     ['#24272e',   '232'],
					-- \ 'bg0':        ['#2a2f38',   '235'],
					-- \ 'bg1':        ['#333846',   '236'],
					-- \ 'bg2':        ['#373c4b',   '236'],
					-- \ 'bg3':        ['#3d4455',   '237'],
					-- \ 'bg4':        ['#424b5b',   '237'],
					-- \ 'bg_red':     ['#ff6d7e',   '203'],
					-- \ 'diff_red':   ['#55393d',   '52'],
					-- \ 'bg_green':   ['#a5e179',   '107'],
					-- \ 'diff_green': ['#394634',   '22'],
					-- \ 'bg_blue':    ['#7ad5f1',   '110'],
					-- \ 'diff_blue':  ['#354157',   '17'],
					-- \ 'diff_yellow':['#4e432f',   '54'],
					-- \ 'fg':         ['#e1e3e4',   '250'],
					-- \ 'red':        ['#ff6578',   '203'],
					-- \ 'orange':     ['#f69c5e',   '215'],
					-- \ 'yellow':     ['#eacb64',   '179'],
					-- \ 'green':      ['#9dd274',   '107'],
					-- \ 'blue':       ['#72cce8',   '110'],
					-- \ 'purple':     ['#ba9cf3',   '176'],
					-- \ 'grey':       ['#828a9a',   '246'],
					-- \ 'grey_dim':   ['#5a6477',   '240'],
					-- \ 'none':       ['NONE',      'NONE']
					-- \ }

					set_hl("Directory", palette.none, palette.none)
					set_hl("Title", palette.none, palette.none)

					set_hl("SnacksPickerDirectory", palette.none, palette.none)
					set_hl("SnacksPickerGitStatusUntracked", palette.green, palette.none)
					set_hl("SnacksPickerPathIgnored", palette.grey, palette.none)
					set_hl("SnacksPickerPathHidden", palette.fg, palette.none)
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
