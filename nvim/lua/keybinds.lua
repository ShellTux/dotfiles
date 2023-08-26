---------------
--- Keybindings
--------------
vim.g.mapleader = ' '
vim.keymap.set('n', '<C-h>', vim.cmd.nohlsearch)               -- Turn off highlighting
vim.keymap.set('n', '<C-j>', vim.cmd.tabprevious)              -- Previous tab
vim.keymap.set('n', '<C-k>', vim.cmd.tabnext)                  -- Next tab
vim.keymap.set('n', '<C-S-j>', '<cmd>tabmove -1<cr>')          -- Previous tab
vim.keymap.set('n', '<C-S-k>', '<cmd>tabmove +1<cr>')          -- Next tab
vim.keymap.set('n', '<C-Left>', vim.cmd.tabprevious)           -- Previous tab
vim.keymap.set('n', '<C-Right>', vim.cmd.tabnext)              -- Next tab
vim.keymap.set('n', '<leader>pv', vim.cmd.Explore)
vim.keymap.set('n', '<leader>tc', vim.cmd.tabclose)            -- Close tab
vim.keymap.set('n', '<Left>', '<cmd>vertical resize -2<cr>')   -- Vertical split resize
vim.keymap.set('n', '<Right>', '<cmd>vertical resize +2<cr>')  -- Vertical split resize
vim.keymap.set('n', '<up>', '<cmd>resize -2<cr>')              -- split resize
vim.keymap.set('n', '<down>', '<cmd>resize +2<cr>')            -- split resize
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { silent = true }) -- Escape Terminal
-- vim.keymap.set('v', 'J', vim.cmd("mark '>+1<CR>gv=gv")) -- Move visual block one line above
-- vim.keymap.set('v', 'K', vim.cmd("mark '<-2<CR>gv=gv")) -- Move visual block one line below
-- vim.keymap.set('n', 'Y', vim.cmd('yg$')) -- Yank to then end of the line without moving cursor
-- vim.keymap.set('n', 'J', vim.cmd('mzJ`z')) -- Merge current line with line below without moving cursor
-- vim.keymap.set('n', '<leader>s', vim.cmd.[[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]]) -- Replace
-- nnoremap <leader>x <cmd>!chmod u+x %<CR>	" Make this file executable
