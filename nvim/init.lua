require('keybinds')
require('plugin-manager')
require('autocmds')

------------
--- Settings
------------
vim.cmd('syntax enable')
vim.cmd('set wildmenu')
vim.cmd('set ignorecase smartcase ')
vim.cmd('set incsearch')
vim.cmd('set hlsearch')
vim.cmd('set number')
vim.cmd('set encoding=UTF-8')
vim.cmd('set scrolloff=999')
vim.cmd('set termguicolors')
vim.cmd('set wrap')
vim.cmd('set linebreak')
vim.cmd('set background=dark')
vim.cmd('highlight ColorColumn ctermbg=0 guibg=red')

math.randomseed(os.time())
function ApplyRandomColorscheme(colorschemes)
	local length = #colorschemes
	local random_index = math.random(length)
	local random_colorscheme = colorschemes[random_index]

	vim.cmd('colorscheme ' .. random_colorscheme)
end

local favorite_colorschemes = {
	'adwaita',
	'carbonfox',
	'catppuccin',
	'duskfox',
	'github_dark',
	'gruvbox',
	'kanagawa',
	'kanagawa-dragon',
	'monokai-pro',
	'monokai-pro-ristretto',
	'nightfox',
	'nordfox',
	'onedark',
	'terafox',
	'tokyonight',
	'vscode',
}

ApplyRandomColorscheme(favorite_colorschemes)
