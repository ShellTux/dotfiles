return {
	'L3MON4D3/LuaSnip',
	lazy = false,
	-- follow latest release.
	version = 'v2.*',
	-- install jsregexp (optional!).
	-- build = vim.fn.has "win32" ~= 0 and "make install_jsregexp" or nil,
	dependencies = {
		'rafamadriz/friendly-snippets',
		'benfowler/telescope-luasnip.nvim',
	},
	config = function(_, opts)
		local ls = require('luasnip')

		if opts then ls.config.setup(opts) end

		vim.tbl_map(
		function(type) require("luasnip.loaders.from_" .. type).lazy_load() end,
		{ "vscode", "snipmate", "lua" }
		)

		-- friendly-snippets - enable standardized comments snippets
		ls.filetype_extend("typescript", { "tsdoc" })
		ls.filetype_extend("javascript", { "jsdoc" })
		ls.filetype_extend("lua", { "luadoc" })
		ls.filetype_extend("python", { "pydoc" })
		ls.filetype_extend("rust", { "rustdoc" })
		ls.filetype_extend("cs", { "csharpdoc" })
		ls.filetype_extend("java", { "javadoc" })
		ls.filetype_extend("c", { "cdoc" })
		ls.filetype_extend("cpp", { "cppdoc" })
		ls.filetype_extend("php", { "phpdoc" })
		ls.filetype_extend("kotlin", { "kdoc" })
		ls.filetype_extend("ruby", { "rdoc" })
		ls.filetype_extend("sh", { "shelldoc" })
	end,
	keys = function()
		local ls = require('luasnip')

		vim.keymap.set({'i'}, '<C-K>', function() ls.expand() end, {silent = true})
		vim.keymap.set({'i', 's'}, '<Tab>', function() ls.jump( 1) end, {silent = true})
		vim.keymap.set({'i', 's'}, '<S-Tab>', function() ls.jump(-1) end, {silent = true})

		vim.keymap.set({'i', 's'}, '<C-E>', function()
			if ls.choice_active() then
				ls.change_choice(1)
			end
		end, {silent = true})
	end,
}
