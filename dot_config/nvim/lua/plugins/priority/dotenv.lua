local env_path = vim.fn.stdpath("config") .. "/.env"

local load_env = function()
	if vim.fn.filereadable(env_path) == 0 then
		vim.notify("No .env file found at " .. env_path, vim.log.levels.WARN)
		return
	end

	vim.g.loaded_dotenv = 0
	vim.cmd("Dotenv " .. env_path)
end

return {
	{
		"tpope/vim-dotenv",
		lazy = false,
		config = function()
			vim.g.loaded_dotenv = 1
			local path = vim.fn.stdpath("config") .. "/.env"

			-- augroup dotenvPlugin
			--   autocmd BufNewFile,BufReadPost .env.* setfiletype sh
			--
			--   autocmd BufNewFile,BufReadPre * unlet! b:dotenv
			--   autocmd FileType netrw          unlet! b:dotenv
			-- augroup END:w
			--
			vim.api.nvim_create_augroup("dotenvPlugin", { clear = true })
			vim.api.nvim_create_autocmd("BufReadPre", {
				group = "dotenvPlugin",
				pattern = "*",
				callback = function()
					if vim.fn.filereadable(path) == 0 then
						vim.notify("No .env file found at " .. path, vim.log.levels.WARN)
						return
					end

					load_env()
				end,
			})

			load_env()
		end,
	},
}
