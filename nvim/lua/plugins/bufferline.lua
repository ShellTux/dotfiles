return {
	'akinsho/bufferline.nvim',
	lazy = false,
	version = 'v3.*',
	dependencies = 'nvim-tree/nvim-web-devicons',
	init = function()
		vim.opt.termguicolors = true
	end,
	opts = {
		options = {
			mode = "tabs", --set to "tabs" to only show tabpages instead
			diagnostics = "coc",
			diagnostics_indicator = function(count, level, diagnostics_dict, context)
				local s = " "
				for e, n in pairs(diagnostics_dict) do
					local sym = e == "error" and " "
					    or (e == "warning" and " " or "")
					s = s .. n .. sym
				end
				return s
			end,
			offsets = {
				{
					filetype = 'NvimTree'
				}
			},
			hover = {
				enabled = true,
				delay = 200,
				reveal = { 'close' }
			},
		},
	}
}
