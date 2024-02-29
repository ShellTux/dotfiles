return {
	'michaelrommel/nvim-silicon',
	lazy = true,
	cmd = 'Silicon',
	init = function()
		local wk = require('which-key')
		wk.register({
			['<leader>sc'] = { ':Silicon<CR>', 'Snapshot Code' },
		}, { mode = 'v' })
	end,
	config = function()
		require('silicon').setup({
			background = '#94e2d5',
			theme = 'OneHalfDark',
			font = 'FiraCode Nerd Font',
			pad_horiz = 40,
			pad_vert = 50,
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
