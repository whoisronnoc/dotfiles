return {
	settings = {
		yaml = {
			schemas = require("schemastore").yaml.schemas(),
			schemaStore = {
				enable = false,
				url = "",
			},
			customTags = {
				"!If sequence",
				"!Equals sequence",
				"!FindInMap sequence",
				"!GetAtt",
				"!GetAZs",
				"!ImportValue",
				"!Join sequence",
				"!Ref",
				"!Select sequence",
				"!Split sequence",
				"!Sub",
			},
		},
	},
}
