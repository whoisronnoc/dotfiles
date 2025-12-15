local ai_source = Options:getOption("ai_source")

local servers = {
	-- "harper_ls",
	"eslint",
	"stylelint_lsp",
	"cssls",
	"css_variables",
	"rust_analyzer",
	"lua_ls",
	"jsonls",
	"yamlls",
	"lemminx",
	"html",
	"tailwindcss",
	"ts_ls",
	"vue_ls",
	"angularls",
	"kotlin_language_server",
	"cspell_ls",
}

if ai_source == "copilot" then
	table.insert(servers, "copilot")
end

return servers
