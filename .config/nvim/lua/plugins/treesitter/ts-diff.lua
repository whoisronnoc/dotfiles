return {
	"barrettruth/diffs.nvim",
	init = function()
		vim.g.diffs = {
			fugitive = true,
			neogit = true,
			neojj = true,
			gitsigns = true,
		}
	end,
}
