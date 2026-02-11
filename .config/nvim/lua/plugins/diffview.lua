return {
	{
		commands = { "DiffviewOpen", "DiffviewFileHistory" },
		"sindrets/diffview.nvim",
		keys = {
			{ "<leader>hdd", "<cmd>DiffviewClose<CR>", desc = "Diffview Close" },
			{ "<leader>hdM", "<cmd>DiffviewOpen<CR>", desc = "Diffview Open" },
			{ "<leader>hdm", "<cmd>DiffviewFileHistory %s<CR>", desc = "Diffview File History" },
			{ "<leader>hdf", "<cmd>DiffviewToggleFiles<CR>", desc = "Diffview Toggle Files" },
			{ "<leader>hdr", "<cmd>DiffviewRefresh<CR>", desc = "Diffview Refresh" },
		},
	},
}
