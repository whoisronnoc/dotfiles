-- https://github.com/nvim-lualine/lualine.nvim
return {
	"nvim-lualine/lualine.nvim",
	event = "VimEnter",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local config = require("vscode.config")
		local vscode = {}
		local colors = {}

		if vim.o.background == "dark" then
			colors.inactive = "#666666"
			colors.bg = "#262626"
			colors.bg2 = "#373737"
			colors.fg = "#ffffff"
			colors.red = "#f44747"
			colors.green = "#4EC9B0"
			colors.blue = "#00a0ff"
			colors.lightblue = "#5CB6F8"
			colors.yellow = "#ffaf00"
			colors.pink = "#DDB6F2"
		else
			colors.inactive = "#888888"
			colors.bg = "#F5F5F5"
			colors.bg2 = "#E4E4E4"
			colors.fg = "#343434"
			colors.red = "#FF0000"
			colors.green = "#008000"
			colors.blue = "#AF00DB"
			colors.lightblue = "#0451A5"
			colors.yellow = "#c08000"
			colors.pink = "#FFA3A3"
		end

		vscode.normal = {
			a = { fg = vim.o.background == "dark" and colors.bg or colors.bg, bg = colors.blue, gui = "bold" },
			b = { fg = colors.blue, bg = config.opts.transparent and "NONE" or colors.bg2 },
			c = { fg = colors.fg, bg = config.opts.transparent and "NONE" or colors.bg },
		}

		vscode.visual = {
			a = { fg = colors.bg, bg = colors.yellow, gui = "bold" },
			b = { fg = colors.yellow, bg = config.opts.transparent and "NONE" or colors.bg },
		}

		vscode.inactive = {
			a = { fg = colors.fg, bg = colors.bg, gui = "bold" },
			b = { fg = colors.inactive, bg = config.opts.transparent and "NONE" or colors.bg },
			c = { fg = colors.inactive, bg = config.opts.transparent and "NONE" or colors.bg },
		}

		vscode.replace = {
			a = { fg = vim.o.background == "dark" and colors.bg or colors.fg, bg = colors.red, gui = "bold" },
			b = { fg = colors.red, bg = config.opts.transparent and "NONE" or colors.bg2 },
			c = { fg = colors.fg, bg = config.opts.transparent and "NONE" or colors.bg },
		}

		vscode.insert = {
			a = { fg = colors.bg, bg = colors.green, gui = "bold" },
			b = { fg = colors.green, bg = config.opts.transparent and "NONE" or colors.bg2 },
			c = { fg = colors.fg, bg = config.opts.transparent and "NONE" or colors.bg },
		}

		vscode.terminal = {
			a = { fg = vim.o.background == "dark" and colors.bg or colors.fg, bg = colors.green, gui = "bold" },
			b = { fg = colors.fg, bg = config.opts.transparent and "NONE" or colors.bg2 },
			c = { fg = colors.fg, bg = config.opts.transparent and "NONE" or colors.bg },
		}

		vscode.command = {
			a = { fg = vim.o.background == "dark" and colors.bg or colors.fg, bg = colors.pink, gui = "bold" },
			b = { fg = colors.pink, bg = config.opts.transparent and "NONE" or colors.bg2 },
			c = { fg = colors.fg, bg = config.opts.transparent and "NONE" or colors.bg },
		}

		local mode_map = {
			["NORMAL"] = "N",
			["O-PENDING"] = "N?",
			["INSERT"] = "I",
			["VISUAL"] = "V",
			["V-BLOCK"] = "VB",
			["V-LINE"] = "VL",
			["V-REPLACE"] = "VR",
			["REPLACE"] = "R",
			["COMMAND"] = "!",
			["SHELL"] = "SH",
			["TERMINAL"] = "T",
			["EX"] = "X",
			["S-BLOCK"] = "SB",
			["S-LINE"] = "SL",
			["SELECT"] = "S",
			["CONFIRM"] = "Y?",
			["MORE"] = "M",
		}

		local lualine = require("lualine")
		local lazy_status = require("lazy.status") -- to configure lazy pending updates count

		lualine.setup({
			options = {
				icons_enabled = vim.g.have_nerd_font,

				globalstatus = vim.o.laststatus == 3,
				component_separators = { left = "│", right = "│" },
				section_separators = { left = "", right = "" },
				disabled_filetypes = {
					statusline = { "dashboard", "alpha", "ministarter", "snacks_dashboard" },
					winbar = {},
				},

				theme = vscode,
			},
			sections = {
				lualine_a = { {
					"mode",
					fmt = function(s)
						return mode_map[s] or s
					end,
				} },
				-- lualine_a = {
				-- 	{
				-- 		"mode",
				-- 		fmt = function(res)
				-- 			return res:sub(1, 1)
				-- 		end,
				-- 	},
				-- },
				lualine_x = {
					{
						lazy_status.updates,
						cond = lazy_status.has_updates,
						color = {
							fg = "#ff9e64",
						},
					},
					"rest",
					"codecompanion",
					"encoding",
					"fileformat",
					"filetype",
				},
				lualine_y = {},
			},
			extensions = { "lazy", "mason", "neo-tree", "nvim-dap-ui" },
		})
	end,
}
