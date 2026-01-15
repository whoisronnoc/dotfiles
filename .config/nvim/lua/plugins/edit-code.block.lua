return {
	"dawsers/edit-code-block.nvim",
	lazy = true,
	cmd = "EditCodeBlock",
	keys = {
		{ "<leader>eb", "<cmd>EditCodeBlock<cr>", desc = "Edit Code Block" },
	},
	config = function()
		require("ecb").setup({
			wincmd = "split",
		})
	end,
}
