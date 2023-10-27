return {
	'folke/todo-comments.nvim',
	dependencies = 'nvim-lua/plenary.nvim',
	lazy = false,
	opts = {
		keywords = {
			FIX  = { icon = " " },
			TODO = { icon = " " },
			HACK = { icon = " " },
			WARN = { icon = " " },
			PERF = { icon = "󰅒 " },
			NOTE = { icon = "󰍩 " },
			TEST = { icon = "⏲ " },
		},
	},
	keys = {
		vim.keymap.set('n', '<leader>pt', vim.cmd.TodoTelescope, {}),
	}
}
