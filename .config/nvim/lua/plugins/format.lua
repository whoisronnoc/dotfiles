-- Format
---@module "lazy"
---@return LazyPluginSpec
return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
		{
			"<leader>=",
			function()
				require("conform").format({ async = true, lsp_format = "fallback" })
			end,
			mode = "",
			desc = "[F]ormat buffer",
		},
		{ "<leader>mc", "<cmd>ConformInfo<CR>", desc = "Conform Info" },
	},
	opts = {
		notify_on_error = false,
		format_on_save = function(bufnr)
			-- Disable "format_on_save lsp_fallback" for languages that don't
			-- have a well standardized coding style. You can add additional
			-- languages here or re-enable it for the disabled ones.
			local disable_filetypes = { c = true, cpp = true }
			local lsp_format_opt
			if disable_filetypes[vim.bo[bufnr].filetype] then
				lsp_format_opt = "never"
			else
				lsp_format_opt = "fallback"
			end
			return {
				timeout_ms = 500,
				lsp_format = lsp_format_opt,
			}
		end,
		formatters_by_ft = {},
	},
	-- config = function()
	-- 	local conform = require("conform")
	-- 	vim.g.autoformat = true
	--
	-- 	conform.setup({
	-- 		formatters_by_ft = require("plugins.lsp.config._formatters_ft"),
	-- 		format_on_save = function()
	-- 			if not vim.g.autoformat then
	-- 				return
	-- 			end
	-- 			return { timeout_ms = 1000, async = false, lsp_format = "fallback" }
	-- 		end,
	-- 	})
	--
	-- 	-- manual toggle command
	-- 	vim.api.nvim_create_user_command("FormatToggle", function()
	-- 		vim.g.autoformat = not vim.g.autoformat
	-- 	end, {
	-- 		desc = "Toggle autoformat-on-save",
	-- 	})
	-- 	-- vim.keymap.set({ "n", "v" }, "<leader>tf", "<cmd>FormatToggle<CR>", { desc = "Toggle autoformat-on-save" })
	--
	-- 	vim.keymap.set({ "n", "v" }, "<leader>mp", function()
	-- 		conform.format({
	-- 			lsp_format = "fallback",
	-- 			async = false,
	-- 			timeout_ms = 1000,
	-- 		})
	-- 	end, {
	-- 		desc = "Format file or range (in visual mode)",
	-- 	})
	-- end,
}
