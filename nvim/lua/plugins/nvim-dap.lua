return {
	'mfussenegger/nvim-dap',
	event = 'VeryLazy',
	dependencies = {
		'williamboman/mason.nvim',
		'jay-babu/mason-nvim-dap.nvim',
	},
	config = function()
		require('mason')
		require('mason-nvim-dap').setup({
			ensure_installed = {
				'codelldb',
			},
			handlers = {},
		})
	end,
}
