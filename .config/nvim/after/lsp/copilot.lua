return vim.fn.getenv("AI_PROXY_ENABLED") ~= "v:null"
		and {
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
		settings = {
			telemetry = {
				telemetryLevel = "off",
			},
		},
	}
