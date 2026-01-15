local sonarlint_ls_jar = vim.fn.expand("$MASON/packages/sonarlint-language-server/extension/server/sonarlint-ls.jar")
local sonarlint_analyzers_path = vim.fn.expand("$MASON/share/sonarlint-analyzers/")
local sonarlint_analyzers = vim.fn.globpath(sonarlint_analyzers_path, "*.jar", false, true)

local sonarlint_cmd = {
	"java",
	-- "-Dhttps.proxyHost=proxy-tls.company.com",
	-- "-Dhttps.proxyPort=8080",
	-- "-Dhttp.proxyUser=user",
	-- "-Dhttp.proxyPassword=" .. proxy_password,
	-- "-Dhttps.proxyUser=user",
	-- "-Dhttps.proxyPassword=" .. proxy_password,
	-- "-Dhttp.proxyHost=proxy.company.at",
	-- "-Dhttp.proxyPort=8080",
	-- "-Djdk.http.auth.tunneling.disabledSchemes=",
	-- "-Djdk.http.auth.proxying.disabledSchemes=",
	"-jar",
	sonarlint_ls_jar,
	"-stdio",
	"-analyzers",
}

for _, v in ipairs(sonarlint_analyzers) do
	table.insert(sonarlint_cmd, v)
end

require("sonarlint").setup({
	connected = {
		-- client_id is the ID of the Sonar LSP
		-- url is the url it wants to connect to
		get_credentials = function(client_id, url)
			-- vim.notify(
			-- 	"Getting SonarQube credentials for client_id: " .. client_id .. " and url: " .. url,
			-- 	vim.log.levels.INFO,
			-- 	{ title = "SonarLint" }
			-- )
			-- This must return a string (User token)
			return vim.fn.getenv("SONARQUBE_TOKEN")
		end,
	},
	server = {
		cmd = sonarlint_cmd,
		settings = {
			sonarlint = {
				connectedMode = {
					connections = {
						sonarqube = {
							{
								-- this is the url that will go into get_credentials
								connectionId = os.getenv("SONARQUBE_ID"),
								serverUrl = os.getenv("SONARQUBE_URL"),
								disableNotifications = false,
							},
						},
					},
				},
			},
		},

		before_init = function(params, config)
			-- Your personal configuration needs to provide a mapping of root folders and project keys
			local project_root_and_ids = {
				-- ["/path/to/project/root"] = "<project key you to take from sonarqube>",
			}

			config.settings.sonarlint.connectedMode.project = {
				connectionId = os.getenv("SONARQUBE_ID"),
				-- projectKey = project_root_and_ids[params.rootPath],
				projectKey = os.getenv("SONARQUBE_KEY"),
			}
		end,
	},
	filetypes = {
		"javascript",
		"typescript",
		"javascriptreact",
		"typescriptreact",
		"html",
		"htmlangular",
		"vue",
	},
})
