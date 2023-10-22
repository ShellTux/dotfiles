return {
	'jose-elias-alvarez/null-ls.nvim',
	enabled = false,
	event = 'VeryLazy',
	config = function()
		local augroup = vim.api.nvim_create_augroup('LspFormatting', {})
		local null_ls = require('null-ls')


		local completion  = null_ls.builtins.completion
		local diagnostics = null_ls.builtins.diagnostics
		local formatting  = null_ls.builtins.formatting

		null_ls.setup({
			sources = {
				completion.spell,
				diagnostics.eslint,
				formatting.eslint,
				formatting.stylua,
			},
		})
	end,
}
