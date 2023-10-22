require('keybinds')
require('plugin-manager')
require('autocmds')
require('random-colorscheme')

------------
--- Settings
------------
require('config.options')
vim.cmd('autocmd BufRead,BufNewFile *.txt set filetype=plaintext')
vim.cmd('autocmd FileType plaintext setlocal spell spelllang=pt_PT')
vim.cmd('highlight ColorColumn ctermbg=0 guibg=red')
vim.cmd('command! Reload lua vim.cmd("source " .. vim.fn.stdpath("config") .. "/init.lua")')
vim.cmd('command! FilePath echo expand("%:p")')
