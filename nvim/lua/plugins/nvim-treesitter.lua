local nvim_treesitter_options = {
	ensure_installed = {
		'c',
		'cpp',
		'lua',
		'python',
		'query',
		'rust',
		'vim',
		'vimdoc',
	},
	ignore_install = { 'javascript' },
	sync_install = false,
	auto_install = true,
	highlight = {
		enable = true,
		disable = {},
	},
	additional_vim_regex_highlighting = false,
}

return {
	'nvim-treesitter/nvim-treesitter',
	lazy = false,
	config = function()
		require('nvim-treesitter.configs').setup(nvim_treesitter_options)
	end,
}
