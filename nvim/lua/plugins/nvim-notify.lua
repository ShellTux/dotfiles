return {
	'rcarriga/nvim-notify',
	lazy = false,
	config = function(_, opts)
		vim.opt.termguicolors = true
		vim.notify = require('notify')
		require('notify').setup({
			background_colour = '#000000',
		})
	end,
}
