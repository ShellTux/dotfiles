return {
	'nvim-tree/nvim-tree.lua',
	lazy = false,
	init = function()
		vim.opt.termguicolors = true
	end,
	opts = {
		sort_by = "case_sensitive",
		renderer = {
			group_empty = true,
		},
		filters = {
			dotfiles = true,
		},
		actions = {
			open_file = {
				quit_on_open = true,
			},
		},
	},
	keys = {
		vim.keymap.set('n', '<leader>e', '<cmd>NvimTreeToggle<cr>')
	},
}
