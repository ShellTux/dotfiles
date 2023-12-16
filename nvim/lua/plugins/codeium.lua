local keyOptions = { expr = true }
vim.g.codeium_enabled = false

return {
	'Exafunction/codeium.nvim',
	dependencies = {
		'nvim-lua/plenary.nvim',
		'hrsh7th/nvim-cmp',
	},
	enabled = false,
	event = 'BufEnter',
	keys = {
		vim.keymap.set('i', '<C-g>', vim.fn['codeium#Accept'], keyOptions),
		vim.keymap.set('i', '<c-;>', function() return vim.fn['codeium#CycleCompletions'](1) end, keyOptions),
		vim.keymap.set('i', '<c-,>', function() return vim.fn['codeium#CycleCompletions'](-1) end, keyOptions),
		vim.keymap.set('i', '<c-x>', vim.fn['codeium#Clear'], keyOptions),
	},
	config = function()
		require('codeium').setup({
		})
	end
}
