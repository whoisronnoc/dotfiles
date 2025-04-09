return {
	"folke/persistence.nvim",
	event = "BufReadPre", -- this will only start session saving when an actual file was opened
	opts = {
		-- add any custom options here
		dir = vim.fn.stdpath("state") .. "/sessions/", -- directory where session files are saved
		-- minimum number of file buffers that need to be open to save
		-- Set to 0 to always save
		need = 0,
		branch = false, -- use git branch to save session
		options = { "buffers", "curdir", "tabpages", "winsize" }, -- session save options
	},
	config = function(_, opts)
		require("persistence").setup(opts)
		-- stylua: ignore start
		-- load the session for the current directory
		vim.keymap.set("n", "<leader>Ss", function() require("persistence").load() end,                { desc = "[s]elect current session" })
		vim.keymap.set("n", "<leader>SS", function() require("persistence").select() end,              { desc = "[S]elect session" })
		vim.keymap.set("n", "<leader>Sl", function() require("persistence").load({ last = true }) end, { desc = "[l]oad last session" })
		-- stop Persistence => session won't be saved on exit
		vim.keymap.set("n", "<leader>Sd", function() require("persistence").stop() end,                { desc = "[d]elete session" })
		-- stylua: ignore end

		-- Create an autocommand to load session when starting Neovim in a directory
		vim.api.nvim_create_autocmd("VimEnter", {
			callback = function()
				-- Only try to load if no arguments were passed (just opening a directory)
				-- and not in a git commit, merge, or similar scenario
				local should_load = vim.fn.argc() == 0
					and vim.fn.line2byte(1) == -1
					and not vim.o.insertmode
					and vim.env.TERM ~= "dumb"
					and not vim.env.GIT_EXEC_PATH

				if should_load then
					-- Try to load the session for the current directory
					require("persistence").load({ last = false })
				end
			end,
			desc = "Auto-load session when opening Neovim in a directory",
		})

		-- vim.api.nvim_create_autocmd("PersistenceSavePre", {
		-- 	callback = function()
		-- 		vim.cmd("Neotree close")
		-- 	end,
		-- 	desc = "Auto-close Neotree",
		-- })
	end,
	-- keys = {
	-- 	{ "<leader>qs", require("persistence").load, desc = "Restore Session" },
	-- 	{ "<leader>qS", require("persistence").select, desc = "Select Session" },
	-- 	{ "<leader>ql", require("persistence").load({ last = true }), desc = "Load Last Session" },
	-- 	{ "<leader>qd", require("persistence").stop, desc = "Stop Persistence" },
	-- },
}
