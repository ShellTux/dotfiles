return {
	'phaazon/hop.nvim',
	branch = 'v2', -- optional but strongly recommended
	enabled = false, -- WARN: unmantained
	lazy = false,
	opts = {
		keys = 'etovxqpdygfblzhckisuran',
		current_line_only = false,
	},
	keys = function()
		local hop = require('hop')
		local directions = require('hop.hint').HintDirection
		vim.keymap.set('', 'f', function()
			hop.hint_char1({ direction = directions.AFTER_CURSOR })
		end, { remap = true })
		vim.keymap.set('', 'F', function()
			hop.hint_char1({ direction = directions.BEFORE_CURSOR })
		end, { remap = true })
		vim.keymap.set('', 't', function()
			hop.hint_char1({ direction = directions.AFTER_CURSOR, hint_offset = -1 })
		end, { remap = true })
		vim.keymap.set('', 'T', function()
			hop.hint_char1({ direction = directions.BEFORE_CURSOR, hint_offset = 1 })
		end, { remap = true })
	end,
}
