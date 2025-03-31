return {
	"nvim-pack/nvim-spectre",
	VeryLazy = true,
	config = function()
		require("spectre").setup()
    -- stylua: ignore start
		vim.keymap.set("n", "<leader>sS", '<cmd>lua require("spectre").toggle()<CR>',                             { desc = "Search with [S]pectre" })
		-- vim.keymap.set("n", "<leader>sw", '<cmd>lua require("spectre").open_visual({select_word=true})<CR>',      { desc = "Search current word" })
		-- vim.keymap.set("v", "<leader>sw", '<esc><cmd>lua require("spectre").open_visual()<CR>',                   { desc = "Search current word" })
		-- vim.keymap.set("n", "<leader>sp", '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', { desc = "Search on current file" })
		-- stylua: ignore end
	end,
}
