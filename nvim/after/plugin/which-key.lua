vim.o.timeout = true
vim.o.timeoutlen = 300
require('which-key').setup()
local vim_fugitive = require('vim-fugitive')

local whichKey = require("which-key")
local registers = {
	g = {
		name = 'Git',
		a    = { vim_fugitive.add, 'Git add file' },
		ch   = { vim_fugitive.checkout, 'Git checkout file' },
		co   = { vim_fugitive.commit, 'Git commit file' },
		d    = 'Git diff',
		g    = { vim_fugitive.git, 'Git' },
		l    = 'Git log',
		lg   = { vim_fugitive.graph, 'Git log --graph' },
		lo   = { vim_fugitive.log, 'Git log' },
		p    = { vim_fugitive.push, 'Git push' },
		sh   = { vim_fugitive.show, 'Git show objects' },
		st   = { vim_fugitive.stage, 'Git stage file' },
		sw   = { vim_fugitive.switch, 'Git switch branch' },
		u    = { vim_fugitive.update, 'Git update remote refs' },
	},
	p = {
		name = 'Project',
		b = 'Find Buffer',
		c = 'Find Colorscheme',
		C = 'Git Switch Branch',
		f = 'Find File',
		g = 'Find Git file',
		G = 'Rip Grep',
		h = 'Find Help Tag',
		t = 'Find TODO',
	},
	t = {
		name = 'Tab',
		c = 'Tab Close',
	},
	u = 'Undo Tree'
}

for i = 0, 9 do
	local description = 'Git diff HEAD'
	if i >= 1 then
		description = description .. '~'
		if i >= 2 then
			description = description .. i
		end
	end
	registers.g['d' .. i] = { vim_fugitive.diff(i), description }
end

whichKey.register(registers, { prefix = '<leader>' })
