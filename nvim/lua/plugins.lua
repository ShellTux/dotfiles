return {
	'edeneast/nightfox.nvim',
	'ellisonleao/gruvbox.nvim',
	'equalsraf/neovim-gui-shim',
	'farmergreg/vim-lastplace',
	'folke/tokyonight.nvim',
	'folke/which-key.nvim',
	'honza/vim-snippets',
	'junegunn/vim-easy-align',
	'lewis6991/gitsigns.nvim',
	'loctvl842/monokai-pro.nvim',
	'lunarvim/darkplus.nvim',
	'm4xshen/smartcolumn.nvim',
	'mbbill/undotree',
	'mg979/vim-visual-multi',
	'mofiqul/adwaita.nvim',
	'mofiqul/vscode.nvim',
	'navarasu/onedark.nvim',
	'neoclide/coc.nvim',
	'norcalli/nvim-colorizer.lua',
	'nvim-tree/nvim-tree.lua',
	'nvim-tree/nvim-web-devicons',
	'nvim-treesitter/nvim-treesitter',
	'projekt0n/github-nvim-theme',
	'rebelot/kanagawa.nvim',
	'tpope/vim-commentary',
	'tpope/vim-fugitive',
	'tpope/vim-repeat',
	'tpope/vim-surround',
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
		build = function () vim.fn["mkdp#util#install"]() end,
		ft = 'markdown',
	},
	{
		'phaazon/hop.nvim',
		branch = 'v2', -- optional but strongly recommended
	},
}
