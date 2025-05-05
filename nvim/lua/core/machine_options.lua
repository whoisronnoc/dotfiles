M = {}

--- @param search string
function M:isHost(search)
	local hostname = vim.fn.hostname()
	return string.match(hostname, search) ~= nil
end

--- @param option machine_option
function M:getOption(option)
	for host, options in pairs(self.options) do
		if self:isHost(host) then
			return options[option]
		end
	end
end

--- @alias machine_option "profile" | "explorer" | "theme_dark" | "theme_light" | "theme_default_mode" | "picker" | "ai_source"
--- @alias profile "work" | "personal"
--- @alias explorer "neo-tree" | "snacks"
--- @alias theme "vscode" | "sonokai" | "catppuccin" | "carbide"
--- @alias theme_default_mode "dark" | "light"
--- @alias picker "telescope" | "snacks"
--- @alias ai_source "copilot" | "supermaven"

--- @class machine_options
--- @field profile profile
--- @field explorer explorer
--- @field picker picker
--- @field theme_dark theme
--- @field theme_light theme
--- @field theme_default_mode theme_default_mode
--- @field ai_source ai_source

M.options = {
	--- @type machine_options
	QL4 = {
		profile = "work",
		explorer = "neo-tree",
		picker = "snacks",
		theme_dark = "vscode",
		theme_light = "carbide",
		theme_default_mode = "dark",
		ai_source = "copilot",
	},
	--- @type machine_options
	MkIII = {
		profile = "personal",
		explorer = "neo-tree",
		picker = "snacks",
		theme_dark = "sonokai",
		theme_light = "catppuccin",
		theme_default_mode = "dark",
		ai_source = "supermaven",
	},
}

return M
