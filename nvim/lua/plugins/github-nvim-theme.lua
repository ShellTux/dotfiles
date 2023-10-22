return {
	'projekt0n/github-nvim-theme',
	lazy = false,
	priority = 999,
	config = function()
		require('github-theme').setup({
			options = {
				transparent = true,
			}
		})
	end,
}
