vim.g.theme_light = "carbide"
vim.g.theme_dark = "vscode"
require("extras.themes.overrides")

---@module "lazy"
---@type LazyPluginSpec[]
return {
	-- theme
	{ import = "extras.themes.carbide" },
	{ import = "extras.themes.vscode" },
	-- languages
	-- plugins
	{ import = "extras.sonarlint" },
	{ import = "extras.ai.copilot" },
	{ import = "extras.octo" },
	{ import = "extras.overseer" },
	{ import = "extras.screenkey" },
	{ import = "extras.spectre" },
}
