---@class utils.lsp
local M = {}

M.action = setmetatable({}, {
	__index = function(_, action)
		return function()
			vim.notify("Applying action: " .. action, vim.log.levels.INFO, { timeout = 1000 })
			vim.lsp.buf.code_action({
				apply = true,
				context = {
					only = { action },
					diagnostics = {},
				},
			})
		end
	end,
})

M.action_callback = function(action, callback)
	vim.notify("Applying action with callback: " .. action, vim.log.levels.INFO, { timeout = 1000 })
	vim.lsp.buf.code_action({
		apply = true,
		context = {
			only = { action },
			diagnostics = {},
		},
	}, callback)
end
--
-- M.organize_imports = M.action["source.organizeImports"]
-- M.sort_imports = M.action["source.sortImports"]
-- M.remove_unused_imports = M.action["source.removeUnusedImports"]
-- M.add_missing_imports = M.action["source.addMissingImports"]
--
M.common_save_actions = function()
	vim.notify("Applying common save actions...", vim.log.levels.INFO, { timeout = 1000 })
	M.action_callback(
		"source.removeUnusedImports",
		M.action_callback(
			"source.addMissingImports",
			M.action_callback(
				"source.sortImports",
				M.action_callback(
					"source.organizeImports",
					vim.notify("Finished applying common save actions.", vim.log.levels.INFO, { timeout = 1000 })
				)
			)
		)
	)
end
return M
