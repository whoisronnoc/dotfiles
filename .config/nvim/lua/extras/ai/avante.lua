return {
	"yetone/avante.nvim",
	event = "VeryLazy",
	version = false, -- Never set this value to "*"! Never!
	--- @type avante.Config
	opts = {
		provider = "copilot",
		cursor_applying_provider = "copilot",
		providers = {
			copilot = {
				extra_request_body = { max_tokens = 4096 },
				model = "claude-3.7-sonnet",
			},
		},
		-- web_search_engine = { -- must set TAVILY_API_KEY, BRAVE_API_KEY, etc
		-- 	provider = "brave", -- tavily, serpapi, searchapi, google, kagi, brave, or searxng
		-- 	proxy = nil, -- proxy support, e.g., http://127.0.0.1:7890
		-- },
		file_selector = {
			provider = "snacks",
			provider_opts = {},
		},
		windows = {
			width = 25, -- percent
		},
		behaviour = {
			auto_suggestions = false, -- Experimental stage
			auto_set_highlight_group = true,
			auto_set_keymaps = true,
			auto_apply_diff_after_generation = false,
			support_paste_from_clipboard = false,
			minimize_diff = true, -- Whether to remove unchanged lines when applying a code block
			enable_token_counting = true, -- Whether to enable token counting. Default to true.
			enable_cursor_planning_mode = false, -- Whether to enable Cursor Planning Mode. Default to false.
			enable_claude_text_editor_tool_mode = false, -- Whether to enable Claude Text Editor Tool Mode.
		},
		suggestion = {
			debounce = 600,
			throttle = 600,
		},
		disabled_tools = {
			"list_files",
			"search_files",
			"read_file",
			"create_file",
			"rename_file",
			"delete_file",
			"create_dir",
			"rename_dir",
			"delete_dir",
			"bash",
		},
		-- other config
		-- The system_prompt type supports both a string and a function that returns a string. Using a function here allows dynamically updating the prompt with mcphub
		system_prompt = function()
			local hub = require("mcphub").get_hub_instance()
			return hub:get_active_servers_prompt()
		end,
		-- The custom_tools type supports both a list and a function that returns a list. Using a function here prevents requiring mcphub before it's loaded
		custom_tools = function()
			return {
				require("mcphub.extensions.avante").mcp_tool(),
			}
		end,
	},
	-- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
	build = "make",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		-- "stevearc/dressing.nvim",
		"nvim-lua/plenary.nvim",
		-- "MunifTanjim/nui.nvim",
		-- "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
		-- "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
		-- "github/copilot.vim",
		-- "HakonHarnes/img-clip.nvim", -- for image pasting
		"ravitemer/mcphub.nvim",
	},
}
