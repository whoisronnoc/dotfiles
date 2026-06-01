return {
	lualine = {
		name = "",
		color = "#6700FF",
	},
	settings = {
		["helm-ls"] = {
			yamlls = {
				enabled = true, -- Optional: lets helm-ls bridge to yamlls
				path = "yaml-language-server",
			},
		},
	},
}
