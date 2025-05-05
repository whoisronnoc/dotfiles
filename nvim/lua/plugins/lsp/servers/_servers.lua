local util = require("lspconfig.util")

return {
	lua_ls = require("plugins.lsp.servers.lua_ls"),
	jsonls = require("plugins.lsp.servers.jsonls"),
	yamlls = require("plugins.lsp.servers.yamlls"),
	ts_ls = require("plugins.lsp.servers.ts_ls"),
	volar = require("plugins.lsp.servers.volar"),
	biome = {
		root_dir = util.root_pattern("node_modules", "biome.json", "biome.jsonc"),
	},
	stylelint_lsp = {
		root_dir = util.root_pattern("node_modules"),
	},
	-- tailwind = {},
	html = {},
	tailwindcss = {},
	angularls = require("plugins.lsp.servers.angularls"),
	csharp_ls = {},
	rust_analyzer = {
		root_dir = util.root_pattern("Cargo.toml"),
	},
	lemminx = {
		filetypes = { "xml", "xsd", "xsl", "xslt", "svg", "mobileconfig" },
	},
}
