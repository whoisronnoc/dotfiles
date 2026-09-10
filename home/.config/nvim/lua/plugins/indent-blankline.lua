-- parse string e.g. "#ff77ff,#60fdff" into table
local function parseColors(colors)
	local result = {}
	for color in string.gmatch(colors, "([^,]+)") do
		table.insert(result, color)
	end

	return result
end

local function getHighlightBg(group_name)
	local hl = vim.api.nvim_get_hl(0, { name = group_name })
	if hl.bg then
		return string.format("#%06X", hl.bg)
	end

	return (vim.o.background == "dark" and "#000000" or "#ffffff")
end

local function getHighlightFg(group_name)
	local hl = vim.api.nvim_get_hl(0, { name = group_name })
	if hl.fg then
		return string.format("#%06X", hl.fg)
	end

	return (vim.o.background == "dark" and "#ffffff" or "#000000")
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
return {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	event = { "BufReadPost", "BufWritePost", "BufNewFile" },
	opts = function(_, _)
		vim.api.nvim_create_autocmd("ColorScheme", {
			callback = function()
				vim.defer_fn(function()
					-- defaults that usually work for most themes
					local bgGroup = vim.g.theme_ibl_bg or "Normal"
					local fgGroup = vim.g.theme_ibl_fg or "LineNr"

					local blend_bg = vim.g.theme_ibl_blend_bg or 0.05
					local blend_fg = vim.g.theme_ibl_blend_fg or 0.5

					-- has to be 6 total values to override all values in make_opts()
					local colors = vim.g.theme_ibl_colors and parseColors(vim.g.theme_ibl_colors)
						or {
							"#ff77ff",
							"#60fdff",
							"#6871ff",
							"#5ffa68",
							"#fffa67",
							"#ff8700",
							"#ff6e67",
						}

					local blended = blendBgColorsWithGroup(colors, blend_bg, bgGroup)
					local fg = getHighlightFg(fgGroup)

					for i, color in ipairs(blended) do
						local guifg = blendColor(fg, color, blend_fg)
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
					0xff77ff,
					0x60fdff,
					0x6871ff,
					0x5ffa68,
					0xfffa67,
					0xff8700,
					0xff6e67,
				},
			}
		)
	end,
	dependencies = {
		"TheGLander/indent-rainbowline.nvim",
	},
}
