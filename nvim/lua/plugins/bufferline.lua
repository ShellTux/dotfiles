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
			mode = "buffers",
			diagnostics = "nvim_lsp",
			close_command = "bdelete! %d",
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
	},
	keys = {
		{ "<C-k>",      "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
		{ "<C-j>",      "<cmd>BufferLineCyclePrev<cr>", desc = "Previous buffer" },
		{ "<C-S-k>",    "<cmd>BufferLineMoveNext<cr>",  desc = "Move buffer to the left" },
		{ "<C-S-j>",    "<cmd>BufferLineMovePrev<cr>",  desc = "Move buffer to the right" },
		{ "<leader>bp", "<cmd>BufferLinePick<cr>",      desc = "Pick buffer" },
		{ "<leader>bc", "<cmd>BufferLinePickClose<cr>", desc = "Pick close buffer" },
		{ "<leader>bP", "<cmd>BufferLineTogglePin<cr>", desc = "Toggle pin buffer" },
	},
}
