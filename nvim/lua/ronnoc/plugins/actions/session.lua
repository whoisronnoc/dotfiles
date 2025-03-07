return {
	"folke/persistence.nvim",
	event = "BufReadPre", -- this will only start session saving when an actual file was opened
	opts = {
		-- add any custom options here

		dir = vim.fn.stdpath("state") .. "/sessions/", -- directory where session files are saved
		-- minimum number of file buffers that need to be open to save
		-- Set to 0 to always save
		-- need = 1,
		-- branch = true, -- use git branch to save session
	},
	config = function(_, opts)
		require("persistence").setup(opts)
		-- load the session for the current directory
		vim.keymap.set("n", "<leader>qs", function()
			require("persistence").load()
		end)

		-- select a session to load
		vim.keymap.set("n", "<leader>qS", function()
			require("persistence").select()
		end)

		-- load the last session
		vim.keymap.set("n", "<leader>ql", function()
			require("persistence").load({ last = true })
		end)

		-- stop Persistence => session won't be saved on exit
		vim.keymap.set("n", "<leader>qd", function()
			require("persistence").stop()
		end)
	end,
	-- keys = {
	-- 	{ "<leader>qs", require("persistence").load, desc = "Restore Session" },
	-- 	{ "<leader>qS", require("persistence").select, desc = "Select Session" },
	-- 	{ "<leader>ql", require("persistence").load({ last = true }), desc = "Load Last Session" },
	-- 	{ "<leader>qd", require("persistence").stop, desc = "Stop Persistence" },
	-- },
}
