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
		java = { '180', '200' },
		ruby = '120',
		rust = { '90', '100' },
		sh = '90',
	},
	scope = 'file',
}

require('smartcolumn').setup(config)