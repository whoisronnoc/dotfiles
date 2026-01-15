---@module "lazy"
---@type LazyPluginSpec
return {
	"folke/snacks.nvim",
	optional = true,
	--- @module 'snacks'
	--- @type snacks.Config
	opts = {
		bigfile = { enabled = false },
		indent = {
			enabled = true,
			animate = { enabled = false },
		},
		input = { enabled = true },
		notifier = {
			enabled = true,
			timeout = 3000,
		},
		dim = {
			animate = { enabled = false },
		},
		quickfile = { enabled = true },
		scope = { enabled = false },
		statuscolumn = { enabled = false },
		image = { enabled = true },
		-- Disabled modules
		scroll = { enabled = false },
		-- styles = {
		-- 	notification = {
		-- 		-- wo = { wrap = true } -- Wrap notifications
		-- 	},
		-- },
	},
  -- stylua: ignore
	keys = {
		-- Top Pickers & Explorer
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
		{ "<leader>sll", function() Snacks.picker.loclist() end, desc = "Location List" },
		{ "<leader>sm", function() Snacks.picker.marks() end, desc = "Marks" },
		{ "<leader>sM", function() Snacks.picker.man() end, desc = "Man Pages" },
		{ "<leader>sp", function() Snacks.picker.lazy() end, desc = "Search for Plugin Spec" },
		{ "<leader>sq", function() Snacks.picker.qflist() end, desc = "Quickfix List" },
		{ "<leader>sR", function() Snacks.picker.resume() end, desc = "Resume" },
		{ "<leader>su", function() Snacks.picker.undo() end, desc = "Undo History" },
		{ "<leader>uC", function() Snacks.picker.colorschemes() end, desc = "Colorschemes" },
		{ "<leader>sf", function() Snacks.picker.smart() end, desc = "Smart Find Files" },
		{ "<leader>st", function() Snacks.picker.todo_comments() end, desc = "Search Todo Comments" }, --- @diagnostic disable-line: undefined-field
    -- 
  	{ "<leader>z",  function() Snacks.zen() end, desc = "Toggle Zen Mode" },
		{ "<leader>Z",  function() Snacks.zen.zoom() end, desc = "Toggle Zoom" },
		{ "<leader>.",  function() Snacks.scratch() end, desc = "Toggle Scratch Buffer" },
		{ "<leader>S",  function() Snacks.scratch.select() end, desc = "Select Scratch Buffer" },
		{ "<leader>n",  function() Snacks.notifier.show_history() end, desc = "Notification History" },
		{ "<leader>bd", function() Snacks.bufdelete() end, desc = "Delete Buffer" },
		{ "<leader>cR", function() Snacks.rename.rename_file() end, desc = "Rename File" },
		{ "<leader>gB", function() Snacks.gitbrowse() end, desc = "Git Browse", mode = { "n", "v" } },
		{ "<leader>lg", function() Snacks.lazygit() end, desc = "Lazygit" },
		{ "<leader>un", function() Snacks.notifier.hide() end, desc = "Dismiss All Notifications" },
		{ "<c-/>",      function() Snacks.terminal() end, desc = "Toggle Terminal" },
		{ "<c-_>",      function() Snacks.terminal() end, desc = "which_key_ignore" },
		{ "<leader>N", desc = "Neovim News", function()
			Snacks.win({
				file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
				width = 0.6,
				height = 0.6,
				wo = {
					spell = false,
					wrap = false,
					signcolumn = "yes",
					statuscolumn = " ",
					conceallevel = 3,
				},
			})
		end }
	},
	init = function()
		vim.api.nvim_create_autocmd("User", {
			pattern = "VeryLazy",
			callback = function()
				-- Setup some globals for debugging (lazy-loaded)
				_G.dd = function(...)
					Snacks.debug.inspect(...)
				end
				_G.bt = function()
					Snacks.debug.backtrace()
				end
				-- Override print to use snacks for `:=` command
				if vim.fn.has("nvim-0.11") == 1 then
					vim._print = function(_, ...)
						_G.dd(...)
					end
				else
					vim.print = _G.dd
				end

				require("plugins.snacks.progress.notify").create_autocmd()

        -- Create some toggle mappings
        -- stylua: ignore start
        -- Snacks.toggle.option("spell", { name = "[s]pelling" }):map("<leader>ts")
        Snacks.toggle.option("wrap", { name = "[w]rap" }):map("<leader>tw")
        Snacks.toggle.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map("<leader>tc")
        Snacks.toggle.option("mousescroll", { off = "ver:3,hor:0", on = "ver3,hor:1", name = "Horizontal Scroll" }):map("<leader>tm")

        Snacks.toggle.line_number():map("<leader>tl")
        Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>tL")

        Snacks.toggle.diagnostics():map("<leader>td")
        Snacks.toggle.treesitter():map("<leader>tT")
        Snacks.toggle.inlay_hints():map("<leader>th")

        Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark [b]ackground" }):map("<leader>tb")
				-- stylua: ignore end

				Snacks.toggle
					.new({
						id = "toggle_autoformat",
						name = "Auto [f]ormat",
						get = function()
							return vim.g.autoformat
						end,
						set = function(state)
							vim.g.autoformat = state
						end,
					})
					:map("<leader>tf")
			end,
		})
	end,
}
