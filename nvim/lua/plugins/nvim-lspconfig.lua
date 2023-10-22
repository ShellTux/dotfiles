return {
	'neovim/nvim-lspconfig',
	lazy = false,
}
-- local lsp = require('lsp-zero').preset({})

-- local telescope_present, _ = pcall(require, 'telescope')

-- lsp.on_attach(function(client, bufnr)
-- 	lsp.default_keymaps({ buffer = bufnr })

-- 	-- vim.keymap.set('n', '<S-k>', vim.lsp.buf.signature_help, opts)
-- 	vim.keymap.set('n', 'g]', vim.diagnostic.goto_next)
-- 	vim.keymap.set('n', 'g[', vim.diagnostic.goto_prev)
-- 	vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
-- 	vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
-- 	vim.keymap.set('n', '<space>E', vim.diagnostic.open_float)
-- 	vim.keymap.set('n', '<space>f', function()
-- 		vim.lsp.buf.format({ async = true, timeout_ms = 10000 })
-- 	end, opts)
-- 	vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)
-- 	vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
-- 	vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
-- 	vim.keymap.set('n', '<space>wl', function()
-- 		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
-- 	end, opts)
-- 	vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
-- 	vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)

-- 	if telescope_present then
-- 		local options = { buffer = true }
-- 		vim.keymap.set('n', 'gd', '<cmd>Telescope lsp_definitions<cr>', options)
-- 		vim.keymap.set('n', 'gi', '<cmd>Telescope lsp_implementations<cr>', options)
-- 		vim.keymap.set('n', 'gr', '<cmd>Telescope lsp_references<cr>', options)
-- 		vim.keymap.set('n', '<space>D', '<cmd>Telescope lsp_type_definitions', options)
-- 	else
-- 		vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
-- 		vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
-- 		vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
-- 		vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
-- 	end
-- end)

-- lsp.format_on_save({
-- 	format_opts = {
-- 		async = false,
-- 		timeout_ms = 10000,
-- 	},
-- 	servers = {
-- 		['clangd'] = { 'c', 'cpp' },
-- 		['lua_ls'] = { 'lua' },
-- 		['null-ls'] = { 'typescript', 'javascript' },
-- 		['rust_analyzer'] = { 'rust' },
-- 	}
-- })

-- local mason = require('mason')

-- local options = {
-- 	-- not an option from mason.nvim
-- 	ensure_installed = {
-- 		'bash-language-server',
-- 		'clangd',
-- 		'clang-format',
-- 		'codelldb',
-- 		'lua-language-server',
-- 		'pyright',
-- 		'rust-analyzer',
-- 		'typescript-language-server',
-- 	},
-- 	max_concurrent_installers = 10,
-- }

-- mason.setup(options)

-- local function MasonInstallAll()
-- 	vim.cmd('MasonInstall ' .. table.concat(options.ensure_installed, ' '))
-- end

-- vim.api.nvim_create_user_command('MasonInstallAll', MasonInstallAll, {})

-- require('mason-lspconfig').setup({
-- 	'bashls',
-- 	'clangd',
-- 	'lua_ls',
-- 	'pyright',
-- 	'rust_analyzer',
-- 	'tsserver',
-- })

-- -- Nerd Font v3.x.x
-- lsp.set_sign_icons({
-- 	error = ' ',
-- 	warn  = ' ',
-- 	hint  = '󰌵 ',
-- 	info  = '󰋼 '
-- })

-- -- (Optional) Configure lua language server for neovim
-- local lspconfig = require('lspconfig')
-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- -- BUG: https://github.com/neovim/neovim/pull/16694
-- capabilities.offsetEncoding = { 'utf-16' }

-- lspconfig.lua_ls.setup(lsp.nvim_lua_ls())
-- lspconfig.clangd.setup({ capabilities = capabilities })
-- lspconfig.tsserver.setup({})
-- lspconfig.asm_lsp.setup({
-- 	root_dir = lspconfig.util.root_pattern('*.asm')
-- })
-- lsp.setup()

-- local cmp = require('cmp')
-- local cmp_action = require('lsp-zero').cmp_action()
-- require('luasnip.loaders.from_vscode').lazy_load()
-- require('luasnip.loaders.from_snipmate').lazy_load()

-- cmp.setup({
-- 	snippet = {
-- 		expand = function(args)
-- 			require('luasnip').lsp_expand(args.body)
-- 		end,
-- 	},
-- 	window = {
-- 		completion = cmp.config.window.bordered(),
-- 		documentation = cmp.config.window.bordered(),
-- 	},
-- 	sources = {
-- 		{ name = 'path' },
-- 		{ name = 'nvim_lsp' },
-- 		{ name = 'buffer',  keyword_length = 3 },
-- 		{ name = 'luasnip', keyword_length = 2 },
-- 	},
-- 	mapping = {
-- 		['<C-b>'] = cmp.mapping.scroll_docs(-4),
-- 		['<C-f>'] = cmp.mapping.scroll_docs(4),
-- 		['<C-e>'] = cmp.mapping.abort(),
-- 		['<CR>'] = cmp.mapping.confirm({ select = true }),
-- 		['<C-Space>'] = cmp.mapping.complete(),
-- 		['<Tab>'] = cmp_action.luasnip_jump_forward(),
-- 		['<S-Tab>'] = cmp_action.luasnip_jump_backward(),
-- 	}
-- })

-- cmp.setup.filetype('gitcommit', {
-- 	sources = cmp.config.sources({
-- 		{ name = 'git' },
-- 	}, {
-- 		{ name = 'buffer' },
-- 	})
-- })

-- cmp.setup.cmdline({ '/', '?' }, {
-- 	mapping = cmp.mapping.preset.cmdline(),
-- 	sources = {
-- 		{ name = 'buffer' }
-- 	}
-- })

-- cmp.setup.cmdline(':', {
-- 	mapping = cmp.mapping.preset.cmdline(),
-- 	sources = cmp.config.sources({
-- 		{ name = 'path' }
-- 	}, {
-- 		{ name = 'cmdline' }
-- 	})
-- })
