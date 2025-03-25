-- Autocompletion
--- @module 'blink.cmp'

--- @type blink.cmp.WindowBorder
local border = "none"

return {
	--- @type LazyPluginSpec
	{
		"saghen/blink.cmp",
		event = "InsertEnter",
		-- optional: provides snippets for the snippet source
		dependencies = {
			"xzbdmw/colorful-menu.nvim",
			"rafamadriz/friendly-snippets",
			{ "fang2hou/blink-copilot", version = "*" },
			"mikavilpas/blink-ripgrep.nvim",
			-- "Kaiser-Yang/blink-cmp-avante",
			-- "giuxtaposition/blink-cmp-copilot",
		},
		-- use a release tag to download pre-built binaries
		version = "*",
		-- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
		-- build = 'cargo build --release',
		-- If you use nix, you can build from source using latest nightly rust with:
		-- build = 'nix run .#build-plugin',

		--- @module 'blink.cmp'
		--- @type blink.cmp.Config
		opts = {
			-- 'default' for mappings similar to built-in completion
			-- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
			-- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
			-- See the full "keymap" documentation for information on defining your own keymap.
			keymap = {
				preset = "super-tab",
				["<A-1>"] = {
					function(cmp)
						cmp.accept({ index = 1 })
					end,
				},
				["<A-2>"] = {
					function(cmp)
						cmp.accept({ index = 2 })
					end,
				},
				["<A-3>"] = {
					function(cmp)
						cmp.accept({ index = 3 })
					end,
				},
				["<A-4>"] = {
					function(cmp)
						cmp.accept({ index = 4 })
					end,
				},
				["<A-5>"] = {
					function(cmp)
						cmp.accept({ index = 5 })
					end,
				},
				["<A-6>"] = {
					function(cmp)
						cmp.accept({ index = 6 })
					end,
				},
				["<A-7>"] = {
					function(cmp)
						cmp.accept({ index = 7 })
					end,
				},
				["<A-8>"] = {
					function(cmp)
						cmp.accept({ index = 8 })
					end,
				},
				["<A-9>"] = {
					function(cmp)
						cmp.accept({ index = 9 })
					end,
				},
				["<A-0>"] = {
					function(cmp)
						cmp.accept({ index = 10 })
					end,
				},
			},

			appearance = {
				use_nvim_cmp_as_default = true,
				nerd_font_variant = "mono",

				-- Custom icons
				kind_icons = {
					Copilot = "",
					Text = "󰉿",
					Method = "󰊕",
					Function = "󰊕",
					Constructor = "󰒓",

					Field = "󰜢",
					Variable = "󰆦",
					Property = "󰖷",

					Class = "󱡠",
					Interface = "󱡠",
					Struct = "󱡠",
					Module = "󰅩",

					Unit = "󰪚",
					Value = "󰦨",
					Enum = "󰦨",
					EnumMember = "󰦨",

					Keyword = "󰻾",
					Constant = "󰏿",

					Snippet = "󱄽",
					Color = "󰏘",
					File = "󰈔",
					Reference = "󰬲",
					Folder = "󰉋",
					Event = "󱐋",
					Operator = "󰪚",
					TypeParameter = "󰬛",
				},
			},

			completion = {
				ghost_text = {
					enabled = true,
					show_with_selection = true,
					show_without_selection = true,
				},

				documentation = {
					-- auto_show = true,
					-- auto_show_delay_ms = 500,
					-- update_delay_ms = 50,
					treesitter_highlighting = true,
					window = { border = border },
				},

				-- list = {
				-- 	selection = {
				-- 		preselect = false,
				-- 		-- preselect = function(ctx)
				-- 		-- 	return ctx.mode ~= "cmdline"
				-- 		-- 	-- return ctx.mode ~= "cmdline" and not require("blink.cmp").snippet_active({ direction = 1 })
				-- 		-- end,
				-- 		auto_insert = false,
				-- 		-- auto_insert = function(ctx)
				-- 		-- 	return ctx.mode ~= "cmdline"
				-- 		-- end,
				-- 	},
				-- },

				menu = {
					-- auto_show = true,
					draw = {
						columns = { { "kind_icon" }, { "label", gap = 1 } },
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
					border = border,
				},
			},

			-- Show the signature help when typing
			signature = {
				-- enabled = true,
				-- trigger = {
				-- 	enabled = true,
				-- 	show_on_keyword = false,
				-- 	blocked_trigger_characters = {},
				-- 	blocked_retrigger_characters = {},
				-- 	show_on_trigger_character = true,
				-- 	show_on_insert = true,
				-- 	show_on_insert_on_trigger_character = true,
				-- },
				window = { border = border },
			},

			cmdline = { enabled = true },

			sources = {
				default = {
					-- "avante",
					"copilot",
					"lsp",
					"path",
					"snippets",
					"lazydev",
					"buffer",
					-- "ripgrep",
				},
				-- removed "buffer"
				providers = {
					lazydev = {
						name = "LazyDev",
						module = "lazydev.integrations.blink",
						-- make lazydev completions top priority (see `:h blink.cmp`)
						score_offset = 50,
					},

					-- ripgrep = {
					-- 	module = "blink-ripgrep",
					-- 	name = "Ripgrep",
					-- 	opts = {
					-- 		prefix_min_len = 3,
					-- 		context_size = 5,
					-- 		max_filesize = "1M",
					-- 		additional_rg_options = {},
					-- 	},
					-- },

					-- copilot = {
					-- 	name = "copilot",
					-- 	module = "blink-cmp-copilot",
					-- 	score_offset = 100,
					-- 	async = true,
					-- 	transform_items = function(_, items)
					-- 		local CompletionItemKind = require("blink.cmp.types").CompletionItemKind
					-- 		local kind_idx = #CompletionItemKind + 1
					-- 		CompletionItemKind[kind_idx] = "Copilot"
					-- 		for _, item in ipairs(items) do
					-- 			item.kind = kind_idx
					-- 		end
					-- 		return items
					-- 	end,
					-- },
					copilot = {
						name = "copilot",
						module = "blink-copilot",
						score_offset = 100,
						async = true,
						opts = {
							max_completions = 3,
							max_attempts = 4,
							kind = "Copilot",
							debounce = 500, ---@type integer | false
							auto_refresh = {
								backward = true,
								forward = true,
							},
						},
					},
					-- avante = {
					-- 	module = "blink-cmp-avante",
					-- 	name = "Avante",
					-- 	opts = {
					-- 		-- options for blink-cmp-avante
					-- 	},
					-- },
				},
			},
		},

		opts_extend = {
			"sources.default",
			"sources.providers",
		},
	},
}
