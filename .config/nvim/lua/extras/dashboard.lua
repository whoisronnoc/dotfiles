--- @module 'lazy'
--- @return LazyPluginSpec[]
return {
	--- @type LazyPluginSpec
	{
		"nvimdev/dashboard-nvim",
		dependencies = { { "nvim-tree/nvim-web-devicons" } },
		-- event = "VimEnter",
		version = "*",
		lazy = false, -- As https://github.com/nvimdev/dashboard-nvim/pull/450, dashboard-nvim shouldn't be lazy-loaded to properly handle stdin.
		opts = function()
			local dir = " " .. vim.fn.getcwd()
			local git_root = vim.fn.fnamemodify(vim.fn.finddir(".git", ".;"), ":h")
			local git_branch = vim.fn.system("git branch --show-current 2> /dev/null | tr -d '\n'")

			if git_root ~= "." then
				dir = dir .. "\n " .. git_root
			end
			dir = dir .. "\n" .. " " .. git_branch

			-- stylua: ignore 
			local jira_ticket = string.match(git_branch, "[A-Za-z]+-[0-9]+")
			local logo = vim.fn.system("figlet " .. (jira_ticket or "neovim") .. " 2> /dev/null")
			-- logo = string.rep("\n", 8) .. logo .. "\n\n"
			-- header = vim.split(logo .. "\n" .. dir, "\n"),
			local opts = {
				theme = "doom",
				hide = {
					-- this is taken care of by lualine
					-- enabling this messes up the actual laststatus setting after loading a file
					statusline = false,
					tabline = false,
				},
				config = {
					-- week_header = {
					-- enable = true,
					-- concat = "concat",
					-- append = { "append" },
					-- },
					-- header = vim.split(logo, "\n"),
					header = vim.split(logo .. "\n" .. dir .. "\n", "\n"),
					center = {
						{
							icon = vim.g.have_nerd_font and " " or "🔍",
							key = "f",
							desc = " Find File",
							action = ":lua Snacks.dashboard.pick('smart', { filter = { cwd = true } })",
						},
						{
							icon = vim.g.have_nerd_font and " " or "📄",
							key = "n",
							desc = " New File",
							action = ":ene | startinsert",
						},
						{
							icon = vim.g.have_nerd_font and " " or "📑",
							key = "r",
							desc = " Recent Files",
							action = ":lua Snacks.dashboard.pick('oldfiles', { filter = { cwd = true } })",
						},
						{
							icon = vim.g.have_nerd_font and " " or "📋",
							key = "g",
							desc = " Find Text",
							action = ":lua Snacks.dashboard.pick('grep', { filter = { cwd = true } })",
						},
						{
							icon = vim.g.have_nerd_font and " " or "⚙ ",
							key = "c",
							desc = " Config",
							action = ":lua Snacks.dashboard.pick('smart', {cwd = vim.fn.stdpath('config')})",
						},
						-- {
						-- 	action = "Telescope find_files",
						-- 	desc = " Find File",
						-- 	icon = vim.g.have_nerd_font and " " or "🔍",
						-- 	key = "f",
						-- },
						-- {
						-- 	action = "ene | startinsert",
						-- 	desc = " New File",
						-- 	icon = vim.g.have_nerd_font and " " or "📄",
						-- 	key = "n",
						-- },
						-- {
						-- 	action = "Neotree reveal",
						-- 	desc = " File Tree",
						-- 	icon = vim.g.have_nerd_font and " " or "📁",
						-- 	key = "\\",
						-- },
						-- {
						-- 	action = "Telescope oldfiles",
						-- 	desc = " Recent Files",
						-- 	icon = vim.g.have_nerd_font and " " or "📑",
						-- 	key = "r",
						-- },
						-- {
						-- 	action = "Telescope live_grep",
						-- 	desc = " Find Text",
						-- 	icon = vim.g.have_nerd_font and " " or "📋",
						-- 	key = "g",
						-- },
						-- {
						-- 	action = function()
						-- 		require("telescope.builtin").find_files({ cwd = vim.fn.stdpath("config") })
						-- 	end,
						-- 	desc = " Config",
						-- 	icon = vim.g.have_nerd_font and " " or "⚙ ",
						-- 	key = "c",
						-- },
						{
							action = "LazyGit",
							desc = " Lazy Git",
							icon = vim.g.have_nerd_font and " " or "⌥ ",
							key = "x",
						},
						{
							action = "Octo pr list",
							desc = " Octo PRs",
							icon = vim.g.have_nerd_font and " " or "⌥ ",
							key = "o",
						},
						{
							action = "Lazy",
							desc = " Lazy",
							icon = vim.g.have_nerd_font and "󰒲 " or "📦 ",
							key = "l",
						},
						{
							icon = vim.g.have_nerd_font and "󱌣 " or "🛠️",
							key = "M",
							desc = " Mason",
							action = ":Mason",
						},
						{
							icon = vim.g.have_nerd_font and "󱌣 " or "🛠️",
							key = "H",
							desc = " MCPHub",
							action = ":MCPHub",
						},
						-- {
						-- 	action = function()
						-- 		require("persistence").load()
						-- 	end,
						-- 	desc = " Session",
						-- 	icon = vim.g.have_nerd_font and " " or "🕓 ",
						-- 	key = "S",
						-- },
						{
							action = function()
								if vim.fn.tabpagenr("$") > 1 then
									vim.api.nvim_input("<cmd>tabclose<cr>")
								else
									vim.api.nvim_input("<cmd>qa<cr>")
								end
							end,
							desc = " Quit",
							icon = vim.g.have_nerd_font and " " or "⎋ ",
							key = "q",
						},
					},
					footer = function()
						local stats = require("lazy").stats()
						local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
						return {
							"⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms",
						}
					end,
				},
			}

			for _, button in ipairs(opts.config.center) do
				button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
				button.key_format = "  %s"
			end

			-- open dashboard after closing lazy
			if vim.o.filetype == "lazy" then
				vim.api.nvim_create_autocmd("WinClosed", {
					pattern = tostring(vim.api.nvim_get_current_win()),
					once = true,
					callback = function()
						vim.schedule(function()
							vim.api.nvim_exec_autocmds("UIEnter", { group = "dashboard" })
						end)
					end,
				})
			end

			return opts
		end,
	},
}
