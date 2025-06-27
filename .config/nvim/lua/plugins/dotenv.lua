return {
	"tpope/vim-dotenv",
	config = function()
		local path = vim.fn.stdpath("config") .. "/.env"
		vim.cmd("Dotenv " .. path)
	end,
}
