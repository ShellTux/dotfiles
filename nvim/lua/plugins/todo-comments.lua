return {
	'folke/todo-comments.nvim',
	dependencies = 'nvim-lua/plenary.nvim',
	lazy = false,
	opts = {
		highlight = {
			pattern = [[.*<(KEYWORDS)(\([^\)]*\))?]],
		},
		keywords = {
			FIX  = { icon = " " },
			TODO = { icon = " " },
			HACK = { icon = " " },
			WARN = { icon = " " },
			PERF = { icon = "󰅒 " },
			NOTE = { icon = "󰍩 " },
			TEST = { icon = "⏲ " },
		},
		search = {
			pattern = [[\b(KEYWORDS)(\([^\)]*\))?]],
		},
	},
	keys = {
		vim.keymap.set('n', '<leader>pt', vim.cmd.TodoTelescope, {}),
	}
}
