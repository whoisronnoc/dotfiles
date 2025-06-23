return {
	{ "akinsho/git-conflict.nvim", version = "*", config = true },
	{ -- Adds git related signs to the gutter, as well as utilities for managing changes
		"lewis6991/gitsigns.nvim",
		event = "VeryLazy",
		opts = {
			signs = {
				add = {
					text = "┃",
				},
				change = {
					text = "┃",
				},
				delete = {
					text = "_",
				},
				topdelete = {
					text = "‾",
				},
				changedelete = {
					text = "~",
				},
				untracked = {
					text = "┆",
				},
			},
			signs_staged = {
				add = {
					text = "┃",
				},
				change = {
					text = "┃",
				},
				delete = {
					text = "_",
				},
				topdelete = {
					text = "‾",
				},
				changedelete = {
					text = "~",
				},
				untracked = {
					text = "┆",
				},
			},
			signs_staged_enable = true,
			signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
			numhl = true, -- Toggle with `:Gitsigns toggle_numhl`
			linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
			word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
			watch_gitdir = {
				follow_files = true,
			},
			auto_attach = true,
			attach_to_untracked = false,
			current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
			current_line_blame_opts = {
				virt_text = true,
				virt_text_pos = "right_align", -- 'eol' | 'overlay' | 'right_align'
				delay = 300,
				ignore_whitespace = false,
				virt_text_priority = 100,
				use_focus = true,
			},
			current_line_blame_formatter = "<author>, <author_time:%R> - <summary>",
			sign_priority = 6,
			update_debounce = 100,
			status_formatter = nil, -- Use default
			max_file_length = 40000, -- Disable if file is longer than this (in lines)
			preview_config = {
				-- Options passed to nvim_open_win
				border = "single",
				style = "minimal",
				relative = "cursor",
				row = 0,
				col = 1,
			},
			on_attach = function(bufnr)
				local gitsigns = require("gitsigns")

				local function map(mode, l, r, opts)
					opts = opts or {}
					opts.buffer = bufnr
					vim.keymap.set(mode, l, r, opts)
				end

				-- Navigation
				map("n", "]c", function()
					if vim.wo.diff then
						vim.cmd.normal({
							"]c",
							bang = true,
						})
					else
						gitsigns.nav_hunk("next")
					end
				end)

				map("n", "[c", function()
					if vim.wo.diff then
						vim.cmd.normal({
							"[c",
							bang = true,
						})
					else
						gitsigns.nav_hunk("prev")
					end
				end)

				-- Actions
				map("n", "<leader>hs", gitsigns.stage_hunk, {
					desc = "Stage Hunk",
				})
				map("n", "<leader>hr", gitsigns.reset_hunk, {
					desc = "Reset Hunk",
				})

				map("v", "<leader>hs", function()
					gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, {
					desc = "Stage Hunk",
				})

				map("v", "<leader>hr", function()
					gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, {
					desc = "Reset Hunk",
				})

				map("n", "<leader>hS", gitsigns.stage_buffer, {
					desc = "Stage Buffer",
				})
				map("n", "<leader>hR", gitsigns.reset_buffer, {
					desc = "Reset Buffer",
				})
				map("n", "<leader>hp", gitsigns.preview_hunk, {
					desc = "Preview Hunk",
				})
				map("n", "<leader>hi", gitsigns.preview_hunk_inline, {
					desc = "Preview Hunk Inline",
				})

				map("n", "<leader>hb", function()
					gitsigns.blame_line({
						full = true,
					})
				end, {
					desc = "Blame Line",
				})

				map("n", "<leader>hd", gitsigns.diffthis, {
					desc = "Diff This",
				})

				map("n", "<leader>hD", function()
					gitsigns.diffthis("~")
				end, {
					desc = "Diff This ~",
				})

				map("n", "<leader>hQ", function()
					gitsigns.setqflist("all")
				end, {
					desc = "Set QFList",
				})
				map("n", "<leader>hq", gitsigns.setqflist, {
					desc = "Set QFList",
				})

				-- Toggles
				map("n", "<leader>htb", gitsigns.toggle_current_line_blame, {
					desc = "Toggle Current Line Blame",
				})
				map("n", "<leader>htd", gitsigns.toggle_deleted, {
					desc = "Toggle Deleted",
				})
				map("n", "<leader>htw", gitsigns.toggle_word_diff, {
					desc = "Toggle Word Diff",
				})

				-- Text object
				map({ "o", "x" }, "ih", gitsigns.select_hunk, {
					desc = "Select Hunk",
				})
			end,
		},
	},
}
