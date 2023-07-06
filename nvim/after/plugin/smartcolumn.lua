local config = {
	colorcolumn = '80',
	disabled_filetypes = {
		'help',
		'lazy',
		'markdown',
		'mason',
		'NvimTree',
		'text',
	},
	custom_colorcolumn = {
		bash = '90',
		java = { '180', '200' },
		lua = '100',
		ruby = '120',
		rust = { '90', '100' },
		sh = '90',
		typescript = { '90', '100' },
		zsh = '90',
	},
	scope = 'file',
}

require('smartcolumn').setup(config)
