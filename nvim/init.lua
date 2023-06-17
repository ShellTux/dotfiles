require('keybinds')
require('plugin-manager')
require('autocmds')

------------
--- Settings
------------
vim.cmd('colorscheme onedark')
vim.cmd('syntax enable') -- Syntax highlighting
vim.cmd('set wildmenu') -- Command-line completion (Tab to invoke completion) and a menu pops up
vim.cmd('set ignorecase smartcase ') -- Ignores case when the pattern contains lowercase only, otherwise will try to exact match
vim.cmd('set incsearch') -- While typing a search command, show where the pattern, as it was typed	so far, matches. The matched string is highlighted. If the pattern is invalid or not found, nothing is shown.
vim.cmd('set hlsearch') -- When there is a previous search pattern, highlight all its matches.
vim.cmd('set number') -- precede each line with its line number.
vim.cmd('set encoding=UTF-8') -- Sets the character encoding used inside Vim.
vim.cmd('set scrolloff=999') -- Minimal number of screen lines to keep above and below the cursor.
vim.cmd('set termguicolors')
vim.cmd('highlight ColorColumn ctermbg=0 guibg=red')
