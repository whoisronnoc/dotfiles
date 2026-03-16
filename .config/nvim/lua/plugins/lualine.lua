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

local get_autoformat_status = function()
	local format_status = ""
	if not vim.g.autoformat then
		return ""
	else
		format_status = "󰉼"
	end

	if vim.g.autoformat_imports then
		return format_status .. "󰋺"
	end

	return format_status
end

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
		return ""
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

---@module "lazy"
---@return LazyPluginSpec
return {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		"folke/snacks.nvim",
	},
	lazy = true,
	event = "VeryLazy",
	init = function()
		vim.g.lualine_laststatus = vim.o.laststatus
		if vim.fn.argc(-1) > 0 then
			-- set an empty statusline till lualine loads
			vim.o.statusline = " "
		else
			-- hide the statusline on the starter page
			vim.o.laststatus = 0
		end
	end,
	opts = function()
		-- PERF: we don't need this lualine require madness 🤷
		local lualine_require = require("lualine_require")
		lualine_require.require = require

		vim.o.laststatus = vim.g.lualine_laststatus

		local opts = {
			options = {
				theme = "auto",
				icons_enabled = vim.g.have_nerd_font,
				globalstatus = vim.o.laststatus == 3,
				-- component_separators = vim.g.have_nerd_font and { left = "", right = "" }
				-- 	or { left = "│", right = "│" },
				-- section_separators = vim.g.have_nerd_font and { left = "", right = "" }
				-- 	or { left = "", right = "" },
				-- component_separators = { left = "│", right = "│" },
				component_separators = { left = "", right = "" },
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
						-- "sidekick_terminal",
						-- "neo-tree",
						"OverseerList",
						"OverseerOutput",
					},
					winbar = {},
				},
			},
			sections = {
				lualine_a = { {
					"mode",
					fmt = function(s)
						return mode_map[s] or s
					end,
				} },
				lualine_b = {
					"branch",
					{
						"diff",
						source = function()
							local gitsigns = vim.b.gitsigns_status_dict
							if gitsigns then
								return {
									added = gitsigns.added,
									modified = gitsigns.changed,
									removed = gitsigns.removed,
								}
							end
						end,
					},
				},
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
					"diagnostics",
					"overseer",
					-- This will be replaced by the actual component in the config function
					-- this is registered in `lua/lualine/components`
					"codecompanion",
					Snacks.profiler.status(),
					-- stylua: ignore
					{
						function() return require("noice").api.status.command.get() end,
						cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
						color = function() return { fg = Snacks.util.color("Statement") } end,
					},
					-- stylua: ignore
					{
						function() return require("noice").api.status.mode.get() end,
						cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
						color = function() return { fg = Snacks.util.color("Constant") } end,
					},
					-- stylua: ignore
					{
						function() return "  " .. require("dap").status() end,
						cond = function() return package.loaded["dap"] and require("dap").status() ~= "" end,
						color = function() return { fg = Snacks.util.color("Debug") } end,
					},
					-- stylua: ignore
					{
						require("lazy.status").updates,
						cond = require("lazy.status").has_updates,
						color = function() return { fg = Snacks.util.color("Special") } end,
					},
					{
						"lsp_status_formatted",
						icon = "",
						symbols = {
							spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" },
							done = "✓",
							separator = " ",
						},
						display_names = {
							["null-ls"] = "󰟢",
							-- ["GitHub Copilot"] = "",
							-- copilot = "",
							-- cspell_ls = "",
							tailwindcss = "",
							lua_ls = "",
							stylua = "",
							eslint = "",
							ts_ls = "",
							vue_ls = "",
							jsonls = "󰘦",
							yamlls = "",
							["sonarlint.nvim"] = "",
							js_i18n = "",
							css_variables = "",
							stylelint_lsp = "",
						},
						colors = {
							-- pending = "#aaaaff",
							-- complete = "#ffff00",
							-- clear = "",
							["null-ls"] = "#7c7c7c",
							-- ["GitHub Copilot"] = "#8957e5",
							-- copilot = "#8957e5",
							-- cspell_ls = "#e67e22",
							tailwindcss = "#06b6d4",
							lua_ls = "#428EC4",
							stylua = "#428EC4",
							eslint = "#4b32c3",
							ts_ls = "#3178c6",
							vue_ls = "#41b883",
							jsonls = "#f39c12",
							yamlls = "#f39c12",
							["sonarlint.nvim"] = "#549dd0",
							js_i18n = "#e67e22",
							css_variables = "#1572b6",
							stylelint_lsp = "#1572b6",
						},
					},
					-- {
					-- 	"lsp_status",
					-- 	icon = "", -- 
					-- 	symbols = {
					-- 		spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" },
					-- 		done = "✓",
					-- 		separator = " ",
					-- 	},
					-- 	-- ignore_lsp = { "null-ls", "GitHub Copilot", "tailwindcss", "copilot", "cspell_ls" },
					-- },
					lint_status,
					get_autoformat_status,
					mixed_indent,
					"encoding",
					"fileformat",
					"filetype",
				},
				lualine_y = {
					-- "progress",
					-- { "progress", separator = " ", padding = { left = 1, right = 0 } },
					-- { "location", padding = { left = 0, right = 1 } },
				},
				lualine_z = {
					"location",
					-- function()
					-- 	return " " .. os.date("%R")
					-- end,
				},
			},
			-- inactive_sections = {
			-- 	lualine_a = {},
			-- 	lualine_b = {},
			-- 	lualine_c = { "filename" },
			-- 	lualine_x = { "location" },
			-- 	lualine_y = {},
			-- 	lualine_z = {},
			-- },
			extensions = { "lazy", "mason", "fzf", "neo-tree", "nvim-dap-ui" },
		}

		return opts
	end,
}
