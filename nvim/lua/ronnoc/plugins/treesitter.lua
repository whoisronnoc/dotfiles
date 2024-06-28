return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPre", "BufNewFile" },
  build = ":TSUpdate",
  dependencies = {
    "windwp/nvim-ts-autotag",
  },
  config = function()
    -- import nvim-treesitter plugin
    local treesitter = require("nvim-treesitter.configs")

    -- configure treesitter
    treesitter.setup({ -- enable syntax highlighting
      highlight = {
        enable = true,
      },
      -- enable indentation
      indent = { enable = true },
      -- enable autotagging (w/ nvim-ts-autotag plugin)
      autotag = {
        enable = true,
      },
      -- ensure these language parsers are installed
      ensure_installed = {
        "json",
        "javascript",
        "typescript",
        "tsx",
        "yaml",
        "html",
        "css",
        "prisma",
        "markdown",
        "markdown_inline",
        "svelte",
        "graphql",
        "bash",
        "lua",
        "vim",
        "dockerfile",
        "gitignore",
        "query",
        "vimdoc",
        "c",
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },
    })
  end,
}

-- { -- Highlight, edit, and navigate code
-- 'nvim-treesitter/nvim-treesitter',
-- build = ':TSUpdate',
-- opts = {
--   ensure_installed = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'vim', 'vimdoc' },
--   -- Autoinstall languages that are not installed
--   auto_install = true,
--   highlight = {
--     enable = true,
--     -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
--     --  If you are experiencing weird indenting issues, add the language to
--     --  the list of additional_vim_regex_highlighting and disabled languages for indent.
--     additional_vim_regex_highlighting = { 'ruby' },
--   },
--   indent = { enable = true, disable = { 'ruby' } },
-- },
-- config = function(_, opts)
--   -- [[ Configure Treesitter ]] See `:help nvim-treesitter`

--   -- Prefer git instead of curl in order to improve connectivity in some environments
--   require('nvim-treesitter.install').prefer_git = true
--   ---@diagnostic disable-next-line: missing-fields
--   require('nvim-treesitter.configs').setup(opts)

--   -- There are additional nvim-treesitter modules that you can use to interact
--   -- with nvim-treesitter. You should go explore a few and see what interests you:
--   --
--   --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
--   --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
--   --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
-- end,
-- },
