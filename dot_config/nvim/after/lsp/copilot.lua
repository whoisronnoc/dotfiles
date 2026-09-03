return vim.fn.getenv("AI_PROXY_ENABLED") ~= "v:null"
		and {
			lualine = {
				name = "",
				color = "#8957e5",
			},
			settings = {
				http = {
					proxy = vim.fn.getenv("AI_URL"),
					proxyStrictSSL = false,
				},
				telemetry = {
					telemetryLevel = "off",
				},
			},
		}
	or {
		lualine = {
			name = "",
			color = "#8957e5",
		},
		settings = {
			telemetry = {
				telemetryLevel = "off",
			},
		},
	}
