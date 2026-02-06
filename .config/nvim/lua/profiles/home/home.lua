vim.g.theme_light = "catppuccin"
vim.g.theme_dark = "catppuccin"

---@module "lazy"
---@type LazyPluginSpec[]
return {
	-- theme
	{ import = "extras.themes.catppuccin" },
	-- { import = "extras.themes.sonokai" },
	-- languages
	{ import = "extras.lang.go" },
	{ import = "extras.lang.rust" },
	-- plugins
	{ import = "extras.ai.supermaven" },
}
