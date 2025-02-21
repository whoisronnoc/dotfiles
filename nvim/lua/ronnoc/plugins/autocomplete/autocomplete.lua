-- Autocompletion
return {
	{
		"saghen/blink.cmp",
		event = "InsertEnter",
		dependencies = {
			"rafamadriz/friendly-snippets",
			"fang2hou/blink-copilot",
		},
		version = "*",
		opts = {
			keymap = {
				preset = "default",

				-- Default mappings
				-- ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
				-- ['<C-e>'] = { 'cancel', 'fallback' },
				-- ['<C-y>'] = { 'select_and_accept' },

				-- Select the [p]revious item
				-- ['<C-p>'] = { 'select_prev', 'fallback' },
				-- ['<Up>'] = { 'select_prev', 'fallback' },

				-- Select the [n]ext item
				-- ['<C-n>'] = { 'select_next', 'fallback' },
				-- ['<Down>'] = { 'select_next', 'fallback' },

				-- Scroll the documentation window [b]ack / [f]orward
				-- ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
				-- ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },

				-- unbinding tab this now goes to copilot if you remove copilot
				-- add this back
				-- ['<Tab>'] = { 'snippet_forward', 'fallback' },
				-- ['<S-Tab>'] = { 'snippet_backward', 'fallback' },

				-- Enter will insert whether is selected
				-- or enter if nothing is yet
				["<CR>"] = { "accept", "fallback" },
				-- Tab will accept the ghost text or the selection first
				["<Tab>"] = {
					function(cmp)
						if cmp.snippet_active() then
							return cmp.accept()
						else
							return cmp.select_and_accept()
						end
					end,
					"snippet_forward",
					"fallback",
				},
				["<S-Tab>"] = { "snippet_backward", "fallback" },

				-- ['<C-k>'] = { 'show_signature', 'hide_signature', 'fallback' },

				-- Accept ([y]es) the completion.
				--  This will auto-import if your LSP supports it.
				--  This will expand snippets if the LSP sent a snippet.

				-- cmdline = {
				-- 	-- disable enter for the cmdline completion
				-- 	["<CR>"] = {},
				-- },
			},

			appearance = {
				-- Sets the fallback highlight groups to nvim-cmp's highlight groups
				-- Useful for when your theme doesn't support blink.cmp
				-- Will be removed in a future release
				use_nvim_cmp_as_default = true,
				-- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
				-- Adjusts spacing to ensure icons are aligned
				nerd_font_variant = "mono",
				-- Custom icons
				kind_icons = {
					Copilot = "",
				},
			},

			-- Default list of enabled providers defined so that you can extend it
			-- elsewhere in your config, without redefining it, due to `opts_extend`
			sources = {
				default = { "copilot", "lsp", "path", "snippets" },
				-- default = { "copilot", "lsp", "path", "snippets", "buffer" },
				providers = {
					copilot = {
						name = "copilot",
						module = "blink-copilot",
						score_offset = 100,
						async = true,
						opts = {
							max_completions = 3,
							max_attempts = 4,
							-- kind = "Copilot",
							debounce = 500, ---@type integer | false
							auto_refresh = {
								backward = true,
								forward = true,
							},
						},
					},
				},
			},
			-- Completion behavior
			completion = {
				ghost_text = {
					enabled = true,
					-- Show the ghost text when an item has been selected
					show_with_selection = true,
					-- Show the ghost text when no item has been selected, defaulting to the first item
					show_without_selection = true,
				},
				documentation = {
					-- Controls whether the documentation window will automatically show when selecting a completion item
					auto_show = true,
					-- Delay before showing the documentation window
					auto_show_delay_ms = 500,
					-- Delay before updating the documentation window when selecting a new item,
					-- while an existing item is still visible
					update_delay_ms = 50,
					-- Whether to use treesitter highlighting, disable if you run into performance issues
					treesitter_highlighting = true,
				},
				list = {
					selection = {
						preselect = false,
						-- preselect = function(ctx)
						-- 	return ctx.mode ~= "cmdline"
						-- 	-- return ctx.mode ~= "cmdline" and not require("blink.cmp").snippet_active({ direction = 1 })
						-- end,
						auto_insert = false,
						-- auto_insert = function(ctx)
						-- 	return ctx.mode ~= "cmdline"
						-- end,
					},
				},
				menu = {
					draw = vim.g.have_nerd_font and {} or {
						columns = {
							{ "label", "label_description", gap = 1 },
							{ "kind" },
						},
					},
				},
			},
			-- Show the signature help when typing
			signature = {
				enabled = true,
				trigger = {
					-- Show the signature help automatically
					enabled = true,
					-- Show the signature help window after typing any of alphanumerics, `-` or `_`
					show_on_keyword = false,
					blocked_trigger_characters = {},
					blocked_retrigger_characters = {},
					-- Show the signature help window after typing a trigger character
					show_on_trigger_character = true,
					-- Show the signature help window when entering insert mode
					show_on_insert = true,
					-- Show the signature help window when the cursor comes after a trigger character when entering insert mode
					show_on_insert_on_trigger_character = true,
				},
			},
		},
		opts_extend = { "sources.default" },
	},
}
