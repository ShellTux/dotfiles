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

			local telescope_present, telescope_builtin = pcall(require, 'telescope.builtin')

			local keybindings = {
				n = {
					['<S-k>'] = {
						command = vim.lsp.buf.signature_help,
						opts = {
							desc = 'Signature help',
						}
					},
					['g]'] = {
						command = vim.diagnostic.goto_next,
						opts = {
							desc = 'Goto next Diagnostic',
						}
					},
					['g['] = {
						command = vim.diagnostic.goto_prev,
						opts = {
							desc = 'Goto previous Diagnostic',
						}
					},
					['g}'] = {
						command = function()
							vim.diagnostic.goto_next({
								severity = vim.diagnostic.severity.ERROR,
							})
						end,
						opts = {
							desc = 'Goto next Error',
						}
					},
					['g{'] = {
						command = function()
							vim.diagnostic.goto_prev({
								severity = vim.diagnostic.severity.ERROR,
							})
						end,
						opts = {
							desc = 'Goto previous Error',
						}
					},
					['gD'] = {
						command = vim.lsp.buf.declaration,
						opts = { desc = 'Goto declaration' }
					},
					['K'] = {
						command = vim.lsp.buf.hover,
						opts = { desc = 'Hover' },
					},
					['<space>E'] = {
						command = vim.diagnostic.open_float,
						opts = { desc = 'Open diagnostic' },
					},
					['<space>f'] = {
						command = function()
							vim.lsp.buf.format({
								async = true,
								timeout_ms = 10000,
							})
						end,
						opts = { desc = 'Format' },
					},
					['<space>q'] = {
						command = vim.diagnostic.setloclist,
						opts = { desc = 'Location List' },
					},
					['<space>rn'] = {
						command = vim.lsp.buf.rename,
						opts = { desc = 'Rename Symbol' }
					},
					['<space>wa'] = {
						command = vim.lsp.buf.add_workspace_folder,
						opts = { desc = 'Add workspace folder' }
					},
					['<space>wl'] = {
						command = function()
							print(vim.inspect(vim.lsp.buf
								.list_workspace_folders()))
						end,
						opts = { desc = 'List workspace folders' }
					},
					['<space>wr'] = {
						command = vim.lsp.buf.remove_workspace_folder,
						opts = { desc = 'Remove workspace folder' }
					},
					['<space>ca'] = {
						command = vim.lsp.buf.code_action,
						opts = { desc = 'Code Action' },
					},
					['gd'] = {
						command = telescope_builtin.lsp_definitions or
						    vim.lsp.buf.definition,
						opts = { desc = 'Definitions', buffer = true },
					},
					['gi'] = {
						command = telescope_builtin.lsp_implementations or
						    vim.lsp.buf.implementation,
						opts = { desc = 'Implementations', buffer = true },
					},
					['gr'] = {
						command = telescope_builtin.lsp_references or
						    vim.lsp.buf.references,
						opts = { desc = 'References', buffer = true },
					},
					['<space>D'] = {
						command = telescope_builtin.lsp_type_definitions or
						    vim.lsp.buf.type_definition,
						opts = { desc = 'Type definitions', buffer = true },
					},
					['<leader>Lff'] = {
						command = '<cmd>LspZeroFormat<cr>',
						opts = { desc = 'Lsp Format' },
					},
					['<leader>Lft'] = {
						command = function()
							-- vim.b.lsp_zero_enable_autoformat = not vim.b
							--     .lsp_zero_enable_autoformat
						end,
						opts = { desc = 'Toggle Lsp Format' },
					},
					['<leader>Li'] = {
						command = '<cmd>LspInfo<cr>',
						opts = { desc = 'Lsp Info' },
					},
					['<leader>Lr'] = {
						command = '<cmd>LspRestart<cr>',
						opts = { desc = 'Lsp Restart' },
					},
					['<leader>Lsta'] = {
						command = '<cmd>LspStart<cr>',
						opts = { desc = 'Lsp Start' },
					},
					['<leader>Lsto'] = {
						command = '<cmd>LspStop<cr>',
						opts = { desc = 'Lsp Stop' },
					},
				},
				v = {
					['<space>ca'] = {
						command = vim.lsp.buf.code_action,
						opts = { desc = 'Code Action' },
					}
				}
			}

			local set_key = vim.keymap.set

			for mode, key_map in pairs(keybindings) do
				for key, config in pairs(key_map) do
					set_key(mode, key, config.command, config.opts)
				end
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
				'denols',
				'lua_ls',
				'pyright',
				'rust_analyzer',
				'tsserver',
			},
			handlers = {
				lsp_zero.default_setup,
				asm_lsp = function()
					lspconfig.asm_lsp.setup({
						root_dir = lspconfig.util.root_pattern('*.asm')
					})
				end,
				clangd = function()
					lspconfig.clangd.setup({ capabilities = capabilities })
				end,
				denols = function()
					lspconfig.denols.setup({
						root_dir = lspconfig.util.root_pattern(
							'deno.json',
							'deno.jsonc'
						),
					})
				end,
				lua_ls = function()
					lspconfig.lua_ls.setup(lsp_zero.nvim_lua_ls())
				end,
				tsserver = function()
					lspconfig.tsserver.setup {
						root_dir = lspconfig.util.root_pattern('package.json'),
						single_file_support = false,
					}
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
