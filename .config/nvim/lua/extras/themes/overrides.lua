vim.api.nvim_create_autocmd("ColorScheme", {
	callback = function(args)
		vim.cmd("hi! link NeoTreeTab BufferLineTab")
		vim.cmd("hi! link NeoTreeTabInactive BufferLineTab")
		vim.cmd("hi! link NeoTreeTabSeparator BufferLineTabSeparator")
		vim.cmd("hi! link NeoTreeTabSeparatorActive BufferLineTabSeparator")
		vim.cmd("hi! link NeoTreeTabSeparatorInactive BufferLineTabSeparator")

		vim.cmd("hi! link LspInlayHint @comment.documentation")
		vim.cmd("hi! link SpellBad LspDiagnosticHint")

		vim.cmd("hi! link AvanteSidebarWinSeparator WinSeparator")
		vim.cmd("hi! link AvanteSidebarWinHorizontalSeparator WinSeparator")
		-- vim.cmd.hi("SpellBad gui=undercurl guisp=blue")

		vim.cmd("hi! Cursor guifg=#000000 guibg=#51A2FF")
		vim.opt.guicursor =
			"n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175"
	end,
})
