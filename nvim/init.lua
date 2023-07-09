require('keybinds')
require('plugin-manager')
require('autocmds')
require('random-colorscheme')

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

vim.cmd('command! Reload lua vim.cmd("source " .. vim.fn.stdpath("config") .. "/init.lua")')
