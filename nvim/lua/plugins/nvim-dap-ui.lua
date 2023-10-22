return {
	'rcarriga/nvim-dap-ui',
	event = 'VeryLazy',
	dependencies = 'mfussenegger/nvim-dap',
	config = function()
		local dap, dapui = require('dap'), require('dapui')
		local open       = function() dapui.open() end
		local close      = function() dapui.close() end


		dap.listeners.after.event_initialized['dapui_config'] = open
		dap.listeners.before.event_terminated['dapui_config'] = close
		dap.listeners.before.event_exited['dapui_config']     = close

		dapui.setup()
	end,
}
