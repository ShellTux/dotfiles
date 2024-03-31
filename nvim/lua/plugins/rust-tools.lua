return {
	'simrat39/rust-tools.nvim',
	enabled = false,
	ft = 'rust',
	dependencies = {
		'neovim/nvim-lspconfig',
		'simrat39/rust-tools.nvim',
		'nvim-lua/plenary.nvim',
		'mfussenegger/nvim-dap',
		'VonHeikemen/lsp-zero.nvim',
	},
	config = function(_, opts)
		local lsp_zero = require('lsp-zero')

		lsp_zero.on_attach(function(client, bufnr)
			lsp_zero.default_keymaps({ buffer = bufnr })
		end)

		local rust_tools = require('rust-tools')

		rust_tools.setup({
			server = {
				on_attach = function(client, bufnr)
					vim.keymap.set(
						'n',
						'<leader>ca',
						rust_tools.hover_actions.hover_actions,
						{ buffer = bufnr }
					)
				end
			}
		})
	end,
}
