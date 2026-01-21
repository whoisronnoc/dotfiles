---@module "lazy"
---@type LazyPluginSpec[]
return {
	-- theme
	{ import = "extras.themes.vscode" },
	-- languages
	{ import = "extras.lang.go" },
	-- plugins
	{ import = "extras.ai.copilot" },
}
