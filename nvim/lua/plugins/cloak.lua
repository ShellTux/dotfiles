return {
	'laytan/cloak.nvim',
	ft = {
		'sh',
	},
	config = function(_, opts)
		require('cloak').setup({
			enabled = true,
			cloak_character = '*',
			highlight_group = 'Comment',
			cloak_length = nil,
			try_all_patterns = true,
			patterns = {
				{
					file_pattern = '.env*',
					cloak_pattern = '=.+',
					replace = nil,
				},
			},
		})
	end,
}
