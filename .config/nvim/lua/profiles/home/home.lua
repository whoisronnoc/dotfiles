---@module "lazy"
---@type LazyPluginSpec[]
return {
	-- theme
	{ import = "extras.themes.vscode" },
	-- languages
	{ import = "extras.lang.go" },
	{ import = "extras.lang.rust" },
	-- plugins
	{ import = "extras.ai.supermaven" },
}
