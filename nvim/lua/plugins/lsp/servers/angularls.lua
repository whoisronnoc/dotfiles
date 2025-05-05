return {
	--- @type lsp.ClientCapabilities
	capabilities = {
		textDocument = {
			formatting = nil,
		},
	},
	init_options = {
		plugins = { -- I think this was my breakthrough that made it work
			{
				name = "@angular/typescript-plugin",
				location = "/usr/local/lib/node_modules/@angular/language-server",
				languages = { "angular" },
			},
		},
	},
	on_new_config = function(new_config, new_root_dir)
		local lib_path = vim.fs.find("node_modules/@angular/language-server", { path = new_root_dir, upward = true })[1]
		if lib_path then
			new_config.init_options.plugins[0].location = lib_path
		end
	end,
	filetypes = { "typescript", "html", "typescriptreact", "typescript.tsx", "htmlangular" },
}
