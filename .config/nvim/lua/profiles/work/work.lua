vim.g.theme_light = "catppuccin"
vim.g.theme_dark = "vscode"

---@module "lazy"
---@type LazyPluginSpec[]
return {
	-- theme
	{ import = "extras.themes.catppuccin" },
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
