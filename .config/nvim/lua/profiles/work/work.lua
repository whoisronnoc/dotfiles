vim.g.theme_light = "catppuccin"
vim.g.theme_dark = "vscode"
require("extras.themes.overrides")

---@module "lazy"
---@type LazyPluginSpec[]
return {
	-- theme
	{ import = "extras.themes.catppuccin" },
	{ import = "extras.themes.vscode" },
	-- languages, tools, etc.
	{ import = "extras.sonarlint" },
	{ import = "extras.i18n" },
	-- ai
	{ import = "extras.ai.copilot" },
	-- plugins
	{ import = "extras.auto-session" },
	{ import = "extras.obsidian" },
	{ import = "extras.octo" },
	{ import = "extras.overseer" },
	{ import = "extras.screenkey" },
	{ import = "extras.spectre" },
	{ import = "extras.dashboard" },
}
