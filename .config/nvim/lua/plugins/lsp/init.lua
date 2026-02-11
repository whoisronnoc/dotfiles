-- Brief aside: **What is LSP?**
--
-- LSP is an initialism you've probably heard, but might not understand what it is.
--
-- LSP stands for Language Server Protocol. It's a protocol that helps editors
-- and language tooling communicate in a standardized fashion.
--
-- In general, you have a "server" which is some tool built to understand a particular
-- language (such as `gopls`, `lua_ls`, `rust_analyzer`, etc.). These Language Servers
-- (sometimes called LSP servers, but that's kind of like ATM Machine) are standalone
-- processes that communicate with some "client" - in this case, Neovim!
--
-- LSP provides Neovim with features like:
--  - Go to definition
--  - Find references
--  - Autocompletion
--  - Symbol Search
--  - and more!
--
-- Thus, Language Servers are external tools that must be installed separately from
-- Neovim. This is where `mason` and related plugins come into play.
--
-- If you're wondering about lsp vs treesitter, you can check out the wonderfully
-- and elegantly composed help section, `:help lsp-vs-treesitter`

---@module "lazy"
---@class LazyKeysLspSpec: LazyKeysSpec,vim.keymap.set.Opts
---@field method? string|string[] lsp methods that allow this to bind
---@class LazyKeysLsp: LazyKeys
---@field method? string|string[] lsp methods that allow this to bind
---@class LspServerConfig: vim.lsp.Config
---@field keys? LazyKeysLspSpec[]

---@type LazyPluginSpec
return {
	-- Main LSP Configuration
	"neovim/nvim-lspconfig",
	import = "plugins.lsp",
	lazy = true,
	event = { "LazyFile" },
	cmd = { "LspInfo", "LspInstall", "LspUninstall" },
	-- keys = {
	-- { "<leader>ms", "<cmd>LspInfo<CR>", desc = "LSP Info" },
	-- },
	-- `opts_extend` can be a list of dotted keys that will be extended instead of merged
	opts_extend = { "keys", "servers.*.keys", "diagnostics" },
}
