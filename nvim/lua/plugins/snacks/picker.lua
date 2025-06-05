local machine_options = require("core.machine_options")
local explorer = machine_options:getOption("explorer")

return {
	"snacks.nvim",
	--- @module 'snacks'
	--- @type snacks.Config
	opts = {
		explorer = {
			enabled = true,
			replace_netrw = true,
		},
		picker = {
			enabled = true,
			hidden = true,
			ignored = true,
			sources = {
				smart = {
					-- hidden = true,
					-- ignored = true,
				},
				explorer = {
					border = "none",
					-- hidden = true,
					-- ignored = true,
					layout = {
						layout = {
							width = 32,
							backdrop = false,
							min_width = 32,
							height = 0,
							position = "left",
							border = "none",
							box = "vertical",
							-- {
							-- 	win = "input",
							-- 	height = 1,
							-- 	border = "rounded",
							-- 	title = "{title} {live} {flags}",
							-- 	title_pos = "center",
							-- },
							{ win = "list", border = "none" },
							-- { win = "preview", title = "{preview}", height = 0.4, border = "top" },
						},
					},
					win = {
						list = {
							keys = {
								["s"] = "edit_vsplit",
								["S"] = "edit_split",
								["\\"] = "close",
							},
						},
					},
				},
			},
		},
	},
    -- stylua: ignore
  keys = {
		-- Top Pickers & Explorer
    explorer == "snacks" and { "\\", desc = "File Explorer", function()
			local explorer_pickers = Snacks.picker.get({ source = "explorer" })
			if #explorer_pickers == 0 then
				Snacks.picker.explorer()
				-- elseif explorer_pickers[1]:is_focused() then
				-- 	explorer_pickers[1]:close()
			else
				explorer_pickers[1]:focus()
			end
		end } or { "\\\\", desc = "File Explorer", function() end },
		{ "<leader>/", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
		{ "<leader>,", function() Snacks.picker.buffers() end, desc = "Buffers" },
		{ "<leader>:", function() Snacks.picker.command_history() end, desc = "Command History" },
		{ "<leader>n", function() Snacks.picker.notifications() end, desc = "Notification History" },
		-- find
		{ "<leader>fb", function() Snacks.picker.buffers() end, desc = "Buffers" },
		{ "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
		{ "<leader>ff", function() Snacks.picker.files() end, desc = "Find Files" },
		{ "<leader>fg", function() Snacks.picker.git_files() end, desc = "Find Git Files" },
		{ "<leader>fp", function() Snacks.picker.projects() end, desc = "Projects" },
		{ "<leader>fr", function() Snacks.picker.recent() end, desc = "Recent" },
		-- git
		{ "<leader>hgb", function() Snacks.picker.git_branches() end, desc = "Git Branches" },
		{ "<leader>hgl", function() Snacks.picker.git_log() end, desc = "Git Log" },
		{ "<leader>hgL", function() Snacks.picker.git_log_line() end, desc = "Git Log Line" },
		{ "<leader>hgs", function() Snacks.picker.git_status() end, desc = "Git Status" },
		{ "<leader>hgS", function() Snacks.picker.git_stash() end, desc = "Git Stash" },
		{ "<leader>hgd", function() Snacks.picker.git_diff() end, desc = "Git Diff (Hunks)" },
		{ "<leader>hgf", function() Snacks.picker.git_log_file() end, desc = "Git Log File" },
		-- Grep
		{ "<leader>sb", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
		{ "<leader>sB", function() Snacks.picker.grep_buffers() end, desc = "Grep Open Buffers" },
		{ "<leader>sg", function() Snacks.picker.grep() end, desc = "Grep" },
		{ "<leader>sw", function() Snacks.picker.grep_word() end, desc = "Visual selection or word", mode = { "n", "x" } },
		-- search
		{ '<leader>s"', function() Snacks.picker.registers() end, desc = "Registers" },
		{ '<leader>s/', function() Snacks.picker.search_history() end, desc = "Search History" },
		{ "<leader>sa", function() Snacks.picker.autocmds() end, desc = "Autocmds" },
		{ "<leader>sb", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
		{ "<leader>sc", function() Snacks.picker.command_history() end, desc = "Command History" },
		{ "<leader>sC", function() Snacks.picker.commands() end, desc = "Commands" },
		{ "<leader>sd", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
		{ "<leader>sD", function() Snacks.picker.diagnostics_buffer() end, desc = "Buffer Diagnostics" },
		{ "<leader>sh", function() Snacks.picker.help() end, desc = "Help Pages" },
		{ "<leader>sH", function() Snacks.picker.highlights() end, desc = "Highlights" },
		{ "<leader>si", function() Snacks.picker.icons() end, desc = "Icons" },
		{ "<leader>sj", function() Snacks.picker.jumps() end, desc = "Jumps" },
		{ "<leader>sk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
		{ "<leader>sl", function() Snacks.picker.loclist() end, desc = "Location List" },
		{ "<leader>sm", function() Snacks.picker.marks() end, desc = "Marks" },
		{ "<leader>sM", function() Snacks.picker.man() end, desc = "Man Pages" },
		{ "<leader>sp", function() Snacks.picker.lazy() end, desc = "Search for Plugin Spec" },
		{ "<leader>sq", function() Snacks.picker.qflist() end, desc = "Quickfix List" },
		{ "<leader>sR", function() Snacks.picker.resume() end, desc = "Resume" },
		{ "<leader>su", function() Snacks.picker.undo() end, desc = "Undo History" },
		{ "<leader>uC", function() Snacks.picker.colorschemes() end, desc = "Colorschemes" },
		{ "<leader>sf", function() Snacks.picker.smart() end, desc = "Smart Find Files" },
  },
}
