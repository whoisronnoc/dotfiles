return {
	"barrettruth/diffs.nvim",
	enabled = false,
	init = function()
		vim.g.diffs = {
			fugitive = true,
			neogit = true,
			neojj = true,
			gitsigns = true,
		}
	end,
}
