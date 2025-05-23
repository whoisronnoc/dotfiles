-- map filetypes to formatters for conform.nvim
return {
	vue = { "prettier_d" },
	javascript = { "prettier_d" },
	typescript = { "prettie_dr" },
	javascriptreact = { "prettier_d" },
	typescriptreact = { "prettier_d" },
	css = { "prettier_d" },
	html = { "prettier_d" },
	json = { "prettier_d" },
	yaml = { "prettier_d" },
	markdown = { "prettier_d" },
	lua = { "stylua" },
	python = { "isort", "black" },
	xml = { "xmlformatter" },
}
