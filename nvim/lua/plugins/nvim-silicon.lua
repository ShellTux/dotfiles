return {
	'michaelrommel/nvim-silicon',
	lazy = true,
	cmd = 'Silicon',
	config = function()
		require('silicon').setup({
			background = '#94e2d5',
			theme = 'OneHalfDark',
			font = 'FiraCode Nerd Font',
			window_title = function()
				return vim.fn.fnamemodify(
					vim.api.nvim_buf_get_name(
						vim.api.nvim_get_current_buf()
					),
					':t'
				)
			end,
		})
	end
}
