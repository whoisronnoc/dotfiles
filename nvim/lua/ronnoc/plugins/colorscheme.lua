return {
  "folke/tokyonight.nvim",
  priority = 1000,
  config = function()
    local transparent = false -- set to true if you would like to enable transparency

    local bg = "#011628"
    local bg_dark = "#011423"
    local bg_highlight = "#143652"
    local bg_search = "#0A64AC"
    local bg_visual = "#275378"
    local fg = "#CBE0F0"
    local fg_dark = "#B4D0E9"
    local fg_gutter = "#627E97"
    local border = "#547998"

    require("tokyonight").setup({
      style = "night",
      transparent = transparent,
      styles = {
        sidebars = transparent and "transparent" or "dark",
        floats = transparent and "transparent" or "dark",
      },
      on_colors = function(colors)
        colors.bg = bg
        colors.bg_dark = transparent and colors.none or bg_dark
        colors.bg_float = transparent and colors.none or bg_dark
        colors.bg_highlight = bg_highlight
        colors.bg_popup = bg_dark
        colors.bg_search = bg_search
        colors.bg_sidebar = transparent and colors.none or bg_dark
        colors.bg_statusline = transparent and colors.none or bg_dark
        colors.bg_visual = bg_visual
        colors.border = border
        colors.fg = fg
        colors.fg_dark = fg_dark
        colors.fg_float = fg
        colors.fg_gutter = fg_gutter
        colors.fg_sidebar = fg_dark
      end,
    })

    vim.cmd("colorscheme tokyonight")
  end,
}

-- { -- You can easily change to a different colorscheme.
-- -- Change the name of the colorscheme plugin below, and then
-- -- change the command in the config to whatever the name of that colorscheme is.
-- --
-- -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
-- 'folke/tokyonight.nvim',
-- priority = 1000, -- Make sure to load this before all the other start plugins.
-- init = function()
--   -- Load the colorscheme here.
--   -- Like many other themes, this one has different styles, and you could load
--   -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
--   vim.cmd.colorscheme 'tokyonight-night'

--   -- You can configure highlights by doing something like:
--   vim.cmd.hi 'Comment gui=none'
-- end,
-- },
