-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- vim.cmd([[2match WhiteSpaceBol /^ \+/]])
-- vim.cmd('match WhiteSpaceMol / /')
-- vim.api.nvim_set_hl(0, 'WhiteSpaceMol', {
--     fg = string.format('#%x', vim.api.nvim_get_hl(0, { name = 'Normal' }).bg)
-- })

-- vim.cmd([[2match WhiteSpaceBol /^ \+/]])
-- vim.cmd('match WhiteSpaceMol / /')
-- vim.api.nvim_set_hl(0, 'WhiteSpaceMol', {
--     fg = string.format('#%x', vim.api.nvim_get_hl(0, { name = 'Normal' }).bg)
-- })
-- vim.api.nvim_create_autocmd('ColorScheme', {
--     callback = function()
--         vim.api.nvim_set_hl(0, 'WhiteSpaceMol', {
--             fg = string.format('#%x', vim.api.nvim_get_hl(0, { name = 'Normal' }).bg)
--         })
--     end
-- })

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({ { import = "ronnoc.plugins" }, { import = "ronnoc.plugins.lsp" } }, {
  checker = {
    enabled = true,
    notify = false,
  },
  change_detection = {
    notify = false,
  },
})

-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins you can run
--    :Lazy update
