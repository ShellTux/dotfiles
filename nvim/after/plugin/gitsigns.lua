require('gitsigns').setup({
	signcolumn = true,
	numhl      = true,
	linehl     = false,
	word_diff  = false,
	current_line_blame = false,
	current_line_blame_opts = {
		delay = 1000,
	},
})
