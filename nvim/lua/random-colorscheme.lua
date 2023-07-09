math.randomseed(os.time())
local function ApplyRandomColorscheme(colorschemes)
	local random_colorscheme = colorschemes[math.random(#colorschemes)]

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

function RandomColorscheme()
	ApplyRandomColorscheme(favorite_colorschemes)
end

vim.cmd('command! RandomColorscheme lua RandomColorscheme()')
