-- https://github.com/williamboman/mason.nvim
return {
	"williamboman/mason.nvim",
	config = function()
		-- import mason
		local mason = require("mason")

		-- import mason-lspconfig
		-- local mason_lspconfig = require("mason-lspconfig")
		-- local mason_tool_installer = require("mason-tool-installer")

		-- enable mason and configure icons
		mason.setup({
				ui = {
						icons = {
								package_installed = "✓",
								package_pending = "➜",
								package_uninstalled = "✗"
						}
				}
		})

		-- mason_lspconfig.setup({
		-- 		-- list of servers for mason to install
		-- 		ensure_installed = {"html", "cssls", "tailwindcss", "svelte", "lua_ls", "graphql", "emmet_ls", "prismals",
		-- 												"pyright"}
		-- })

		-- mason_tool_installer.setup({
		-- 		ensure_installed = {"prettier", -- prettier formatter
		-- 		"stylua", -- lua formatter
		-- 		"isort", -- python formatter
		-- 		"black", -- python formatter
		-- 		"pylint", "eslint_d"}
		-- })
	end
}
-- -- Mason
-- --- @return LazyPluginSpec[]
-- return {
-- 	-- Ensure the servers and tools above are installed
-- 	--  To check the current status of installed tools and/or manually install
-- 	--  other tools, you can run
-- 	--    :Mason
-- 	--
-- 	--  You can press `g?` for help in this menu.
-- 	-- require("mason").setup()
-- 	--- @type LazyPluginSpec
-- 	{ -- Mason general setup
-- 		"williamboman/mason.nvim",
-- 		config = true,
-- 		lazy = false,
-- 	},
-- }