---@module "lazy"
---@type LazyPluginSpec
return {
	"folke/snacks.nvim",
	optional = true,
	--- @module 'snacks'
	--- @type snacks.Config
  -- stylua: ignore
	keys = { 
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
}

--      -- Create some toggle mappings
--      -- stylua: ignore start
--      -- Snacks.toggle.option("spell", { name = "[s]pelling" }):map("<leader>ts")
--      Snacks.toggle.option("wrap", { name = "[w]rap" }):map("<leader>tw")
--      Snacks.toggle.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map("<leader>tc")
--      Snacks.toggle.option("mousescroll", { off = "ver:3,hor:0", on = "ver3,hor:1", name = "Horizontal Scroll" }):map("<leader>tm")
--
--      Snacks.toggle.line_number():map("<leader>tl")
--      Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>tL")
--
--      Snacks.toggle.diagnostics():map("<leader>td")
--      Snacks.toggle.treesitter():map("<leader>tT")
--      Snacks.toggle.inlay_hints():map("<leader>th")
--
--      Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark [b]ackground" }):map("<leader>tb")
-- 	-- stylua: ignore end
--
-- 	Snacks.toggle
-- 		.new({
-- 			id = "toggle_autoformat",
-- 			name = "Auto [f]ormat",
-- 			get = function()
-- 				return vim.g.autoformat
-- 			end,
-- 			set = function(state)
-- 				vim.g.autoformat = state
-- 			end,
-- 		})
-- 		:map("<leader>tf")
-- end,
