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
  ui {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
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

---

-- { -- Collection of various small independent plugins/modules
--   'echasnovski/mini.nvim',
--   config = function()
--     -- Better Around/Inside textobjects
--     --
--     -- Examples:
--     --  - va)  - [V]isually select [A]round [)]paren
--     --  - yinq - [Y]ank [I]nside [N]ext [']quote
--     --  - ci'  - [C]hange [I]nside [']quote
--     require('mini.ai').setup { n_lines = 500 }

--     -- Add/delete/replace surroundings (brackets, quotes, etc.)
--     --
--     -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
--     -- - sd'   - [S]urround [D]elete [']quotes
--     -- - sr)'  - [S]urround [R]eplace [)] [']
--     require('mini.surround').setup()

--     -- Simple and easy statusline.
--     --  You could remove this setup call if you don't like it,
--     --  and try some other statusline plugin
--     local statusline = require 'mini.statusline'
--     -- set use_icons to true if you have a Nerd Font
--     statusline.setup { use_icons = vim.g.have_nerd_font }

--     -- You can configure sections in the statusline by overriding their
--     -- default behavior. For example, here we set the section for
--     -- cursor location to LINE:COLUMN
--     ---@diagnostic disable-next-line: duplicate-set-field
--     statusline.section_location = function()
--       return '%2l:%-2v'
--     end

--     -- ... and there is more!
--     --  Check out: https://github.com/echasnovski/mini.nvim
--   end,
-- }