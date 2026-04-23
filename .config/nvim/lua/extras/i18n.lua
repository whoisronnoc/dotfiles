-- npm install -g js-i18n-language-server
-- local cwd = vim.loop.cwd()
return {
	-- {
	-- 	"neovim/nvim-lspconfig",
	-- 	optional = true,
	-- 	opts = {
	-- 		servers = {
	-- 			js_i18n = {},
	-- 		},
	-- 	},
	-- },
	{
		"nabekou29/js-i18n.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {},
		enabled = false,
		-- enabled = string.find(cwd, "dsys/mfe-ascent") ~= nil,
	},
}
-- return {
-- 	"yelog/i18n.nvim",
-- 	dependencies = {
-- 		"nvim-treesitter/nvim-treesitter",
-- 		-- optional pickers:
-- 		-- 'ibhagwan/fzf-lua',
-- 		-- 'nvim-telescope/telescope.nvim',
-- 	},
-- 	config = function()
-- 		require("i18n").setup({
-- 			locales = { "en-US" },
-- 			sources = { "src/assets/locales/{locales}/app.json" },
-- 			-- func_pattern (default: { 't', '$t' }): function call matchers or raw Lua patterns.
-- 			-- func_pattern = { call = "=", quotes = { "'", '"' } },
-- 		})
-- 	end,
-- }
