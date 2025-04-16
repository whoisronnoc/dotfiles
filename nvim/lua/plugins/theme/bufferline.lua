-- https://github.com/akinsho/bufferline.nvim
return {
	"akinsho/bufferline.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	event = { "BufReadPost", "BufNewFile" },
  -- stylua: ignore
	keys = {
		{ "<C-1>", "<Cmd>BufferLineGoToBuffer 1<CR>", desc = "Go to buffer 1" },
		{ "<C-2>", "<Cmd>BufferLineGoToBuffer 2<CR>", desc = "Go to buffer 2" },
		{ "<C-3>", "<Cmd>BufferLineGoToBuffer 3<CR>", desc = "Go to buffer 3" },
		{ "<C-4>", "<Cmd>BufferLineGoToBuffer 4<CR>", desc = "Go to buffer 4" },
		{ "<C-5>", "<Cmd>BufferLineGoToBuffer 5<CR>", desc = "Go to buffer 5" },
		{ "<C-6>", "<Cmd>BufferLineGoToBuffer 6<CR>", desc = "Go to buffer 6" },
		{ "<C-7>", "<Cmd>BufferLineGoToBuffer 7<CR>", desc = "Go to buffer 7" },
		{ "<C-8>", "<Cmd>BufferLineGoToBuffer 8<CR>", desc = "Go to buffer 8" },
		{ "<C-9>", "<Cmd>BufferLineGoToBuffer 9<CR>", desc = "Go to buffer 9" },
		{ "<S-l>", "<Cmd>BufferLineCycleNext<CR>", desc = "Next buffer" },
		{ "<S-h>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Previous buffer" },
		{ "<A-S-l>", "<Cmd>BufferLineMoveNext<CR>", desc = "Move buffer right" },
		{ "<A-S-h>", "<Cmd>BufferLineMovePrev<CR>", desc = "Move buffer left" },
		{ "<leader>bo", "<Cmd>BufferLinePick<CR>", desc = "Select a buffer to open" },
		{ "<leader>bc", "<Cmd>BufferLinePickClose<CR>", desc = "Select a buffer to close" },
		{ "[b", "<Cmd>BufferLineCyclePrev<CR>", desc = "Previous buffer" },
		{ "]b", "<Cmd>BufferLineCycleNext<CR>", desc = "Next buffer" },
		{ "<leader>bd", function() require("mini.bufremove").delete(0, true) end, desc = "Delete current buffer" },
		{ "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", desc = "Close buffers to the left" },
		{ "<leader>br", "<Cmd>BufferLineCloseRight<CR>", desc = "Close buffers to the right" },
		{ "<leader>ba", "<Cmd>BufferLineCloseOthers<CR>", desc = "Close all other buffers" },
	},
	opts = function()
		return {
			options = {
				separator_style = "thick",
				indicator = {
					style = "none",
				},
				close_command = function(n)
					require("mini.bufremove").delete(n, false)
				end,
				diagnostics = "nvim_lsp",
				diagnostics_indicator = function(count, _, _, _)
					if count > 9 then
						return "9+"
					end
					return tostring(count)
				end,
				offsets = {
					{
						filetype = "neo-tree",
						text = "EXPLORER",
						text_align = "center",
					},
				},
				hover = {
					enabled = true,
					delay = 0,
					reveal = { "close" },
				},
			},
		}
	end,
}
