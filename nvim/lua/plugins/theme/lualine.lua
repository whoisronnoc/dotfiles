-- https://github.com/nvim-lualine/lualine.nvim/wiki/Component-snippets#mixed-indent
local function mixed_indent()
	local shift_width = vim.opt.shiftwidth:get()
	local space_pat = [[\v^ +]]
	local tab_pat = [[\v^\t+]]
	local space_indent = vim.fn.search(space_pat, "nwc")
	local tab_indent = vim.fn.search(tab_pat, "nwc")
	local mixed = (space_indent > 0 and tab_indent > 0)
	local mixed_same_line
	if not mixed then
		mixed_same_line = vim.fn.search([[\v^(\t+ | +\t)]], "nwc")
		mixed = mixed_same_line > 0
	end
	if not mixed then
		if tab_indent > 0 then
			return ""
		end
		if space_indent > 0 then
			return "󱁐 " .. shift_width
		end
		return "not"
	end
	if mixed_same_line ~= nil and mixed_same_line > 0 then
		return "󱁐 "
	end
	local space_indent_cnt = vim.fn.searchcount({ pattern = space_pat, max_count = 1e3 }).total
	local tab_indent_cnt = vim.fn.searchcount({ pattern = tab_pat, max_count = 1e3 }).total
	if space_indent_cnt > tab_indent_cnt then
		return " 󱁐"
	else
		return "󱁐 "
	end
end

local function lint_status()
	local ok, linters = pcall(require, "lint")
	if not ok then
		return ""
	end

	if #linters == 0 then
		return "󰦕"
	end
	return "󱉶 " .. table.concat(linters, ", ")
end

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
					statusline = {
						"dashboard",
						"alpha",
						"ministarter",
						"snacks_dashboard",
						"Avante",
						-- "AvanteInput",
						"AvanteSelectedFiles",
						"codecompanion",
						"snacks_picker_list",
					},
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
						require("mcphub.extensions.lualine"),
						cond = function()
							local ok, avante = pcall(require, "avante")
							if ok then
								if avante.get() then
									return avante.get():is_open()
								end
							end
							return false
						end,
					},
					{
						lazy_status.updates,
						cond = lazy_status.has_updates,
						color = {
							fg = "#ff9e64",
						},
					},
					"rest",
					"codecompanion",
					-- "lsp_status",
					{
						"lsp_status",
						icon = "",
						symbols = {
							spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" },
							done = "✓",
							separator = " ",
						},
						ignore_lsp = { "null-ls", "GitHub Copilot" },
					},
					lint_status,
					mixed_indent,
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
