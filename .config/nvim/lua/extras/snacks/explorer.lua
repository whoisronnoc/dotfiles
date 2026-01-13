---@module "lazy"
---@type LazyPluginSpec
return {
	"folke/snacks.nvim",
	optional = true,
	--- @module 'snacks'
	--- @type snacks.Config
	opts = {
		explorer = {
			enabled = true,
			replace_netrw = true,
		},
	},
	-- stylua: ignore
	keys = {
		-- Top Pickers & Explorer
		{ "\\", desc = "File Explorer", function()
			local explorer_pickers = Snacks.picker.get({ source = "explorer" })
			if #explorer_pickers == 0 then
				Snacks.picker.explorer()
				-- elseif explorer_pickers[1]:is_focused() then
				-- 	explorer_pickers[1]:close()
			else
				explorer_pickers[1]:focus()
			end
		end },
    }
,
}
