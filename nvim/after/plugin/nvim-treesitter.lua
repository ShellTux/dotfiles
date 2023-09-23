require('nvim-treesitter.configs').setup({
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
})
