return {
	'VonHeikemen/lsp-zero.nvim',
	branch = 'v3.x',
	event = { 'BufReadPre', 'BufNewFile' },
	dependencies = {
		-- LSP Support
		'neovim/nvim-lspconfig',
		{
			'williamboman/mason.nvim',
			build = function() pcall(vim.cmd, 'MasonUpdate') end,
		},
		'williamboman/mason-lspconfig.nvim',

		-- Autocompletion
		'hrsh7th/cmp-buffer',
		'hrsh7th/cmp-cmdline',
		'hrsh7th/cmp-nvim-lsp',
		'hrsh7th/cmp-path',
		'hrsh7th/nvim-cmp',
		'L3MON4D3/LuaSnip',
		'rafamadriz/friendly-snippets',
		'saadparwaiz1/cmp_luasnip',
	},
	config = function()
		local lsp_zero = require('lsp-zero')
		local lspconfig = require('lspconfig')
		local mason = require('mason')
		local cmp = require('cmp')

		lsp_zero.on_attach(function(client, bufnr)
			lsp_zero.default_keymaps({ buffer = bufnr })
			pcall(require 'lsp_signature'.on_attach, client, bufnr)

			local set_key = vim.keymap.set

			vim.keymap.set('n', '<S-k>', vim.lsp.buf.signature_help, opts)
			set_key('n', 'g]', vim.diagnostic.goto_next)
			set_key('n', 'g[', vim.diagnostic.goto_prev)
			set_key('n', 'gD', vim.lsp.buf.declaration, opts)
			set_key('n', 'K', vim.lsp.buf.hover, opts)
			set_key('n', '<space>E', vim.diagnostic.open_float)
			set_key('n', '<space>f', function()
				vim.lsp.buf.format({ async = true, timeout_ms = 10000 })
			end, opts)
			set_key('n', '<space>q', vim.diagnostic.setloclist)
			set_key('n', '<space>rn', vim.lsp.buf.rename, opts)
			set_key('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
			set_key('n', '<space>wl', function()
				print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
			end, opts)
			set_key('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
			set_key({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)

			local telescope_present, _ = pcall(require, 'telescope')

			if telescope_present then
				local options = { buffer = true }
				set_key('n', 'gd', '<cmd>Telescope lsp_definitions<cr>', options)
				set_key('n', 'gi', '<cmd>Telescope lsp_implementations<cr>', options)
				set_key('n', 'gr', '<cmd>Telescope lsp_references<cr>', options)
				set_key('n', '<space>D', '<cmd>Telescope lsp_type_definitions', options)
			else
				set_key('n', 'gd', vim.lsp.buf.definition, opts)
				set_key('n', 'gi', vim.lsp.buf.implementation, opts)
				set_key('n', 'gr', vim.lsp.buf.references, opts)
				set_key('n', '<space>D', vim.lsp.buf.type_definition, opts)
			end
		end)

		lsp_zero.format_on_save({
			format_opts = {
				async = false,
				timeout_ms = 7000,
			},
			servers = {
				['lua_ls'] = { 'lua' },
				['null-ls'] = { 'typescript', 'javascript' },
				['rust_analyzer'] = { 'rust' },
			}
		})

		-- Nerd Font v3.x.x
		lsp_zero.set_sign_icons({
			error = ' ',
			warn  = ' ',
			hint  = '󰌵 ',
			info  = '󰋼 '
		})


		local mason_options = {
			-- not an option from mason.nvim
			ensure_installed = {
				'bash-language-server',
				'clangd',
				'clang-format',
				'codelldb',
				'lua-language-server',
				'pyright',
				'rust-analyzer',
				'typescript-language-server',
			},
			max_concurrent_installers = 10,
		}

		mason.setup(mason_options)

		local function MasonInstallAll()
			vim.cmd('MasonInstall ' .. table.concat(mason_options.ensure_installed, ' '))
		end

		vim.api.nvim_create_user_command('MasonInstallAll', MasonInstallAll, {})

		-- (Optional) Configure lua language server for neovim
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		-- BUG: https://github.com/neovim/neovim/pull/16694
		capabilities.offsetEncoding = { 'utf-16' }

		require('mason-lspconfig').setup({
			ensure_installed = {
				'bashls',
				'clangd',
				'lua_ls',
				'pyright',
				'rust_analyzer',
				'tsserver',
			},
			handlers = {
				lsp_zero.default_setup,
				clangd = function()
					lspconfig.clangd.setup({ capabilities = capabilities })
				end,
				lua_ls = function()
					lspconfig.lua_ls.setup(lsp_zero.nvim_lua_ls())
				end,
			},
		})

		lsp_zero.setup()

		local cmp_action = require('lsp-zero').cmp_action()
		require('luasnip.loaders.from_vscode').lazy_load()
		require('luasnip.loaders.from_snipmate').lazy_load()

		cmp.setup({
			snippet = {
				expand = function(args)
					require('luasnip').lsp_expand(args.body)
				end,
			},
			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			},
			sources = {
				{ name = 'path' },
				{ name = 'nvim_lsp' },
				{ name = 'buffer',  keyword_length = 3 },
				{ name = 'luasnip', keyword_length = 2 },
			},
			mapping = {
				['<C-b>'] = cmp.mapping.scroll_docs(-4),
				['<C-f>'] = cmp.mapping.scroll_docs(4),
				['<C-e>'] = cmp.mapping.abort(),
				['<CR>'] = cmp.mapping.confirm({ select = true }),
				['<C-Space>'] = cmp.mapping.complete(),
				['<Tab>'] = cmp_action.luasnip_jump_forward(),
				['<S-Tab>'] = cmp_action.luasnip_jump_backward(),
			}
		})

		cmp.setup.filetype('gitcommit', {
			sources = cmp.config.sources({
				{ name = 'git' },
			}, {
				{ name = 'buffer' },
			})
		})

		cmp.setup.cmdline({ '/', '?' }, {
			mapping = cmp.mapping.preset.cmdline(),
			sources = {
				{ name = 'buffer' }
			}
		})

		cmp.setup.cmdline(':', {
			mapping = cmp.mapping.preset.cmdline(),
			sources = cmp.config.sources({
				{ name = 'path' }
			}, {
				{ name = 'cmdline' }
			})
		})
	end,
}
