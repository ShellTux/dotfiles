return {
	'nvim-telescope/telescope.nvim',
	tag = '0.1.4',
	dependencies = {
		'nvim-lua/plenary.nvim'
	},
	keys = {
		vim.keymap.set('n', '<leader>pb', ':Telescope buffers<CR>'),
		vim.keymap.set('n', '<leader>pc', ':Telescope colorscheme enable_preview=true<CR>'),
		vim.keymap.set('n', '<leader>pC', ':Telescope git_branches<CR>'),
		vim.keymap.set('n', '<leader>pf', ':Telescope find_files<CR>'),
		vim.keymap.set('n', '<leader>pg', ':Telescope git_files<CR>'),
		vim.keymap.set('n', '<leader>pG', ':Telescope live_grep<CR>'),
		vim.keymap.set('n', '<leader>ph', ':Telescope help_tags<CR>'),
		vim.keymap.set('n', '<leader>ps', ':Telescope git_status<CR>'),
		vim.keymap.set('n', '<leader>M', ':Telescope man_pages sections=0p,1,2,3,3p,3type,7<CR>'),
	},
	config = function()
		pcall(require 'telescope'.load_extension, 'luasnip')
	end,
}
