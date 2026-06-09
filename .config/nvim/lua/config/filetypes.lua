vim.filetype.add({
	filename = {
		-- [".env"] = "config",
		["deployment.yaml"] = "helm",
		["Chart.yaml"] = "helm",
		["values.yaml"] = "helm",
		["service.yaml"] = "helm",
		["ingress.yaml"] = "helm",
	},
	pattern = {
		["**/helm/**.yaml"] = "helm",
		-- [".*%.component%.html"] = "htmlangular",
		-- ["%.?env.*"] = "config",
		-- ["%.?.ts"] = "typescript",
	},
})
