if
	os.getenv("SONARQUBE_ID")
	and os.getenv("SONARQUBE_KEY")
	and os.getenv("SONARQUBE_URL")
	and os.getenv("SONARQUBE_TOKEN")
then
	require("extras.sonarlint.sonarlint")
end

return {

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
