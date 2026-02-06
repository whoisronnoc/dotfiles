---@module "lazy"
---@return LazyPluginSpec
return {
	"sainnhe/sonokai",
	config = function()
		vim.api.nvim_create_autocmd("ColorScheme", {
			group = vim.api.nvim_create_augroup("custom_highlights_sonokai", {}),
			pattern = "sonokai",
			callback = function()
				local config = vim.fn["sonokai#get_configuration"]()
				local palette = vim.fn["sonokai#get_palette"](config.style, config.colors_override)
				local set_hl = vim.fn["sonokai#highlight"]
				-- let palette = {
				-- \ 'black':      ['#181a1c',   '232'],
				-- \ 'bg_dim':     ['#24272e',   '232'],
				-- \ 'bg0':        ['#2a2f38',   '235'],
				-- \ 'bg1':        ['#333846',   '236'],
				-- \ 'bg2':        ['#373c4b',   '236'],
				-- \ 'bg3':        ['#3d4455',   '237'],
				-- \ 'bg4':        ['#424b5b',   '237'],
				-- \ 'bg_red':     ['#ff6d7e',   '203'],
				-- \ 'diff_red':   ['#55393d',   '52'],
				-- \ 'bg_green':   ['#a5e179',   '107'],
				-- \ 'diff_green': ['#394634',   '22'],
				-- \ 'bg_blue':    ['#7ad5f1',   '110'],
				-- \ 'diff_blue':  ['#354157',   '17'],
				-- \ 'diff_yellow':['#4e432f',   '54'],
				-- \ 'fg':         ['#e1e3e4',   '250'],
				-- \ 'red':        ['#ff6578',   '203'],
				-- \ 'orange':     ['#f69c5e',   '215'],
				-- \ 'yellow':     ['#eacb64',   '179'],
				-- \ 'green':      ['#9dd274',   '107'],
				-- \ 'blue':       ['#72cce8',   '110'],
				-- \ 'purple':     ['#ba9cf3',   '176'],
				-- \ 'grey':       ['#828a9a',   '246'],
				-- \ 'grey_dim':   ['#5a6477',   '240'],
				-- \ 'none':       ['NONE',      'NONE']
				-- \ }

				set_hl("Directory", palette.none, palette.none)
				set_hl("Title", palette.none, palette.none)
				set_hl("SnacksPickerDirectory", palette.none, palette.none)
				set_hl("SnacksPickerGitStatusUntracked", palette.green, palette.none)
				set_hl("SnacksPickerPathIgnored", palette.grey, palette.none)
				set_hl("SnacksPickerPathHidden", palette.fg, palette.none)
			end,
		})

		vim.g.sonokai_style = "atlantis"
	end,
}
