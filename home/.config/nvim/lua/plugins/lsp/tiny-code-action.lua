return {
	"rachartier/tiny-code-action.nvim",
	dependencies = {
		{ "nvim-lua/plenary.nvim" },
		{
			"folke/snacks.nvim",
			optional = true,
			opts = {
				terminal = {},
			},
		},
	},
	event = "LspAttach",
	opts = {
		backend = "vim",
		-- backend = "delta",
		-- backend_opts = {
		-- 	delta = {
		-- 		header_lines_to_remove = 4,
		-- 		args = {
		-- 			"--line-numbers",
		-- 		},
		-- 	},
		-- },
		-- resolve_timeout = 100, -- Timeout in milliseconds to resolve code actions
		-- Notification settings
		-- notify = {
		-- enabled = true, -- Enable/disable all notifications
		-- on_empty = true, -- Show notification when no code actions are found
		-- },
		format_title = function(action, client)
			if action.kind then
				return string.format("%s (%s)", action.title, action.kind)
			end
			return action.title
		end,
		picker = {
			"buffer",
			opts = {
				hotkeys = true, -- Enable hotkeys for quick selection of actions
				hotkeys_mode = "text_diff_based", -- Modes for generating hotkeys
				auto_preview = false, -- Enable or disable automatic preview
				auto_accept = false, -- Automatically accept the selected action (with hotkeys)
				position = "cursor", -- Position of the picker window
				winborder = vim.g.winborder or "single", -- Border style for picker and preview windows
				keymaps = {
					preview = "K", -- Key to show preview
					close = { "q", "<Esc>" }, -- Keys to close the window (can be string or table)
					select = "<CR>", -- Keys to select action (can be string or table)
					preview_close = { "q", "<Esc>" }, -- Keys to return from preview to main window (can be string or table)
				},
				custom_keys = {
					{ key = "m", pattern = "Fill match arms" },
					{ key = "m", pattern = "Consider making this binding mutable: mut" },
					{ key = "r", pattern = "Rename.*" }, -- Lua pattern matching
					{ key = "e", pattern = "Extract Method" },
				},
				group_icon = " └",
			},
		},
		signs = {
			quickfix = { "", { link = "DiagnosticWarning" } },
			others = { "", { link = "DiagnosticWarning" } },
			refactor = { "", { link = "DiagnosticInfo" } },
			["refactor.move"] = { "󰪹", { link = "DiagnosticInfo" } },
			["refactor.extract"] = { "", { link = "DiagnosticError" } },
			["source.organizeImports"] = { "", { link = "DiagnosticWarning" } },
			["source.fixAll"] = { "󰃢", { link = "DiagnosticError" } },
			["source"] = { "", { link = "DiagnosticError" } },
			["rename"] = { "󰑕", { link = "DiagnosticWarning" } },
			["codeAction"] = { "", { link = "DiagnosticWarning" } },
		},
	},
}
