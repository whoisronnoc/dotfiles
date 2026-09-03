return {
	{
		"xzbdmw/colorful-menu.nvim",
		specs = {
			"saghen/blink.cmp",
			optional = true,
			--- @module 'blink.cmp'
			--- @type blink.cmp.Config
			opts = {
				completion = {
					menu = {
						draw = {
							components = {
								label = {
									text = function(ctx)
										return require("colorful-menu").blink_components_text(ctx)
									end,
									highlight = function(ctx)
										return require("colorful-menu").blink_components_highlight(ctx)
									end,
								},
							},
						},
					},
				},
			},
		},
	},
}
