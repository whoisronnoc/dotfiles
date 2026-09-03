return {
	{
		"ferdinandrau/carbide.nvim",
		priority = 1000,
		opts = { --[[ your options here ]]
			palette_overrides = {
				light = {
					-- bg1 = "#17131C",
					-- bg2 = "#222028",
					-- fgc_green = "#0F5722",
					-- fgc_blue = "#0B4AED",
				},
			},
		},
		config = function(_, opts)
			require("carbide").setup(opts)
			require("carbide").apply()

			vim.api.nvim_create_autocmd("ColorScheme", {
				callback = function(args)
					if args.match ~= "carbide" then
						return
					end

					-- vim.cmd.hi("LspInlayHint guibg=#E9EBF1 guifg=#0B4AED")
					-- bg = "#E9EBF1",
					-- fg = "#9CA0B0"
					vim.cmd.hi("Normal guibg=none")
					vim.cmd.hi("NeoTreeNormal guibg=none")
					vim.cmd.hi("Text guifg=#a8a8a8")
					vim.cmd.hi("Comment guifg=#0B4AED")

					vim.cmd("hi! link NonText @comment.documentation")
					vim.cmd("hi! link BlinkCmpMenuSelection Pmenu")

					-- vim.cmd.hi("NeoTreeTabInactive  guifg=#000000 guibg=#CDCDCD")
					-- vim.cmd.hi("NeoTreeTabSeparatorInactive  guifg=#000000 guibg=#CDCDCD")
				end,
			})
		end,
	},
}
