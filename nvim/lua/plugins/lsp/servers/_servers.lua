local util = require("lspconfig.util")

return {
	eslint = {
		root_dir = util.root_pattern(".eslintrc", ".eslintrc.js", ".eslintrc.json"),
	},
	stylelint_lsp = {
		root_dir = util.root_pattern("node_modules"),
	},
	-- harper_ls = require("plugins.lsp.servers.harper_ls"),
	lua_ls = require("plugins.lsp.servers.lua_ls"),
	jsonls = require("plugins.lsp.servers.jsonls"),
	yamlls = require("plugins.lsp.servers.yamlls"),
	ts_ls = require("plugins.lsp.servers.ts_ls"),
	volar = require("plugins.lsp.servers.volar"),
	biome = {
		root_dir = util.root_pattern("biome.json", "biome.jsonc"),
	},
	tailwindcss = {
		roort_dir = util.root_pattern("tailwind.config.js", "tailwind.config.ts"),
	},
	html = {},
	angularls = require("plugins.lsp.servers.angularls"),
	rust_analyzer = {
		root_dir = util.root_pattern("Cargo.toml"),
	},
	lemminx = {
		filetypes = { "xml", "xsd", "xsl", "xslt", "svg", "mobileconfig" },
	},
}
