return {
	'edeneast/nightfox.nvim',
	'ellisonleao/gruvbox.nvim',
	'equalsraf/neovim-gui-shim',
	'farmergreg/vim-lastplace',
	'folke/tokyonight.nvim',
	'folke/which-key.nvim',
	'honza/vim-snippets',
	'junegunn/vim-easy-align',
	'kovetskiy/sxhkd-vim',
	'L3MON4D3/LuaSnip',
	'lewis6991/gitsigns.nvim',
	'loctvl842/monokai-pro.nvim',
	'lunarvim/darkplus.nvim',
	'm4xshen/smartcolumn.nvim',
	'mbbill/undotree',
	'mg979/vim-visual-multi',
	'mofiqul/adwaita.nvim',
	'mofiqul/vscode.nvim',
	'navarasu/onedark.nvim',
	'neovim/nvim-lspconfig',
	'norcalli/nvim-colorizer.lua',
	'nvim-tree/nvim-tree.lua',
	'nvim-tree/nvim-web-devicons',
	'nvim-treesitter/nvim-treesitter',
	'projekt0n/github-nvim-theme',
	'rafamadriz/friendly-snippets',
	'rebelot/kanagawa.nvim',
	'tpope/vim-commentary',
	'tpope/vim-fugitive',
	'tpope/vim-repeat',
	'tpope/vim-surround',
	'waycrate/swhkd-vim',
	'xiyaowong/transparent.nvim',
	{
		'nvim-telescope/telescope.nvim',
		tag = '0.1.1',
		dependencies = 'nvim-lua/plenary.nvim',
	},
	{
		'akinsho/bufferline.nvim',
		version = 'v3.*',
		dependencies = 'nvim-tree/nvim-web-devicons',
	},
	{
		'lukas-reineke/indent-blankline.nvim',
		dependencies = 'nvim-treesitter/nvim-treesitter',
	},
	{
		'akinsho/toggleterm.nvim',
		version = '*',
		config = true
	},
	{
		'nvim-lualine/lualine.nvim',
		dependencies = 'nvim-tree/nvim-web-devicons',
	},
	{
		'catppuccin/nvim',
		name = 'catppuccin'
	},
	{
		'rose-pine/neovim',
		name = 'rose-pine'
	},
	{
		'nordtheme/vim',
		name = 'nordtheme',
	},
	{
		'folke/todo-comments.nvim',
		dependencies = 'nvim-lua/plenary.nvim',
	},
	{
		'iamcco/markdown-preview.nvim',
		build = function() vim.fn["mkdp#util#install"]() end,
		ft = 'markdown',
	},
	{
		'phaazon/hop.nvim',
		branch = 'v2', -- optional but strongly recommended
	},
	{
		'windwp/nvim-autopairs',
		event = 'InsertEnter',
	},
	{
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v2.x',
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
		}
	},
	{
		'jose-elias-alvarez/null-ls.nvim',
		event = 'VeryLazy',
	},
	-- Debugger
	{
		'mfussenegger/nvim-dap',
		event = 'VeryLazy',
		dependencies = {
			'williamboman/mason.nvim',
			'jay-babu/mason-nvim-dap.nvim',
		}
	},
	{
		'rcarriga/nvim-dap-ui',
		event = 'VeryLazy',
		dependencies = 'mfussenegger/nvim-dap',
	}
}
