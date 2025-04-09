-- https://github.com/nvim-neo-tree/neo-tree.nvim
return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"echasnovski/mini.nvim",
			"MunifTanjim/nui.nvim",
		},
		cmd = "Neotree",
		keys = {
			{
				"\\",
				":Neotree reveal<CR>",
				desc = "NeoTree reveal",
				silent = true,
			},

			{
				"<leader>nb",
				":Neotree toggle show buffers right<CR>",
				desc = "NeoTree show [B]uffers",
				silent = true,
			},
			{
				"<leader>ns",
				":Neotree float git_status<CR>",
				desc = "NeoTree Git [S]tatus",
				silent = true,
			},
		},
		config = function()
			local miniicons = require("mini.icons")
			local web_devicons = require("nvim-web-devicons")
			local highlights = require("neo-tree.ui.highlights")

			require("neo-tree").setup({
				source_selector = {
					winbar = true,
					truncation_character = "",
				},
				close_if_last_window = true, -- close neotree if it is the only window left
				filesystem = {
					window = {
						width = 32,
						mappings = {
							["\\"] = "close_window",
						},
					},
					filtered_items = {
						visible = true, -- when true, they will just be displayed differently than normal items
						hide_dotfiles = false,
						hide_gitignored = false,
						hide_hidden = false, -- only works on Windows for hidden files/directories
					},
					follow_current_file = {
						enabled = true, -- This will find and focus the file in the active buffer every time
						--               -- the current file is changed while the tree is open.
						leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
					},
					components = {
						icon = function(config, node, state)
							local icon = config.default or " "
							local padding = config.padding or " "
							local highlight = config.highlight or highlights.FILE_ICON

							if node.type == "directory" then
								highlight = highlights.DIRECTORY_ICON

								if package.loaded["mini.icons"] then
									icon = miniicons.get("directory", node.name)
									-- icon, highlight = miniicons.get("directory", node.name)
								end

								-- if node.name == ".git" then
								-- 	icon = web_devicons.get_icon_by_filetype("git") or config.folder_closed or "-"
								-- 	highlight = web_devicons.get_icon_color_by_filetype("git") or highlight
								-- else
								-- 	if node:is_expanded() then
								-- 		icon = config.folder_open or "v"
								-- 	else
								-- 		icon = config.folder_closed or "+"
								-- 	end
								-- end
							elseif node.type == "file" then
								local devicon, hl = web_devicons.get_icon(node.name, node.ext)
								icon = devicon or icon
								highlight = hl or highlight
							end

							return {
								text = icon .. padding,
								highlight = highlight,
							}
						end,
					},
				},
				buffers = {
					leave_dirs_open = true, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
					follow_current_file = {
						enabled = true, -- This will find and focus the file in the active buffer every time
						--              -- the current file is changed while the tree is open.
						leave_dirs_open = true, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
					},
				},
				default_component_configs = {
					container = {
						enable_character_fade = false,
					},
					indent = {
						indent_size = 2,
						padding = 1, -- extra padding on left hand side
						-- indent guides
						with_markers = true,
						indent_marker = "│",
						last_indent_marker = "└",
						highlight = "NeoTreeIndentMarker",
						-- expander config, needed for nesting files
						with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
						expander_collapsed = ">",
						expander_expanded = "v",
						expander_highlight = "NeoTreeExpander",
					},
					-- Set the icons to ASCII if you don't have a nerd font otherwise use
					-- the default icons provided by nvim-web-devicons and unicode characters
					icon = vim.g.have_nerd_font and {} or {
						folder_closed = ">",
						folder_open = "v",
						folder_empty = "-",
						provider = function(icon, node, _) -- default icon provider utilizes nvim-web-devicons if available
							if node.type == "file" or node.type == "terminal" then
								local success, web_devicons = pcall(require, "nvim-web-devicons")
								if success then
									local name = node.type == "terminal" and "terminal" or node.name
									local _, hl = web_devicons.get_icon(name)
									icon.highlight = hl or icon.highlight
								end
							end
						end,
						-- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
						-- then these will never be used.
						default = "*",
						highlight = "NeoTreeFileIcon",
					},
					modified = {
						symbol = vim.g.have_nerd_font and "" or "*",
						highlight = "NeoTreeModified",
					},
					name = {
						trailing_slash = true,
						use_git_status_colors = true,
					},
					git_status = vim.g.have_nerd_font
							and {
								symbols = {
									-- Change type
									added = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
									modified = "", -- or "", but this is redundant info if you use git_status_colors on the name
									deleted = "✖", -- this can only be used in the git_status source
									renamed = "󰁕", -- this can only be used in the git_status source
									-- Status type
									untracked = "",
									ignored = "",
									unstaged = "󰄱",
									staged = "",
									conflict = "",
								},
							}
						-- Set the icons to ASCII if you don't have a nerd font otherwise use
						-- the default icons provided by nvim-web-devicons and unicode characters
						or {
							symbols = {
								-- Change type
								added = "+", -- or "", but this is redundant info if you use git_status_colors on the name
								modified = "*", -- or "", but this is redundant info if you use git_status_colors on the name
								deleted = "-", -- this can only be used in the git_status source
								renamed = "~", -- this can only be used in the git_status source
								-- Status type
								untracked = "-",
								ignored = "?",
								unstaged = "x",
								staged = "✔",
								conflict = "@",
							},
						},
				},
			})
		end,
	},
}
