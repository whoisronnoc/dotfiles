vim.g.theme_light = "carbide"
vim.g.theme_dark = "sonokai"
require("extras.themes.overrides")

---@module "lazy"
---@type LazyPluginSpec[]
return {
	-- theme
	{ import = "extras.themes.carbide" },
	{ import = "extras.themes.sonokai" },
	-- languages
	{ import = "extras.lang.go" },
	{ import = "extras.lang.rust" },
	-- plugins
	{ import = "extras.auto-session" },
	{ import = "extras.obsidian" },
	-- ai testing
	{ import = "extras.ai.cursortab" },
	{ import = "extras.ai.copilot.sidekick" },
}
