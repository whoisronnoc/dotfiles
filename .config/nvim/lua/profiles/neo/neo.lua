vim.g.theme_light = "carbide"
vim.g.theme_dark = "sonokai"
require("extras.themes.overrides")

---@module "lazy"
---@type LazyPluginSpec[]
return {
	-- theme
	{ import = "extras.themes.carbide" },
	{ import = "extras.themes.sonokai" },
}
