return {
	"leonardcser/cursortab.nvim",
	-- version = "*",  -- Use latest tagged version for more stability
	lazy = false, -- The server is already lazy loaded
	build = "cd server && go build",
	config = function()
		require("cursortab").setup({
			log_level = "debug",
			provider = {
				type = "fim",
				url = vim.fn.getenv("AI_URL"),
				model = vim.fn.getenv("AI_MODEL"),
			},
		})

		vim.api.nvim_set_hl(0, "CursorTabAddition", { bg = "#375D29" })
	end,
}

-- 	require("cursortab").setup({
--   enabled = true,
--   log_level = "info",  -- "trace", "debug", "info", "warn", "error"
--   state_dir = vim.fn.stdpath("state") .. "/cursortab",  -- Directory for runtime files (log, socket, pid)
--
--   keymaps = {
--     accept = "<Tab>",           -- Keymap to accept completion, or false to disable
--     partial_accept = "<S-Tab>", -- Keymap to partially accept, or false to disable
--     trigger = false,            -- Keymap to manually trigger completion, or false to disable
--   },
--
--   ui = {
--     completions = {
--       addition_style = "dimmed",  -- "dimmed" or "highlight"
--       fg_opacity = 0.6,           -- opacity for completion overlays (0=invisible, 1=fully visible)
--     },
--     jump = {
--       symbol = "",              -- Symbol shown for jump points
--       text = " TAB ",            -- Text displayed after jump symbol
--       show_distance = true,      -- Show line distance for off-screen jumps
--     },
--   },
--
--   behavior = {
--     idle_completion_delay = 50,  -- Delay in ms after idle to trigger completion (-1 to disable)
--     text_change_debounce = 50,   -- Debounce in ms after text change to trigger completion (-1 to disable)
--     max_visible_lines = 12,      -- Max visible lines per completion (0 to disable)
--     enabled_modes = { "insert", "normal" },  -- Modes where completions are active
--     cursor_prediction = {
--       enabled = true,            -- Show jump indicators after completions
--       auto_advance = true,       -- When no changes, show cursor jump to last line
--       proximity_threshold = 2,   -- Min lines apart to show cursor jump (0 to disable)
--     },
--     ignore_paths = {             -- Glob patterns for files to skip completions
--       "*.min.js",
--       "*.min.css",
--       "*.map",
--       "*-lock.json",
--       "*.lock",
--       "*.sum",
--       "*.csv",
--       "*.tsv",
--       "*.parquet",
--       "*.zip",
--       "*.tar",
--       "*.gz",
--       "*.pem",
--       "*.key",
--       ".env",
--       ".env.*",
--       "*.log",
--     },
--     ignore_gitignored = true,    -- Skip files matched by .gitignore
--   },
--
--   provider = {
--     type = "inline",                      -- Provider: "inline", "fim", "sweep", "sweepapi", "zeta", "copilot", or "mercuryapi"
--     url = "http://localhost:8000",        -- URL of the provider server
--     api_key_env = "",                     -- Env var name for API key (e.g., "OPENAI_API_KEY")
--     model = "",                           -- Model name
--     temperature = 0.0,                    -- Sampling temperature
--     max_tokens = 512,                     -- Max tokens to generate
--     top_k = 50,                           -- Top-k sampling
--     completion_timeout = 5000,            -- Timeout in ms for completion requests
--     max_diff_history_tokens = 512,        -- Max tokens for diff history (0 = no limit)
--     completion_path = "/v1/completions",  -- API endpoint path
--     fim_tokens = {                        -- FIM tokens (for FIM provider)
--       prefix = "<|fim_prefix|>",
--       suffix = "<|fim_suffix|>",
--       middle = "<|fim_middle|>",
--     },
--     privacy_mode = true,                  -- Don't send telemetry to provider
--   },
--
--   blink = {
--     enabled = false,    -- Enable blink source
--     ghost_text = true,  -- Show native ghost text alongside blink menu
--   },
--
--   debug = {
--     immediate_shutdown = false,  -- Shutdown daemon immediately when no clients
--   },
-- })
