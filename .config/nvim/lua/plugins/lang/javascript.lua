---@module "lazy"
---@return LazyPluginSpec[]
return {
	{
		"nvim-treesitter/nvim-treesitter",
		optional = true,
		opts_extend = { "ensure_installed" },
		opts = {
			ensure_installed = {
				"javascript",
				"typescript",
				"jsdoc",
				"vue",
			},
		},
	},
	{
		"neovim/nvim-lspconfig",
		optional = true,
		opts = {
			servers = {
				ts_ls = {},
				vue_ls = {},
			},
		},
	},
	{
		"mason-org/mason-lspconfig.nvim",
		optional = true,
		opts_extend = { "ensure_installed" },
		opts = {
			ensure_installed = { "ts_ls" },
		},
	},
	{
		"stevearc/conform.nvim",
		optional = true,
		opts = {
			formatters_by_ft = {
				-- You can use 'stop_after_first' to run the first available formatter from the list
				javascript = { "prettierd", "prettier", stop_after_first = true },
				typescript = { "prettierd", "prettier", stop_after_first = true },
				vue = { "prettierd", "prettier", stop_after_first = true },
			},
		},
	},
	{
		"vuki656/package-info.nvim",
		event = "VeryLazy",
		dependencies = { "MunifTanjim/nui.nvim" },
		config = function()
			require("package-info").setup({
				-- colors = {
				-- 	up_to_date = "#3C4048", -- Text color for up to date dependency virtual text
				-- 	outdated = "#d19a66", -- Text color for outdated dependency virtual text
				-- 	invalid = "#ee4b2b", -- Text color for invalid dependency virtual text
				-- },
				icons = {
					enable = true, -- Whether to display icons
					style = {
						up_to_date = "|  ", -- Icon for up to date dependencies
						outdated = "|  ", -- Icon for outdated dependencies
						invalid = "|  ", -- Icon for invalid dependencies
					},
				},
				notifications = true, -- Whether to display notifications when running commands
				autostart = true, -- Whether to autostart when `package.json` is opened
				hide_up_to_date = true, -- It hides up to date versions when displaying virtual text
				hide_unstable_versions = true, -- It hides unstable versions from version list e.g next-11.1.3-canary3
				-- Can be `npm`, `yarn`, or `pnpm`. Used for `delete`, `install` etc...
				-- The plugin will try to auto-detect the package manager based on
				-- `yarn.lock` or `package-lock.json`. If none are found it will use the
				-- provided one, if nothing is provided it will use `yarn`
				package_manager = "npm",
			})

		-- stylua: ignore start
		vim.keymap.set({ "n" }, "<LEADER>ns", require("package-info").show, { desc = "Show dependency versions", silent = true, noremap = true })
		vim.keymap.set({ "n" }, "<LEADER>nc", require("package-info").hide, { desc = "Hide dependency versions", silent = true, noremap = true })
		-- vim.keymap.set({ "n" }, "<LEADER>nt", require("package-info").toggle, { desc = "Toggle dependency versions", silent = true, noremap = true })
		vim.keymap.set({ "n" }, "<LEADER>nu", require("package-info").update, { desc = "Update dependency on the line", silent = true, noremap = true })
		vim.keymap.set({ "n" }, "<LEADER>nd", require("package-info").delete, { desc = "Delete dependency on the line", silent = true, noremap = true })
		vim.keymap.set({ "n" }, "<LEADER>ni", require("package-info").install, { desc = "Install a new dependency", silent = true, noremap = true })
		vim.keymap.set({ "n" }, "<LEADER>np", require("package-info").change_version, { desc = "Install a different dependency version", silent = true, noremap = true })
		end,
	},
}
