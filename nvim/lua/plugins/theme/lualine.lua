-- https://github.com/nvim-lualine/lualine.nvim
return {
	"nvim-lualine/lualine.nvim",
	event = "VimEnter",
	config = function()
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

				theme = "auto",
			},
			sections = {
				lualine_a = { {
					"mode",
					fmt = function(s)
						return mode_map[s] or s
					end,
				} },
				lualine_c = {
					"filename",
					{
						function()
							local ok, screenkey = pcall(require, "screenkey")
							if ok then
								return screenkey.get_keys()
							end
							return ""
						end,
						cond = function()
							local ok, _ = pcall(require, "screenkey")
							return ok
						end,
					},
				},
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
