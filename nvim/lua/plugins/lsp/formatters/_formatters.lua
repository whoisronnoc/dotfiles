-- map filetypes to formatters for conform.nvim
return {
	vue = { "prettier" },
	javascript = { "prettier" },
	typescript = { "prettier" },
	javascriptreact = { "prettier" },
	typescriptreact = { "prettier" },
	css = { "prettier" },
	html = { "prettier" },
	json = { "prettier" },
	yaml = { "prettier" },
	markdown = { "prettier" },
	lua = { "stylua" },
	python = { "isort", "black" },
	xml = { "xmllint" },
}
