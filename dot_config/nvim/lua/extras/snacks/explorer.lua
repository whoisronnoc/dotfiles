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
		sources = {
			--   explorer = {
			-- 	border = "none",
			-- 	layout = {
			-- 		layout = {
			-- 			width = 32,
			-- 			backdrop = false,
			-- 			min_width = 32,
			-- 			height = 0,
			-- 			position = "left",
			-- 			border = "none",
			-- 			box = "vertical",
			-- 			{ win = "list", border = "none" },
			-- 			-- { win = "preview", title = "{preview}", height = 0.4, border = "top" },
			-- 		},
			-- 	},
			-- 	win = {
			-- 		list = {
			-- 			keys = {
			-- 				["s"] = "edit_vsplit",
			-- 				["S"] = "edit_split",
			-- 				["\\"] = "close",
			-- 			},
			-- 		},
			-- 	},
			-- }
			explorer = {
				hidden = true,
				ignored = true,
				win = {
					list = {
						keys = {
							["s"] = "edit_vsplit",
							["S"] = "edit_split",
							["\\"] = "close",
						},
					},
				},
			},
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
