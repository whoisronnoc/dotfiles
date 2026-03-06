local function getHighlightBg(group_name)
	local hl = vim.api.nvim_get_hl(0, { name = group_name })
	if hl.bg then
		return string.format("#%06X", hl.bg)
	end
	return nil
end

local function getHighlightFg(group_name)
	local hl = vim.api.nvim_get_hl(0, { name = group_name })
	if hl.fg then
		return string.format("#%06X", hl.fg)
	end
	return nil
end

local function hexToRgb(hex)
	hex = hex:gsub("#", "")
	return tonumber(hex:sub(1, 2), 16), tonumber(hex:sub(3, 4), 16), tonumber(hex:sub(5, 6), 16)
end

local function rgbToHex(r, g, b)
	return string.format("#%02X%02X%02X", math.floor(r + 0.5), math.floor(g + 0.5), math.floor(b + 0.5))
end

local function blendColor(foreground, background, a)
	local fgR, fgG, fgB = hexToRgb(foreground)
	local bgR, bgG, bgB = hexToRgb(background)

	local resultR = fgR * a + bgR * (1 - a)
	local resultG = fgG * a + bgG * (1 - a)
	local resultB = fgB * a + bgB * (1 - a)

	return rgbToHex(resultR, resultG, resultB)
end

local function blendBgColorsWithGroup(colors, alpha, group)
	local normalBg = getHighlightBg(group)

	local blendedColors = {}
	for key, color in pairs(colors) do
		blendedColors[key] = blendColor(color, normalBg, alpha)
	end

	return blendedColors
end

local colors = {
	"#ff77ff",
	"#60fdff",
}

local bgGroup = "Normal"
local fgGroup = "LineNr"

return {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	event = { "BufReadPost", "BufWritePost", "BufNewFile" },
	opts = function(_, opts)
		vim.api.nvim_create_autocmd("ColorScheme", {
			callback = function(args)
				vim.defer_fn(function()
					local blended = blendBgColorsWithGroup(colors, 0.05, bgGroup)
					local guifg = getHighlightFg(fgGroup)

					for i, color in ipairs(blended) do
						vim.cmd.hi(string.format("@ibl.scope.char.%d guibg=%s guifg=%s", i, color, guifg))
						vim.cmd.hi(string.format("@ibl.indent.char.%d guibg=%s guifg=%s", i, color, guifg))
						vim.cmd.hi(string.format("@ibl.whitespace.char.%d guibg=%s guifg=%s", i, color, guifg))
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
