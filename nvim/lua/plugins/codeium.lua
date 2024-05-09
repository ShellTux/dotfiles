local keyOptions = { expr = true, silent = true }
vim.g.codeium_enabled = false
vim.g.codeium_vim = true
vim.g.codeium_disable_bindings = 0

if vim.g.codeium_vim then
	return {
		'Exafunction/codeium.vim',
		enabled = false,
		event = 'BufEnter',
		config = function()
			-- Change '<C-g>' here to any keycode you like.
			vim.keymap.set('i', '<C-g>', function() return vim.fn['codeium#Accept']() end,
				keyOptions)
			vim.keymap.set('i', '<c-;>', function() return vim.fn['codeium#CycleCompletions'](1) end,
				keyOptions)
			vim.keymap.set('i', '<c-,>', function() return vim.fn['codeium#CycleCompletions'](-1) end,
				keyOptions)
			vim.keymap.set('i', '<c-x>', function() return vim.fn['codeium#Clear']() end,
				keyOptions)
		end
	}
else
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
			vim.keymap.set('i', '<c-;>', function() return vim.fn['codeium#CycleCompletions'](1) end,
				keyOptions),
			vim.keymap.set('i', '<c-,>', function() return vim.fn['codeium#CycleCompletions'](-1) end,
				keyOptions),
			vim.keymap.set('i', '<c-x>', vim.fn['codeium#Clear'], keyOptions),
		},
		config = function()
			require('codeium').setup({
			})
		end
	}
end
