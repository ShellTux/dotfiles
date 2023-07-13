local augroup = vim.api.nvim_create_augroup('LspFormatting', {})
local null_ls = require('null-ls')

null_ls.setup({
	sources = {
		null_ls.builtins.completion.spell,
		null_ls.builtins.diagnostics.eslint,
		-- null_ls.builtins.formatting.clang_format,
		null_ls.builtins.formatting.stylua,
	},
})
