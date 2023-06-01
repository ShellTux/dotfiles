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

vim.keymap.set('n', '<leader>ga', command('Git add %'))               -- Add file to index of git repository
vim.keymap.set('n', '<leader>gc', command('Git commit'))              -- Make a commit. Record changes to the repository
vim.keymap.set('n', '<leader>gC', command('Git checkout'))            -- Switch branches or restore working tree files
vim.keymap.set('n', '<leader>gd0', gitdiff(0))                        -- Show changes between last commit, but always split vertically
vim.keymap.set('n', '<leader>gd1', gitdiff(1))                        -- Show changes between 2º last commit, but always split vertically
vim.keymap.set('n', '<leader>gd2', gitdiff(2))                        -- Show changes between 3º last commit, but always split vertically
vim.keymap.set('n', '<leader>gd3', gitdiff(3))                        -- Show changes between 4º last commit, but always split vertically
vim.keymap.set('n', '<leader>gd4', gitdiff(4))                        -- Show changes between 5º last commit, but always split vertically
vim.keymap.set('n', '<leader>gd5', gitdiff(5))                        -- Show changes between 6º last commit, but always split vertically
vim.keymap.set('n', '<leader>gd6', gitdiff(6))                        -- Show changes between 7º last commit, but always split vertically
vim.keymap.set('n', '<leader>gd7', gitdiff(7))                        -- Show changes between 8º last commit, but always split vertically
vim.keymap.set('n', '<leader>gd8', gitdiff(8))                        -- Show changes between 9º last commit, but always split vertically
vim.keymap.set('n', '<leader>gd9', gitdiff(9))                        -- Show changes between 10º last commit, but always split vertically
vim.keymap.set('n', '<leader>gl', openCommandInNewTab('Git log'))     -- Show commit logs
vim.keymap.set('n', '<leader>gg', openCommandInNewTab('Git'))         -- Show git
vim.keymap.set('n', '<leader>gS', openCommandInNewTab('Git show'))    -- Show various type of objects
vim.keymap.set('n', '<leader>gs', command('Git stage %')) -- Add file contents to the staging area
vim.keymap.set('n', '<leader>gp', command('Git push'))    -- Update remote refs along with associated objects. Push commits to remote
