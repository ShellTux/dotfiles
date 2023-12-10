return {
	'lervag/vimtex',
	config = function()
		vim.cmd('call vimtex#init()')
		vim.cmd('filetype plugin indent on')

		vim.cmd('syntax enable')

		vim.g.vimtex_view_method = 'zathura'

		vim.api.nvim_set_var('maplocalleader', ',')
	end,
	ft = 'tex',
}
