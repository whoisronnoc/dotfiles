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
				component_separators = { left = "│", right = "│" },
				section_separators = { left = "", right = "" },
				disabled_filetypes = {
					statusline = { "dashboard", "alpha", "ministarter", "snacks_dashboard" },
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
				lualine_b = { "branch" },
				lualine_c = {
					"diagnostics",
					"filetype",
					"filename",
				},
				lualine_x = {
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
						"diff",
						-- symbols = {
						-- 	added = icons.git.added,
						-- 	modified = icons.git.modified,
						-- 	removed = icons.git.removed,
						-- },
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
					lint_status,
					mixed_indent,
					"encoding",
					"fileformat",
					"filetype",
				},
				lualine_y = {
					"progress",
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
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { "filename" },
				lualine_x = { "location" },
				lualine_y = {},
				lualine_z = {},
			},
			extensions = { "lazy", "mason", "fzf", "neo-tree", "nvim-dap-ui" },
		}

		return opts
	end,
	-- config = function(_, opts)
	-- 	local lualine = require("lualine")
	-- 	-- if enable_ai then
	-- 	-- local mcp_hub = {
	-- 	-- 	require("mcphub.extensions.lualine"),
	-- 	-- 	cond = function()
	-- 	-- 		local ok, avante = pcall(require, "avante")
	-- 	-- 		if ok then
	-- 	-- 			if avante.get() then
	-- 	-- 				return avante.get():is_open()
	-- 	-- 			end
	-- 	-- 		end
	-- 	-- 		return false
	-- 	-- 	end,
	-- 	-- }
	-- 	-- table.insert(opts.sections.lualine_x, 1, mcp_hub)
	-- 	-- end
	--
	-- 	lualine.setup(opts)
	--
	-- 	if theme_dark == "vscode" then
	-- 		vim.cmd("hi! lualine_a_normal guifg=#000000 guibg=#51A2FF")
	-- 		vim.cmd("hi! lualine_b_normal guifg=#51A2FF")
	-- 	end
	-- end,
}
