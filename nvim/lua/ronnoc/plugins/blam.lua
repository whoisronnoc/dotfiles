return {
	'willothy/blam.nvim',
	build = 'make',
	opts = {
		-- options
	},
	config = true,
	init = function()
		vim.keymap.set('n', '<leader>b', require('blam').peek)
	end,
},