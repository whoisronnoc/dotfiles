return {
	{
		"szw/vim-maximizer",
		cmd = "MaximizerToggle",
	},
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"theHamsta/nvim-dap-virtual-text",
			{
				"rcarriga/nvim-dap-ui",
				dependencies = { "nvim-neotest/nvim-nio" },
				keys = {
					{
						"<leader>du",
						function()
							require("dapui").toggle({})
						end,
						desc = "Dap UI",
					},
					{
						"<leader>de",
						function()
							require("dapui").eval()
						end,
						desc = "Eval",
						mode = { "n", "v" },
					},
				},
				-- For more information, see |:help nvim-dap-ui|
				--- @type dapui.Config
				opts = {
					-- Set icons to characters that are more likely to work in every terminal.
					--    Feel free to remove or use ones that you like more! :)
					--    Don't feel like these are good choices.
					icons = vim.g.have_nerd_font and {} or { expanded = "▾", collapsed = "▸", current_frame = "*" },
					controls = {
						icons = vim.g.have_nerd_font and {} or {
							pause = "⏸",
							play = "▶",
							step_into = "⏎",
							step_over = "⏭",
							step_out = "⏮",
							step_back = "b",
							run_last = "▶▶",
							terminate = "⏹",
							disconnect = "⏏",
						},
					},
				},
			},
			config = function(_, opts)
				local dap = require("dap")
				local dapui = require("dapui")
				dapui.setup(opts)

				dap.listeners.after.event_initialized["dapui_config"] = dapui.open
				dap.listeners.before.event_terminated["dapui_config"] = dapui.close
				dap.listeners.before.event_exited["dapui_config"] = dapui.close
			end,

			{
				"LiadOz/nvim-dap-repl-highlights",
				config = true,
				dependencies = {
					"mfussenegger/nvim-dap",
					"nvim-treesitter/nvim-treesitter",
				},
				build = function()
					if not require("nvim-treesitter.parsers").has_parser("dap_repl") then
						-- require("nvim-dap-repl-highlights").setup()
						vim.cmd(":TSInstall dap_repl")
					end
				end,
			},
			{
				"jay-babu/mason-nvim-dap.nvim",
				cmd = { "DapInstall", "DapUninstall" },
				-- mason-nvim-dap is loaded when nvim-dap loads
				config = true,
			},
			-- JS/TS debugging.
			{
				"mxsdev/nvim-dap-vscode-js",
				opts = {
					debugger_path = vim.fn.stdpath("data") .. "/lazy/vscode-js-debug",
					adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" },
				},
			},
			{
				"microsoft/vscode-js-debug",
				version = "1.x",
				build = "npm i && npm run compile vsDebugServerBundle && mv dist out",
			},
		},
		config = function()
			require("mason-nvim-dap").setup({
				-- Makes a best effort to setup the various debuggers with
				-- reasonable debug configurations
				automatic_installation = true,

				-- You can provide additional configuration to the handlers,
				-- see mason-nvim-dap README for more information
				handlers = {},

				-- You'll need to check that you have the required things installed
				-- online, please don't ask me how to install them :)
				ensure_installed = {
					-- Update this to ensure that you have the debuggers for the langs you want
					"delve",
					-- "chrome",
					-- "js",
				},
			})

			local present_dapui, dapui = pcall(require, "dapui")
			local present_dap, dap = pcall(require, "dap")
			local present_virtual_text, dap_vt = pcall(require, "nvim-dap-virtual-text")
			local present_dap_utils, dap_utils = pcall(require, "dap.utils")
			local keymap = vim.keymap.set
			local opts = { noremap = true, silent = true }

			-- ╭──────────────────────────────────────────────────────────╮
			-- │ DAP Virtual Text Setup                                   │
			-- ╰──────────────────────────────────────────────────────────╯
			dap_vt.setup({
				enabled = true, -- enable this plugin (the default)
				enabled_commands = true, -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
				highlight_changed_variables = true, -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
				highlight_new_as_changed = false, -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
				show_stop_reason = true, -- show stop reason when stopped for exceptions
				commented = false, -- prefix virtual text with comment string
				only_first_definition = true, -- only show virtual text at first definition (if there are multiple)
				all_references = false, -- show virtual text on all all references of the variable (not only definitions)
				filter_references_pattern = "<module", -- filter references (not definitions) pattern when all_references is activated (Lua gmatch pattern, default filters out Python modules)
				-- Experimental Features:
				virt_text_pos = "eol", -- position of virtual text, see `:h nvim_buf_set_extmark()`
				all_frames = false, -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
				virt_lines = false, -- show virtual lines instead of virtual text (will flicker!)
				virt_text_win_col = nil, -- position the virtual text at a fixed window column (starting from the first text column) ,
				enable_commands = true,
				clear_on_continue = false,
				text_prefix = " ",
				separator = "|",
				error_prefix = " ",
				info_prefix = " ",
				virt_lines_above = true,
				display_callback = true,
			})
			--
			-- -- ╭──────────────────────────────────────────────────────────╮
			-- -- │ DAP UI Setup                                             │
			-- -- ╰──────────────────────────────────────────────────────────╯
			-- dapui.setup({
			-- 	element_mappings = {},
			-- 	force_buffers = false,
			-- 	controls = {
			-- 		enabled = true,
			-- 		element = "",
			-- 		icons = {
			--
			-- 			expanded = "▾",
			-- 			collapsed = "▸",
			-- 			current_frame = "",
			-- 		},
			-- 	},
			-- 	icons = { expanded = "▾", collapsed = "▸", current_frame = "" },
			-- 	mappings = {
			-- 		-- Use a table to apply multiple mappings
			-- 		expand = { "<CR>", "<2-LeftMouse>" },
			-- 		open = "o",
			-- 		remove = "d",
			-- 		edit = "e",
			-- 		repl = "r",
			-- 		toggle = "t",
			-- 	},
			-- 	-- Expand lines larger than the window
			-- 	-- Requires >= 0.7
			-- 	expand_lines = true,
			-- 	-- Layouts define sections of the screen to place windows.
			-- 	-- The position can be "left", "right", "top" or "bottom".
			-- 	-- The size specifies the height/width depending on position. It can be an Int
			-- 	-- or a Float. Integer specifies height/width directly (i.e. 20 lines/columns) while
			-- 	-- Float value specifies percentage (i.e. 0.3 - 30% of available lines/columns)
			-- 	-- Elements are the elements shown in the layout (in order).
			-- 	-- Layouts are opened in order so that earlier layouts take priority in window sizing.
			-- 	layouts = {
			-- 		{
			-- 			elements = {
			-- 				-- Elements can be strings or table with id and size keys.
			-- 				{ id = "scopes", size = 0.25 },
			-- 				"breakpoints",
			-- 				"watches",
			-- 			},
			-- 			size = 40, -- 40 columns
			-- 			position = "left",
			-- 		},
			-- 		{
			-- 			elements = {
			-- 				"repl",
			-- 				"console",
			-- 			},
			-- 			size = 0.25, -- 25% of total lines
			-- 			position = "bottom",
			-- 		},
			-- 	},
			-- 	floating = {
			-- 		max_height = nil, -- These can be integers or a float between 0 and 1.
			-- 		max_width = nil, -- Floats will be treated as percentage of your screen.
			-- 		border = "rounded", -- Border style. Can be "single", "double" or "rounded"
			-- 		mappings = {
			-- 			close = { "q", "<Esc>" },
			-- 		},
			-- 	},
			-- 	windows = { indent = 1 },
			-- 	render = {
			-- 		indent = 1,
			-- 		max_type_length = nil, -- Can be integer or nil.
			-- 	},
			-- })

			-- ╭──────────────────────────────────────────────────────────╮
			-- │ DAP Setup                                                │
			-- ╰──────────────────────────────────────────────────────────╯
			dap.set_log_level("TRACE")

			-- Automatically open UI
			dap.listeners.before.attach["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.launch["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end

			-- Enable virtual text
			vim.g.dap_virtual_text = true

			-- ╭──────────────────────────────────────────────────────────╮
			-- │ Icons                                                    │
			-- ╰──────────────────────────────────────────────────────────╯
			vim.fn.sign_define("DapBreakpoint", { text = "🔵", texthl = "", linehl = "", numhl = "" })
			vim.fn.sign_define("DapBreakpointRejected", { text = "🔴", texthl = "", linehl = "", numhl = "" })
			vim.fn.sign_define("DapConditionalBreakpoint", { text = "🟡", texthl = "", linehl = "", numhl = "" })
			vim.fn.sign_define("DapStopped", { text = "🟢", texthl = "", linehl = "", numhl = "" })

			local exts = {
				"javascript",
				"typescript",
				"javascriptreact",
				"typescriptreact",
				"vue",
				"svelte",
			}
			-- ╭──────────────────────────────────────────────────────────╮
			-- │ Adapters                                                 │
			-- ╰──────────────────────────────────────────────────────────╯
			-- dap.adapters["pwa-node"] = {
			-- 	type = "server",
			-- 	host = "localhost",
			-- 	port = "${port}",
			-- 	executable = {
			-- 		command = "node",
			-- 		args = {
			-- 			vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
			-- 			"${port}",
			-- 		},
			-- 	},
			-- }
			--
			-- dap.adapters["pwa-chrome"] = {
			-- 	type = "server",
			-- 	host = "localhost",
			-- 	port = "${port}",
			-- 	executable = {
			-- 		command = "node",
			-- 		args = {
			-- 			vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
			-- 			"${port}",
			-- 		},
			-- 	},
			-- }

			-- ╭──────────────────────────────────────────────────────────╮
			-- │ Configurations                                           │
			-- ╰──────────────────────────────────────────────────────────╯

			for i, ext in ipairs(exts) do
				dap.configurations[ext] = {
					-- {
					-- 	type = "pwa-chrome",
					-- 	request = "launch",
					-- 	name = 'Launch Chrome with "localhost"',
					-- 	url = function()
					-- 		local co = coroutine.running()
					-- 		return coroutine.create(function()
					-- 			vim.ui.input(
					-- 				{ prompt = "Enter URL: ", default = "http://localhost:3000" },
					-- 				function(url)
					-- 					if url == nil or url == "" then
					-- 						return
					-- 					else
					-- 						coroutine.resume(co, url)
					-- 					end
					-- 				end
					-- 			)
					-- 		end)
					-- 	end,
					-- 	webRoot = "${workspaceFolder}",
					-- 	protocol = "inspector",
					-- 	sourceMaps = true,
					-- 	userDataDir = false,
					-- 	skipFiles = { "<node_internals>/**", "node_modules/**", "${workspaceFolder}/node_modules/**" },
					-- 	resolveSourceMapLocations = {
					-- 		"${webRoot}/*",
					-- 		"${webRoot}/apps/**/**",
					-- 		"${workspaceFolder}/apps/**/**",
					-- 		"${webRoot}/packages/**/**",
					-- 		"${workspaceFolder}/packages/**/**",
					-- 		"${workspaceFolder}/*",
					-- 		"!**/node_modules/**",
					-- 	},
					-- },
					-- {
					-- 	name = "Next.js: debug server-side (pwa-node)",
					-- 	type = "pwa-node",
					-- 	request = "attach",
					-- 	port = 9231,
					-- 	skipFiles = { "<node_internals>/**", "node_modules/**" },
					-- 	cwd = "${workspaceFolder}",
					-- },
					-- {
					-- 	type = "pwa-node",
					-- 	request = "launch",
					-- 	name = "Launch Current File (pwa-node)",
					-- 	cwd = vim.fn.getcwd(),
					-- 	args = { "${file}" },
					-- 	sourceMaps = true,
					-- 	protocol = "inspector",
					-- 	runtimeExecutable = "pnpm",
					-- 	runtimeArgs = {
					-- 		"run-script",
					-- 		"dev",
					-- 	},
					-- 	resolveSourceMapLocations = {
					-- 		"${workspaceFolder}/**",
					-- 		"!**/node_modules/**",
					-- 	},
					-- },
					-- {
					-- 	type = "pwa-node",
					-- 	request = "launch",
					-- 	name = "Launch Current File (pwa-node with ts-node)",
					-- 	cwd = vim.fn.getcwd(),
					-- 	runtimeArgs = { "--loader", "ts-node/esm" },
					-- 	runtimeExecutable = "node",
					-- 	args = { "${file}" },
					-- 	sourceMaps = true,
					-- 	protocol = "inspector",
					-- 	skipFiles = { "<node_internals>/**", "node_modules/**" },
					-- 	resolveSourceMapLocations = {
					-- 		"${workspaceFolder}/**",
					-- 		"!**/node_modules/**",
					-- 	},
					-- },
					-- {
					-- 	type = "pwa-node",
					-- 	request = "launch",
					-- 	name = "Launch Test Current File (pwa-node with jest)",
					-- 	cwd = vim.fn.getcwd(),
					-- 	runtimeArgs = { "${workspaceFolder}/node_modules/.bin/jest" },
					-- 	runtimeExecutable = "node",
					-- 	args = { "${file}", "--coverage", "false" },
					-- 	rootPath = "${workspaceFolder}",
					-- 	sourceMaps = true,
					-- 	console = "integratedTerminal",
					-- 	internalConsoleOptions = "neverOpen",
					-- 	skipFiles = { "<node_internals>/**", "node_modules/**" },
					-- },
					-- {
					-- 	type = "pwa-node",
					-- 	request = "launch",
					-- 	name = "Launch Test Current File (pwa-node with vitest)",
					-- 	cwd = vim.fn.getcwd(),
					-- 	program = "${workspaceFolder}/node_modules/vitest/vitest.mjs",
					-- 	args = { "--inspect-brk", "--threads", "false", "run", "${file}" },
					-- 	autoAttachChildProcesses = true,
					-- 	smartStep = true,
					-- 	console = "integratedTerminal",
					-- 	skipFiles = { "<node_internals>/**", "node_modules/**" },
					-- },
					-- {
					-- 	type = "pwa-node",
					-- 	request = "launch",
					-- 	name = "Launch Test Current File (pwa-node with deno)",
					-- 	cwd = vim.fn.getcwd(),
					-- 	runtimeArgs = { "test", "--inspect-brk", "--allow-all", "${file}" },
					-- 	runtimeExecutable = "deno",
					-- 	attachSimplePort = 9229,
					-- },
					-- {
					-- 	type = "pwa-chrome",
					-- 	request = "attach",
					-- 	name = "Attach Program (pwa-chrome, select port)",
					-- 	program = "${file}",
					-- 	cwd = vim.fn.getcwd(),
					-- 	sourceMaps = true,
					-- 	port = function()
					-- 		return vim.fn.input("Select port: ", 9222)
					-- 	end,
					-- 	webRoot = "${workspaceFolder}",
					-- },
					{
						type = "pwa-chrome",
						request = "attach",
						name = "Attach Program (pwa-chrome, select port)",
						program = "${file}",
						cwd = vim.fn.getcwd(),
						sourceMaps = true,
						protocol = "inspector",
						port = function()
							return vim.fn.input("Select port: ", 9222)
						end,
						webRoot = "${workspaceFolder}",
						skipFiles = { "<node_internals>/**", "node_modules/**", "${workspaceFolder}/node_modules/**" },
						resolveSourceMapLocations = {
							"${webRoot}/*",
							"${webRoot}/apps/**/**",
							"${workspaceFolder}/apps/**/**",
							"${webRoot}/packages/**/**",
							"${workspaceFolder}/packages/**/**",
							"${workspaceFolder}/*",
							"!**/node_modules/**",
						},
					},
					{
						type = "pwa-node",
						request = "attach",
						name = "Attach Program (pwa-node, select pid)",
						cwd = vim.fn.getcwd(),
						processId = dap_utils.pick_process,
						skipFiles = {
							"<node_internals>/**",
							-- "node_modules/**",
						},
					},
				}
			end
		end,
		keys = {
			{
				"<Leader>da",
				"<CMD>lua require('dap').continue()<CR>",
				desc = "Continue",
			},
			{
				"<Leader>db",
				"<CMD>lua require('dap').toggle_breakpoint()<CR>",
				desc = "Toggle Breakpoint",
			},
			{
				"<Leader>dB",
				"<CMD>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
				desc = "Conditional Breakpoint",
			},
			{
				"<Leader>dd",
				"<CMD>lua require('dap').continue()<CR>",
				desc = "Continue",
			},
			{
				"<Leader>dh",
				"<CMD>lua require('dapui').eval()<CR>",
				desc = "Evaluate",
			},
			{
				"<Leader>di",
				"<CMD>lua require('dap').step_into()<CR>",
				desc = "Step Into",
			},
			{
				"<Leader>do",
				"<CMD>lua require('dap').step_out()<CR>",
				desc = "Step Out",
			},
			{
				"<Leader>dO",
				"<CMD>lua require('dap').step_over()<CR>",
				desc = "Step Over",
			},
			{
				"<Leader>dt",
				"<CMD>lua require('dap').terminate()<CR>",
				desc = "Terminate",
			},
			{
				"<Leader>du",
				"<CMD>lua require('dapui').open()<CR>",
				desc = "Open UI",
			},
			{
				"<Leader>dc",
				"<CMD>lua require('dapui').close()<CR>",
				desc = "Close UI",
			},
			{
				"<Leader>dw",
				"<CMD>lua require('dapui').float_element('watches', { enter = true })<CR>",
				desc = "Watches",
			},
			{
				"<Leader>ds",
				"<CMD>lua require('dapui').float_element('scopes', { enter = true })<CR>",
				desc = "Scopes",
			},
			{
				"<Leader>dr",
				"<CMD>lua require('dapui').float_element('repl', { enter = true })<CR>",
				desc = "REPL",
			},
		},
	},
}
