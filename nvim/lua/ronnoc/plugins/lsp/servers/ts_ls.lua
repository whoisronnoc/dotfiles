-- ts_ls
return {
	init_options = {
		typescript = {
			tsdk = vim.fn.getcwd() .. "/node_modules/typescript/lib",
		},
	},
	filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact" },
}
