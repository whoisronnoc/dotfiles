local M = {}

function M.map_inlay_hints(buffer)
	vim.keymap.set("n", "<leader>ch", function()
		vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = buffer }))
	end, { desc = "Toggle Inlay [C]ode [H]ints" })
end

-- setup lsp keybinds
function M.setup(buffer)
  -- stylua: ignore start
	vim.keymap.set("n", "gd",         Snacks.picker.lsp_definitions,       { buffer = buffer, desc = "[G]oto [D]efinition" })
	vim.keymap.set("n", "gD",         Snacks.picker.lsp_declarations,      { buffer = buffer, desc = "[G]oto [D]eclaration" })
	vim.keymap.set("n", "gr",         Snacks.picker.lsp_references,        { buffer = buffer, desc = "[R]eferences", nowait = true, })
	vim.keymap.set("n", "gI",         Snacks.picker.lsp_implementations,   { buffer = buffer, desc = "Goto [I]mplementation" })
	vim.keymap.set("n", "gy",         Snacks.picker.lsp_type_definitions,  { buffer = buffer, desc = "Goto T[y]pe Definition" })
	vim.keymap.set("n", "<leader>ss", Snacks.picker.lsp_symbols,           { buffer = buffer, desc = "LSP [S]ymbols" })
	vim.keymap.set("n", "<leader>sS", Snacks.picker.lsp_workspace_symbols, { buffer = buffer, desc = "LSP Workspace [S]ymbols" })
	-- map("gd", vim.lsp.buf.definition, { desc = "[G]oto [D]efinition" })
	-- map("gD", vim.lsp.buf.declaration, { desc = "[G]oto [D]eclaration" })
	-- map("gr", vim.lsp.buf.references, { nowait = true, desc = "[R]eferences" })

	-- Rename the variable under your cursor.
	--  Most Language Servers support renaming across files, etc.
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = buffer, desc = "[R]e[n]ame" })

	-- Execute a code action, usually your cursor needs to be on top an error
	-- or a suggestion from your LSP for this to activate.
  vim.keymap.set({ "n", "x" }, "<leader>ca", vim.lsp.buf.code_action, { buffer = buffer, desc = "[C]ode [A]ction" })
end
return M
