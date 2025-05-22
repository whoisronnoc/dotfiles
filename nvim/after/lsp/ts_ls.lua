local function get_vue_path(root_dir, default)
	local project_root = vim.fs.dirname(vim.fs.find("node_modules", { path = root_dir, upward = true })[1])
	local vuels = project_root and vim.fs.joinpath(project_root, "node_modules", "@vue", "language-server") or default
	-- Return the value if it exists else empty string
	return vim.uv.fs_stat(vuels) and vuels or ""
end

local vue_plugin = {
	name = "@vue/typescript-plugin",
	location = vim.fn.stdpath("data") .. "/mason/packages/vue-language-server/node_modules/@vue/language-server",
	languages = { "vue" },
}

local inlayHints = {
	includeInlayParameterNameHints = "all",
	includeInlayParameterNameHintsWhenArgumentMatchesName = true,
	includeInlayFunctionParameterTypeHints = true,
	includeInlayVariableTypeHints = true,
	includeInlayVariableTypeHintsWhenTypeMatchesName = true,
	includeInlayPropertyDeclarationTypeHints = true,
	includeInlayFunctionLikeReturnTypeHints = true,
	includeInlayEnumMemberValueHints = true,
}

return {
	-- handlers = {
	-- ["textDocument/publishDiagnostics"] = function(err, result, ctx)
	-- 	-- require("ts-error-translator").translate_diagnostics(err, result, ctx)
	-- 	vim.lsp.diagnostic.on_publish_diagnostics(err, result, ctx)
	-- end,
	-- 	["textDocument/publishDiagnostics"] = function(_, result, ctx, config)
	-- 		if result.diagnostics == nil then
	-- 			return
	-- 		end
	--
	-- 		-- ignore some tsserver diagnostics
	-- 		local idx = 1
	-- 		while idx <= #result.diagnostics do
	-- 			local entry = result.diagnostics[idx]
	--
	-- 			local formatter = require("format-ts-errors")[entry.code]
	-- 			entry.message = formatter and formatter(entry.message) or entry.message
	--
	-- 			-- codes: https://github.com/microsoft/TypeScript/blob/main/src/compiler/diagnosticMessages.json
	-- 			if entry.code == 80001 then
	-- 				-- { message = "File is a CommonJS module; it may be converted to an ES module.", }
	-- 				table.remove(result.diagnostics, idx)
	-- 			else
	-- 				idx = idx + 1
	-- 			end
	-- 		end
	--
	-- 		vim.lsp.diagnostic.on_publish_diagnostics(_, result, ctx, config)
	-- 	end,
	-- },
	--- @type lsp.ClientCapabilities
	capabilities = {
		textDocument = {
			formatting = nil,
		},
	},
	init_options = {
		preferences = inlayHints,
		plugins = {
			vue_plugin,
		},
	},
	-- javascript = {
	-- 	inlayHints = inlayHints,
	-- },
	-- typescript = {
	-- 	tsserver = {
	-- 		useSyntaxServer = false,
	-- 	},
	-- 	inlayHints = inlayHints,
	-- },
	before_init = function(_, config)
		-- Check that we haven't set anything yet
		if not config.init_options or config.init_options.plugins then
			return
		end

		local lib_path = get_vue_path(config.root_dir, "/usr/local/lib/node_modules/@vue/language-server")
		-- Maybe add an exists check here
		if lib_path then
			vue_plugin.location = lib_path
			config.init_options.plugins = { vue_plugin }
		else
			config.init_options.plugins = {}
		end
	end,
	filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact" },
}
