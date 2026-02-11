---@module "lazy"
---@return LazyPluginSpec[]
return {

	-- MARK: DAP
	{
		"mxsdev/nvim-dap-vscode-js",
		enabled = function()
			return Utils.lazy:has_plugin("nvim-dap")
		end,
		version = false,
		lazy = true,
		event = "LazyDap",
		config = function()
			require("dap-vscode-js").setup({
				debugger_path = vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter",
				debugger_cmd = { "js-debug-adapter" },
				adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" },
			})

			local dap = require("dap")

			for _, adapterType in ipairs({ "node", "chrome", "msedge" }) do
				local pwaType = "pwa-" .. adapterType

				dap.adapters[pwaType] = {
					type = "server",
					host = "localhost",
					port = "${port}",
					executable = {
						command = "node",
						args = {
							vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
							"${port}",
						},
					},
				}

				-- this allow us to handle launch.json configurations
				-- which specify type as "node" or "chrome" or "msedge"
				dap.adapters[adapterType] = function(cb, config)
					local nativeAdapter = dap.adapters[pwaType]

					config.type = pwaType

					if type(nativeAdapter) == "function" then
						nativeAdapter(cb, config)
					else
						cb(nativeAdapter)
					end
				end
			end

			-- for _, adapter in pairs({ "pwa-node", "pwa-chrome" }) do
			-- 	dap.adapters[adapter] = {
			-- 		type = "server",
			-- 		host = "localhost",
			-- 		port = "${port}",
			-- 		executable = {
			-- 			command = "js-debug-adapter",
			-- 			args = { "${port}" },
			-- 		},
			-- 	}
			-- end

			-- language config
			for _, language in ipairs({ "typescript", "javascript", "typescriptreact", "javascriptreact", "vue" }) do
				dap.configurations[language] = {
					{
						name = "Launch",
						type = "pwa-node",
						request = "launch",
						program = "${file}",
						rootPath = "${workspaceFolder}",
						cwd = "${workspaceFolder}",
						sourceMaps = true,
						skipFiles = { "<node_internals>/**" },
						protocol = "inspector",
						console = "integratedTerminal",
					},
					{
						name = "Attach to node process",
						type = "pwa-node",
						request = "attach",
						rootPath = "${workspaceFolder}",
						processId = require("dap.utils").pick_process,
					},
					{
						name = "Attach to chrome process",
						type = "pwa-chrome",
						request = "attach",
						rootPath = "${workspaceFolder}",
						processId = require("dap.utils").pick_process,
					},
					{
						type = "pwa-chrome",
						request = "launch",
						name = "Launch Chrome against localhost",
						url = "http://localhost:3000", -- Ensure this matches your dev port
						webRoot = "${workspaceFolder}",
						sourceMaps = true,
						skipFiles = { "<node_internals>/**", "node_modules/**" },
					},
					-- {
					-- 	name = "Debug Main Process (Electron)",
					-- 	type = "pwa-node",
					-- 	request = "launch",
					-- 	program = "${workspaceFolder}/node_modules/.bin/electron",
					-- 	args = {
					-- 		"${workspaceFolder}/dist/index.js",
					-- 	},
					-- 	outFiles = {
					-- 		"${workspaceFolder}/dist/*.js",
					-- 	},
					-- 	resolveSourceMapLocations = {
					-- 		"${workspaceFolder}/dist/**/*.js",
					-- 		"${workspaceFolder}/dist/*.js",
					-- 	},
					-- 	rootPath = "${workspaceFolder}",
					-- 	cwd = "${workspaceFolder}",
					-- 	sourceMaps = true,
					-- 	skipFiles = { "<node_internals>/**" },
					-- 	protocol = "inspector",
					-- 	console = "integratedTerminal",
					-- },
					-- {
					-- 	name = "Compile & Debug Main Process (Electron)",
					-- 	type = custom_adapter,
					-- 	request = "launch",
					-- 	preLaunchTask = "npm run build-ts",
					-- 	program = "${workspaceFolder}/node_modules/.bin/electron",
					-- 	args = {
					-- 		"${workspaceFolder}/dist/index.js",
					-- 	},
					-- 	outFiles = {
					-- 		"${workspaceFolder}/dist/*.js",
					-- 	},
					-- 	resolveSourceMapLocations = {
					-- 		"${workspaceFolder}/dist/**/*.js",
					-- 		"${workspaceFolder}/dist/*.js",
					-- 	},
					-- 	rootPath = "${workspaceFolder}",
					-- 	cwd = "${workspaceFolder}",
					-- 	sourceMaps = true,
					-- 	skipFiles = { "<node_internals>/**" },
					-- 	protocol = "inspector",
					-- 	console = "integratedTerminal",
					-- },
				}
			end
		end,
		dependencies = {
			"mfussenegger/nvim-dap",
			dependencies = {
				{
					"jay-babu/mason-nvim-dap.nvim",
				},
			},
			{
				"WhoIsSethDaniel/mason-tool-installer.nvim",
				optional = true,
				opts = {
					ensure_installed = {
						"js-debug-adapter",
					},
				},
			},

			-- stylua: ignore
			-- keys = {
			-- 	{ "<leader>dPt", function() require('dap-python').test_method() end, desc = "Debug Method", ft = "python" },
			-- 	{ "<leader>dPc", function() require('dap-python').test_class() end,  desc = "Debug Class",  ft = "python" },
			-- },
		},
	},

	-- MARK: Treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		optional = true,
		opts = {
			ensure_installed = {
				"javascript",
				"typescript",
				"tsx",
				"jsdoc",
				"vue",
				"angular",
			},
		},
	},

	-- MARK: LSP
	{
		"neovim/nvim-lspconfig",
		optional = true,
		opts = {
			servers = {
				eslint = {},
				ts_ls = {},
				vue_ls = {},
				angularls = {},
			},
		},
	},
	{
		"mason-org/mason-lspconfig.nvim",
		optional = true,
		opts = {
			ensure_installed = {
				"eslint",
				"ts_ls",
				"vue_ls",
				"angularls",
			},
		},
	},

	-- MARK: Formatters
	{
		"stevearc/conform.nvim",
		optional = true,
		opts = {
			formatters_by_ft = {
				-- You can use 'stop_after_first' to run the first available formatter from the list
				javascript = { "prettierd", "prettier", stop_after_first = true },
				typescript = { "prettierd", "prettier", stop_after_first = true },
				vue = { "prettierd", "prettier", stop_after_first = true },
				javascriptreact = { "prettierd" },
				typescriptreact = { "prettierd" },
			},
		},
	},

	-- MARK: Other JS/TS Plugins
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
			vim.keymap.set({ "n" }, "<LEADER>ns", require("package-info").show,
				{ desc = "Show dependency versions", silent = true, noremap = true })
			vim.keymap.set({ "n" }, "<LEADER>nc", require("package-info").hide,
				{ desc = "Hide dependency versions", silent = true, noremap = true })
			-- vim.keymap.set({ "n" }, "<LEADER>nt", require("package-info").toggle, { desc = "Toggle dependency versions", silent = true, noremap = true })
			vim.keymap.set({ "n" }, "<LEADER>nu", require("package-info").update,
				{ desc = "Update dependency on the line", silent = true, noremap = true })
			vim.keymap.set({ "n" }, "<LEADER>nd", require("package-info").delete,
				{ desc = "Delete dependency on the line", silent = true, noremap = true })
			vim.keymap.set({ "n" }, "<LEADER>ni", require("package-info").install,
				{ desc = "Install a new dependency", silent = true, noremap = true })
			vim.keymap.set({ "n" }, "<LEADER>np", require("package-info").change_version,
				{ desc = "Install a different dependency version", silent = true, noremap = true })
		end,
	},
}
