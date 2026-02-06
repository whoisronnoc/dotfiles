-- set globals
-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Set global border definition for hovers
-- Can be one of the pre-defined styles: `"double"`, `"none"`, `"rounded"`, `"shadow"`, `"single"` or `"solid"`.
vim.g.winborder = "single"
-- vim.g.winborder = "none"
-- the new one that exists but is still buggy
-- vim.o.winborder = "rounded"

vim.g.have_nerd_font = true

require("config.options")
require("config.keymaps")
require("config.autocmds")
-- require("config.filetypes")
