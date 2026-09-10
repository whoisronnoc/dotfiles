---@module "lazy"
---@return LazyPluginSpec
return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		optional = true,
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
	},
	{
		"nvim-tree/nvim-web-devicons",
		lazy = true,
		config = function()
			require("nvim-web-devicons").setup({
				color_icons = true,
				default = true,
				override_by_extension = {
					-- ["spec.ts"] = {
					-- icon = "",
					-- color = "#f5bc40",
					-- name = "Test",
					-- },
					["stories.js"] = {
						icon = "",
						color = "#eb5685",
						name = "Storybook",
					},
					["component.ts"] = {
						icon = "",
						color = "#4267b7",
						name = "AngularComponent",
					},
					["service.ts"] = {
						icon = "",
						color = "#f5bc40",
						name = "AngularService",
					},
					["module.ts"] = {
						icon = "",
						color = "#c92e3a",
						name = "AngularModule",
					},
					["guard.ts"] = {
						icon = "",
						color = "#cbe697",
						name = "AngularGuard",
					},
					["directive.ts"] = {
						icon = "",
						color = "#f2a1ad",
						name = "AngularDirective",
					},
					["pipe.ts"] = {
						icon = "",
						color = "#9cdcfc",
						name = "AngularPipe",
					},
					["model.ts"] = {
						icon = "",
						color = "#4267b7",
						name = "TypeScriptModel",
					},
					["type.ts"] = {
						icon = "",
						color = "#4267b7",
						name = "TypeScriptType",
					},
				},
			})
		end,
	},
}
