return {
	"ellisonleao/dotenv.nvim",
	lazy = false,
	opts = {
		enable_on_load = true,
		verbose = false,
		file_name = vim.fn.stdpath("config") .. "/.env",
	},
}
