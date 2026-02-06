vim.api.nvim_create_autocmd("ColorScheme", {
	callback = function(args)
		vim.opt.guicursor =
			"n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175"
		vim.cmd("hi! Cursor guifg=#000000 guibg=#51A2FF")
		-- vim.cmd.hi("Cursor guifg=black guibg=white")
		-- vim.cmd.hi("lCursor guifg=black guibg=white")

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

		-- vim.cmd.hi("GitConflictCurrentLabel guibg=#9FC9FF")
		-- vim.cmd.hi("GitConflictCurrent guibg=#989EFE")

		-- vim.cmd("hi! link RenderMarkdownH1Bg @markup.heading.1.markdown")
		-- vim.cmd("hi! link RenderMarkdownH2Bg @markup.heading.2.markdown")
		-- vim.cmd("hi! link RenderMarkdownH3Bg @markup.heading.3.markdown")
		-- vim.cmd("hi! link RenderMarkdownH4Bg @markup.heading.4.markdown")
		-- vim.cmd("hi! link RenderMarkdownH5Bg @markup.heading.5.markdown")
		-- vim.cmd("hi! link RenderMarkdownH6Bg @markup.heading.6.markdown")
	end,
})
