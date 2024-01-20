return {
	'xiyaowong/transparent.nvim',
	lazy = false,
	init = function()
		vim.g.transparent_enabled = 1;
	end,
	opts = {
		-- table: default groups
		groups = {
			'Normal', 'NormalNC', 'Comment', 'Constant', 'Special', 'Identifier',
			'Statement', 'PreProc', 'Type', 'Underlined', 'Todo', 'String', 'Function',
			'Conditional', 'Repeat', 'Operator', 'Structure', 'LineNr', 'NonText',
			'SignColumn', 'CursorLineNr', 'EndOfBuffer',
		},
		-- table: additional groups that should be cleared
		extra_groups = {},
		-- table: groups you don't want to clear
		exclude_groups = {
			'Normal'
		},
	},
}
