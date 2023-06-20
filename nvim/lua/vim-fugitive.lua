local function gitdiff(history)
	return function()
		vim.cmd.tabnew('%')
		local command = 'Gvdiffsplit HEAD'
		if history > 0 then
			command = command .. '~' .. history
		end
		vim.cmd(command)

		-- Setting sidescrolloff to maximum for both buffers
		for _ = 1, 2, 1 do
			vim.api.nvim_input('<C-w>w :setlocal sidescrolloff=999<cr>')
		end
	end
end

local function openCommandInNewTab(command)
	return function()
		vim.cmd.tabnew();
		vim.cmd(command)
		vim.cmd.resize(999)
		vim.api.nvim_input('<C-w>w:q<cr>')
		local current_buffer = vim.api.nvim_get_current_buf()
		vim.api.nvim_buf_set_name(current_buffer, command)
	end
end

local function command(command_string)
	return function() vim.cmd(command_string) end
end

local module = {
	add      = command('Git add %'),
	checkout = command('Git checkout'),
	commit   = command('Git commit'),
	diff     = {},
	git      = openCommandInNewTab('Git'),
	-- TODO: If more than 1 branch ask for which branch log
	graph    = openCommandInNewTab('Git log --graph'),
	-- TODO: If more than 1 branch ask for which branch log
	log      = openCommandInNewTab('Git log'),
	push     = command('Git push'),
	show     = openCommandInNewTab('Git show'),
	stage    = command('Git stage %'),
}

for i = 0, 9 do
	module.diff[i] = gitdiff(i)
end

return module
