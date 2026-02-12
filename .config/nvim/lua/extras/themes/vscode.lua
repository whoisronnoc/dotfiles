--- @type LazyPluginSpec
return {
	"Mofiqul/vscode.nvim",
	config = function()
		local c = require("vscode.colors").get_colors()
		require("vscode").setup({
			-- style = 'light' -- Alternatively set style in setup
			transparent = false, -- Enable transparent background
			italic_comments = true, -- Enable italic comment
			underline_links = true, -- Underline `@markup.link.*` variants
			disable_nvimtree_bg = true, -- Disable nvim-tree background color
			terminal_colors = true, -- Apply theme colors to terminal

			-- Override colors (see ./lua/vscode/colors.lua)
			-- color_overrides = {
			-- vscLineNumber = "#FFFFFF",
			-- vscBlue = "#9FC9FF",
			-- },

			-- Override highlight groups (see ./lua/vscode/theme.lua)
			group_overrides = {
				-- this supports the same val table as vim.api.nvim_set_hl
				-- use colors from this colorscheme by requiring vscode.colors!
				Cursor = { fg = c.vscDarkBlue, bg = c.vscLightGreen, bold = true },
				GitSignsCurrentLineBlame = { fg = "#a0a0a0" },
				NonText = { fg = c.vscGitIgnored },

				-- neo-tree color config
				NeoTreeDirectoryIcon = { fg = c.vscYellowOrange },
				NeoTreeDimText = { fg = c.vscDimHighlight },
				NeoTreeHiddenByName = { fg = c.vscDimHighlight },
				NeoTreeGitAdded = { fg = c.vscGitAdded },
				NeoTreeGitConflict = { fg = c.vscGitConflicting },
				NeoTreeGitDeleted = { fg = c.vscGitDeleted },
				NeoTreeGitIgnored = { fg = c.vscGitIgnored },
				NeoTreeGitModified = { fg = c.vscGitModified },
				NeoTreeGitRenamed = { fg = c.vscGitRenamed },
				NeoTreeGitStaged = { fg = c.vscGitStageModified },
				NeoTreeGitUnstaged = { fg = c.vscGitStageDeleted },
				NeoTreeGitUntracked = { fg = c.vscGitUntracked },

				NeoTreeNormal = { bg = "#181818" },
				NeoTreeNormalNC = { bg = "#181818" },
				NeoTreeVertSplit = { fg = "#2b2b2b", bg = "#222222" },

				-- snacks picker
				-- SnacksPickerDirectory = { fg = c.vscYellowOrange },
				SnacksPickerGitStatusUntracked = { fg = c.vscGitUntracked },
				SnacksPickerGitStatusIgnored = { fg = c.vscGitIgnored },
				SnacksPickerPathIgnored = { fg = c.vscGitIgnored },
				SnacksPickerPathHidden = { fg = "#bbbbbb" },
			},
		})
		require("vscode").load()

		vim.api.nvim_create_autocmd("ColorScheme", {
			callback = function(args)
				if args.match ~= "vscode" then
					return
				end

				-- lualine "auto" theme needs time to update first before overrides are applied
				vim.defer_fn(function()
					vim.cmd("hi! lualine_a_normal guifg=#000000 guibg=#51A2FF")
					vim.cmd("hi! lualine_b_normal guifg=#51A2FF")
				end, 1000)
			end,
		})
	end,
}
