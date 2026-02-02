local project_root_and_ids = {
	-- ["/path/to/project/root"] = "<project key you to take from sonarqube>",
}

local setup_sonarlint = function()
	-- local java_home = vim.fn.getenv("JAVA_HOME")
	local sonarlint_ls_jar =
		vim.fn.expand("$MASON/packages/sonarlint-language-server/extension/server/sonarlint-ls.jar")
	local sonarlint_analyzers_path = vim.fn.expand("$MASON/share/sonarlint-analyzers/")
	local sonarlint_analyzers = vim.fn.globpath(sonarlint_analyzers_path, "*.jar", false, true)

	-- vim.notify("Setting up SonarLint Language Server...", vim.log.levels.DEBUG, {
	-- 	title = "SonarLint",
	-- })
	-- vim.notify("JAVA_HOME: " .. java_home, vim.log.levels.DEBUG, {
	-- 	title = "SonarLint",
	-- })
	-- vim.notify("SonarLint LS JAR: " .. sonarlint_ls_jar, vim.log.levels.DEBUG, {
	-- 	title = "SonarLint",
	-- })
	-- vim.notify("SonarLint Analyzers Path: " .. sonarlint_analyzers_path, vim.log.levels.DEBUG, {
	-- 	title = "SonarLint",
	-- })
	-- vim.notify("SonarLint Analyzers: " .. table.concat(sonarlint_analyzers, ", "), vim.log.levels.DEBUG, {
	-- 	title = "SonarLint",
	-- })
	--
	local sonarlint_cmd = {
		-- java_home .. "/java",
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

	-- vim.notify(
	-- 	"Building SonarLint command: " .. table.concat(sonarlint_cmd, " "),
	-- 	vim.log.levels.DEBUG,
	-- 	{ title = "SonarLint" }
	-- )

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
				-- 	vim.log.levels.DEBUG,
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
				-- local project_root_and_ids = {
				-- ["/path/to/project/root"] = "<project key you to take from sonarqube>",
				-- }
				config.settings.sonarlint.connectedMode.project = {
					connectionId = os.getenv("SONARQUBE_ID"),
					-- projectKey = project_root_and_ids[params.rootPath],
					projectKey = project_root_and_ids[params.rootPath],
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
end

---@type LazyPluginSpec[]
return {
	{
		"https://gitlab.com/schrieveslaach/sonarlint.nvim",
		dependencies = {
			"neovim/nvim-lspconfig",
			"mason-org/mason-lspconfig.nvim",
			"williamboman/mason.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
		},
		config = function()
			-- vim.notify("Sonarlint Variables:", vim.log.levels.DEBUG, { title = "SonarLint" })
			-- vim.notify("SONARQUBE_ID: " .. tostring(vim.fn.getenv("SONARQUBE_ID")), vim.log.levels.DEBUG, {
			-- 	title = "SonarLint",
			-- })
			-- vim.notify("SONARQUBE_KEY: " .. tostring(vim.fn.getenv("SONARQUBE_KEY")), vim.log.levels.DEBUG, {
			-- 	title = "SonarLint",
			-- })
			-- vim.notify("SONARQUBE_URL: " .. tostring(vim.fn.getenv("SONARQUBE_URL")), vim.log.levels.DEBUG, {
			-- 	title = "SonarLint",
			-- })
			-- vim.notify("SONARQUBE_TOKEN: " .. tostring(vim.fn.getenv("SONARQUBE_TOKEN")), vim.log.levels.DEBUG, {
			-- 	title = "SonarLint",
			-- })
			if
				vim.fn.getenv("SONARQUBE_ID")
				and vim.fn.getenv("SONARQUBE_KEY")
				and vim.fn.getenv("SONARQUBE_URL")
				and vim.fn.getenv("SONARQUBE_TOKEN")
			then
				setup_sonarlint()
			end
		end,
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		optional = true,
		opts = {
			ensure_installed = {
				"sonarlint-language-server",
			},
		},
	},
}
