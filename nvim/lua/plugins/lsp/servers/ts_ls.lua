-- ts_ls
return {
	--- @type lsp.ClientCapabilities
	capabilities = {
		textDocument = {
			formatting = nil,
		},
	},
	init_options = {
		plugins = {
			{
				name = "@vue/typescript-plugin",
				location = "/usr/local/lib/node_modules/@vue/language-server",
				languages = { "vue" },
			},
		},
	},
	on_new_config = function(new_config, new_root_dir)
		local lib_path = vim.fs.find("node_modules/typescript", { path = new_root_dir, upward = true })[1]
		if lib_path then
			new_config.init_options.plugins[0].location = lib_path
		end
	end,
	filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact" },
}
