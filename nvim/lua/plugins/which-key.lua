return {
	'folke/which-key.nvim',
	event = 'VeryLazy',
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 300
	end,
	config = function()
		require('which-key').setup()
		local vim_fugitive = require('vim-fugitive')
		local functions = require('functions')

		-- TODO: organize keybinds
		local whichKey = require('which-key')
		local registers = {
			d = {
				b = { '<cmd>DapToggleBreakpoint<cr>', 'Add Breakpoint at line' },
				r = { '<cmd>DapContinue<cr>', 'Start or Continue the debugger' },
			},
			g = {
				name = 'Git',
				a    = { vim_fugitive.add, 'Git add file' },
				b    = { '<cmd>Gitsigns toggle_current_line_blame<cr>', 'Git toggle blame' },
				ch   = { vim_fugitive.checkout, 'Git checkout file' },
				com  = { vim_fugitive.commit, 'Git commit file' },
				con  = { vim_fugitive.conflict, 'Git conflicts' },
				d    = 'Git diff',
				dh   = 'Git diff horizontal split',
				dv   = 'Git diff vertical split',
				ds   = { vim_fugitive.diff_staged, 'Git diff staged files' },
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
			l = { '<cmd>Lazy<cr>', 'Lazy Open' },
			m = { '<cmd>Mason<cr>', 'Mason' },
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
				s = 'Git status',
			},
			S = { functions.ToggleAutoSave, 'Toggle Auto Save' },
			t = {
				name = 'Tab',
				c = 'Tab Close',
			},
			T = { '<cmd>Twilight<cr>', 'Twilight' },
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
			registers.g['d' .. i]  = { vim_fugitive.diff(i, 'vertical'), description }
			registers.g['dh' .. i] = { vim_fugitive.diff(i, 'horizontal'), description }
			registers.g['dv' .. i] = { vim_fugitive.diff(i, 'vertical'), description }
		end

		whichKey.register(registers, { prefix = '<leader>' })
	end,
}
