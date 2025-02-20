-- https://github.com/folke/which-key.nvim
return { -- NOTE: Plugins can also be added by using a table,
-- with the first argument being the link and the following
-- keys can be used to configure plugin behavior/loading/etc.
--
-- Use `opts = {}` to force a plugin to be loaded.
--
-- NOTE: Plugins can also be configured to run Lua code when they are loaded.
--
-- This is often very useful to both group configuration, as well as handle
-- lazy loading plugins that don't need to be loaded immediately at startup.
--
-- For example, in the following configuration, we use:
--  event = 'VimEnter'
--
-- which loads which-key before all the UI elements are loaded. Events can be
-- normal autocommands events (`:help autocmd-events`).
--
-- Then, because we use the `config` key, the configuration only runs
-- after the plugin has been loaded:
--  config = function() ... end
{ -- Useful plugin to show you pending keybinds.
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
        ---@type false | "classic" | "modern" | "helix"
        preset = "helix",
        icons = {
            -- set icon mappings to true if you have a Nerd Font
            mappings = vim.g.have_nerd_font,
            -- If you are using a Nerd Font: set icons.keys to an empty table which will use the
            -- default whick-key.nvim defined Nerd Font icons, otherwise define a string table
            keys = vim.g.have_nerd_font and {} or {
                Up = "<Up> ",
                Down = "<Down> ",
                Left = "<Left> ",
                Right = "<Right> ",
                C = "<C-…> ",
                M = "<M-…> ",
                D = "<D-…> ",
                S = "<S-…> ",
                CR = "<CR> ",
                Esc = "<Esc> ",
                ScrollWheelDown = "<ScrollWheelDown> ",
                ScrollWheelUp = "<ScrollWheelUp> ",
                NL = "<NL> ",
                BS = "<BS> ",
                Space = "<Space> ",
                Tab = "<Tab> ",
                F1 = "<F1>",
                F2 = "<F2>",
                F3 = "<F3>",
                F4 = "<F4>",
                F5 = "<F5>",
                F6 = "<F6>",
                F7 = "<F7>",
                F8 = "<F8>",
                F9 = "<F9>",
                F10 = "<F10>",
                F11 = "<F11>",
                F12 = "<F12>"
            }
        },

        --- Document existing key chains
        --- You can add any mappings here, or use `require('which-key').add()` later
        -- ---@type wk.Spec
        -- spec = {{
        --     "<leader>c",
        --     group = "[C]ode",
        --     mode = {"n", "x"}
        -- }, {
        --     "<leader>d",
        --     group = "[D]ocument"
        -- }, {
        --     "<leader>r",
        --     group = "[R]ename"
        -- }, {
        --     "<leader>s",
        --     group = "[S]earch"
        -- }, {
        --     "<leader>n",
        --     group = "[N]eoTree"
        -- }, {
        --     "<leader>w",
        --     group = "[W]orkspace"
        -- }, {
        --     "<leader>t",
        --     group = "[T]oggle"
        -- }, {
        --     "<leader>h",
        --     group = "Git [H]unk",
        --     mode = {"n", "v"}
        -- }, {
        --     "K",
        --     desc = "LSP Hover",
        --     mode = {"n"}
        -- }, {
        --     "<leader><leader>",
        --     group = "EasyMotion",
        --     mode = {"n"},
        --     {
        --         "<leader><leader>f",
        --         desc = "EasyMotion [F]ind"
        --     },
        --     {
        --         "<leader><leader>w",
        --         desc = "EasyMotion [W]ord"
        --     },
        --     {
        --         "<leader><leader>l",
        --         desc = "EasyMotion [L]ine"
        --     },
        --     {
        --         "<leader><leader>j",
        --         desc = "EasyMotion [J]ump"
        --     },
        --     {
        --         "<leader><leader>s",
        --         desc = "EasyMotion [S]earch"
        --     }
        -- }}
    },
    -- Show the local buffer mappings
    keys = {{
        "<leader>?",
        function()
            require("which-key").show({
                global = true
            })
        end,
        desc = "Buffer Local Keymaps (which-key)"
    }}
}}
