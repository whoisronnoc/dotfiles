vim.g.theme_light = "carbide"
vim.g.theme_dark = "vscode"
require("extras.themes.overrides")

---@module "lazy"
---@type LazyPluginSpec[]
return {
	-- theme
	{ import = "extras.themes.carbide" },
	{ import = "extras.themes.vscode" },
	-- languages, tools, etc.
	{ import = "extras.sonarlint" },
	-- ai
	{ import = "extras.ai.copilot" },
	-- plugins
	{ import = "extras.obsidian" },
	{ import = "extras.octo" },
	{ import = "extras.overseer" },
	{ import = "extras.screenkey" },
	{ import = "extras.spectre" },
}
