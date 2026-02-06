return {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	event = { "BufReadPost", "BufWritePost", "BufNewFile" },
	opts = function(_, opts)
		local dark_colors = {
			"#261E27",
			"#1F2828",
		}
		local light_colors = {
			"#FDECFE",
			"#EEFEFF",
		}

		vim.cmd.hi("IblScope guifg=#aaaaaa")
		-- vim.cmd.hi("IblIndent guifg=#aaaaaa")
		-- vim.cmd.hi("IblWhitespace guifg=#aaaaaa")

		vim.api.nvim_create_autocmd("ColorScheme", {
			callback = function(args)
				vim.defer_fn(function()
					local colors = vim.o.background == "dark" and dark_colors or light_colors

					for i, color in ipairs(colors) do
						vim.cmd.hi(string.format("@ibl.scope.char.%d guibg=%s", i, color))
						vim.cmd.hi(string.format("@ibl.indent.char.%d guibg=%s", i, color))
						vim.cmd.hi(string.format("@ibl.whitespace.char.%d guibg=%s", i, color))
					end
				end, 1000)
			end,
		})

		return require("indent-rainbowline").make_opts(
			-- ibl opts
			-- :help ibl.config
			{
				scope = {
					-- highlight = "IblScope",
					char = "▎",
					show_start = false,
					show_end = false,
				},
			},
			-- rainbow opts
			{
				-- color_transparency = 0.15,
				exclude = { filetypes = { "dashboard", "text" } },
				colors = {
					-- 0xff6e67,
					-- 0xff8700,
					-- 0x5ffa68,
					-- 0xfffa67,
					-- 0x6871ff,
					0xff77ff,
					0x60fdff,
				},
			}
		)
	end,
	dependencies = {
		"TheGLander/indent-rainbowline.nvim",
	},
}
