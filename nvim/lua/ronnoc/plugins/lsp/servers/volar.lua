-- volar
return {
	filetypes = { "vue", "javascript", "typescript", "javascriptreact", "typescriptreact" },
	init_options = {
		vue = {
			hybridMode = false,
		},
		typescript = {
			tsdk = vim.fn.getcwd() .. "/node_modules/typescript/lib",
		},
	},
}
