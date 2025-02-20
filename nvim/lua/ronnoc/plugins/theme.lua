return {
	--    -- https://github.com/navarasu/onedark.nvim
	--   {
	--    "navarasu/onedark.nvim",
	--    priority = 1000,
	--    config = function()
	--      require('onedark').load()
	--    end
	--    },
	{
		"loctvl842/monokai-pro.nvim",
		priority = 1000,
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("monokai-pro").setup({
				devicons = true,
				filter = "spectrum", -- classic | octagon | pro | machine | ristretto | spectrum
				background_clear = { "toggleterm", "telescope", "notify" },
			})
			vim.cmd([[colorscheme monokai-pro]])
		end,
	},
	--    {
	--        "gmr458/vscode_modern_theme.nvim",
	--        lazy = false,
	--        priority = 1000,
	--        config = function()
	--            require("vscode_modern").setup({
	--                cursorline = true,
	--                transparent_background = false,
	--                nvim_tree_darker = false,
	--            })
	--            vim.cmd.colorscheme("vscode_modern")
	--        end,
	--    }
}
-- -- Lua
-- require('onedark').load()
-- require('onedark').setup  {
-- 	-- Main options --
-- 	style = 'dark', -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
-- 	transparent = false,  -- Show/hide background
-- 	term_colors = true, -- Change terminal color as per the selected theme style
-- 	ending_tildes = false, -- Show the end-of-buffer tildes. By default they are hidden
-- 	cmp_itemkind_reverse = false, -- reverse item kind highlights in cmp menu

-- 	-- toggle theme style ---
-- 	toggle_style_key = nil, -- keybind to toggle theme style. Leave it nil to disable it, or set it to a string, for example "<leader>ts"
-- 	toggle_style_list = {'dark', 'darker', 'cool', 'deep', 'warm', 'warmer', 'light'}, -- List of styles to toggle between

-- 	-- Change code style ---
-- 	-- Options are italic, bold, underline, none
-- 	-- You can configure multiple style with comma separated, For e.g., keywords = 'italic,bold'
-- 	code_style = {
-- 			comments = 'italic',
-- 			keywords = 'none',
-- 			functions = 'none',
-- 			strings = 'none',
-- 			variables = 'none'
-- 	},

-- 	-- Lualine options --
-- 	lualine = {
-- 			transparent = false, -- lualine center bar transparency
-- 	},

-- 	-- Custom Highlights --
-- 	colors = {}, -- Override default colors
-- 	highlights = {}, -- Override highlight groups

-- 	-- Plugins Config --
-- 	diagnostics = {
-- 			darker = true, -- darker colors for diagnostic
-- 			undercurl = true,   -- use undercurl instead of underline for diagnostics
-- 			background = true,    -- use background color for virtual text
-- 	},
-- }

-- return {
--     "folke/tokyonight.nvim",
--     priority = 1000,
--     config = function()
--         local transparent = false -- set to true if you would like to enable transparency

--         local bg = "#011628"
--         local bg_dark = "#011423"
--         local bg_highlight = "#143652"
--         local bg_search = "#0A64AC"
--         local bg_visual = "#275378"
--         local fg = "#CBE0F0"
--         local fg_dark = "#B4D0E9"
--         local fg_gutter = "#627E97"
--         local border = "#547998"

--         require("tokyonight").setup({
--             style = "night",
--             transparent = transparent,
--             styles = {
--                 sidebars = transparent and "transparent" or "dark",
--                 floats = transparent and "transparent" or "dark"
--             },
--             on_colors = function(colors)
--                 colors.bg = bg
--                 colors.bg_dark = transparent and colors.none or bg_dark
--                 colors.bg_float = transparent and colors.none or bg_dark
--                 colors.bg_highlight = bg_highlight
--                 colors.bg_popup = bg_dark
--                 colors.bg_search = bg_search
--                 colors.bg_sidebar = transparent and colors.none or bg_dark
--                 colors.bg_statusline = transparent and colors.none or bg_dark
--                 colors.bg_visual = bg_visual
--                 colors.border = border
--                 colors.fg = fg
--                 colors.fg_dark = fg_dark
--                 colors.fg_float = fg
--                 colors.fg_gutter = fg_gutter
--                 colors.fg_sidebar = fg_dark
--             end
--         })

--         vim.cmd("colorscheme tokyonight")
--     end
-- }

-- { -- You can easily change to a different colorscheme.
-- -- Change the name of the colorscheme plugin below, and then
-- -- change the command in the config to whatever the name of that colorscheme is.
-- --
-- -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
-- 'folke/tokyonight.nvim',
-- priority = 1000, -- Make sure to load this before all the other start plugins.
-- init = function()
--   -- Load the colorscheme here.
--   -- Like many other themes, this one has different styles, and you could load
--   -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
--   vim.cmd.colorscheme 'tokyonight-night'

--   -- You can configure highlights by doing something like:
--   vim.cmd.hi 'Comment gui=none'
-- end,
-- },
