-- vim.opt.tabstop = 2
vim.opt.wildignore = { '*.o', '*.a', '__pycache__' }
vim.opt.listchars = { tab = '> ', trail = '•', nbsp = '~' }
vim.opt.wildmenu = true
vim.opt.syntax = 'enabled'
vim.opt.encoding = 'UTF-8'

-- Text Display
vim.opt.linebreak = true
vim.opt.scrolloff = 999

-- Tab / Indentation
vim.opt.wrap = false

-- Search
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true

-- Appearance
vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.termguicolors = true
-- vim.opt.colorcolumn = '100'
vim.opt.signcolumn = 'yes'
-- vim.opt.completeopt = 'menuone,noinsert,noselect'
vim.opt.background = 'dark'

-- Behaviour
vim.opt.mouse:append('a')
