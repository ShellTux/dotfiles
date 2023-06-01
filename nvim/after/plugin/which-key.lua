vim.o.timeout = true
vim.o.timeoutlen = 300
require('which-key').setup()
local whichKey = require("which-key")
whichKey.register({
	g = {
		name = 'Git',
		a = 'Git add file',  -- Add file to index of git repository
		c = 'Git commit',  -- Make a commit. Record changes to the repository
		C = 'Git switch branch',  -- Switch branches or restore working tree files
		l = 'Git log',  -- Show commit logs
		g = 'Git',  -- Show git
		S = 'Git show objects',  -- Show various type of objects
		s = 'Git stage file',  -- Add file contents to the staging area
		p = 'Git update remote refs',  -- Update remote refs along with associated objects. Push commits to remote
		d = {
			name = 'Git diff',
			['0'] = 'HEAD',
			['1'] = 'HEAD~1',
			['2'] = 'HEAD~2',
			['3'] = 'HEAD~3',
			['4'] = 'HEAD~4',
			['5'] = 'HEAD~5',
			['6'] = 'HEAD~6',
			['7'] = 'HEAD~7',
			['8'] = 'HEAD~8',
			['9'] = 'HEAD~9',
		},
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
}, { prefix = '<leader>' })
