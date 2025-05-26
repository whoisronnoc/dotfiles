-- map filetypes to formatters for conform.nvim
return {
	vue = { "prettierd" },
	javascript = { "prettierd" },
	typescript = { "prettiedr" },
	javascriptreact = { "prettierd" },
	typescriptreact = { "prettierd" },
	css = { "prettierd" },
	html = { "prettierd" },
	json = { "prettierd" },
	yaml = { "prettierd" },
	markdown = { "prettierd" },
	lua = { "stylua" },
	python = { "isort", "black" },
	xml = { "xmlformatter" },
}
