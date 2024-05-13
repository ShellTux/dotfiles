local mode    = 'tabs'

local options = {
	mode = mode,
	diagnostics = "nvim_lsp",
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
}

local keys    = {
	{ "<C-k>",      "<cmd>BufferLineCycleNext<cr>", desc = "Next " .. mode },
	{ "<C-j>",      "<cmd>BufferLineCyclePrev<cr>", desc = "Previous " .. mode },
	{ "<leader>bp", "<cmd>BufferLinePick<cr>",      desc = "Pick buffer" },
	{ "<leader>bc", "<cmd>BufferLinePickClose<cr>", desc = "Pick close buffer" },
	{ "<leader>bP", "<cmd>BufferLineTogglePin<cr>", desc = "Toggle pin buffer" },
}

if mode == 'tabs' then
	keys[#keys + 1] = { "<C-S-k>", "<cmd>tabmove +1<cr>", desc = "Move tab to the left" }
	keys[#keys + 1] = { "<C-S-j>", "<cmd>tabmove -1<cr>", desc = "Move tab to the right" }
elseif mode == 'buffers' then
	options['close_command'] = 'bdelete! %d'

	keys[#keys + 1] = { "<C-S-k>", "<cmd>BufferLineMoveNext<cr>", desc = "Move buffer to the left" }
	keys[#keys + 1] = { "<C-S-j>", "<cmd>BufferLineMovePrev<cr>", desc = "Move buffer to the right" }
	keys[#keys + 1] = { "<leader>bP", "<cmd>BufferLineTogglePin<cr>", desc = "Toggle pin buffer" }
end

return {
	'akinsho/bufferline.nvim',
	lazy = false,
	version = 'v3.*',
	dependencies = 'nvim-tree/nvim-web-devicons',
	init = function()
		vim.opt.termguicolors = true
	end,
	opts = {
		options = options,
	},
	keys = keys,
}
