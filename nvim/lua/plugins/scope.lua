return {
	'tiagovla/scope.nvim',
	enabled = true,
	lazy = false,
	config = function()
		require('scope').setup()
		pcall(require 'telescope'.load_extension, 'scope')
	end,
	keys = {
		{ '<leader>pb', '<cmd>Telescope scope buffers<cr>', desc = 'Buffers' },
	},
}
