return {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	event = { "BufReadPost", "BufWritePost", "BufNewFile" },
	opts = function(_, opts)
		return require("indent-rainbowline").make_opts(opts, {
			exclude = { filetypes = { "dashboard", "text" } },
			colors = {
				-- 0xff6e67,
				-- 0xff8700,
				-- 0x5ffa68,
				0xfffa67,
				-- 0x6871ff,
				0xff77ff,
				0x60fdff,
			},
		})
	end,
	dependencies = {
		"TheGLander/indent-rainbowline.nvim",
	},
}
