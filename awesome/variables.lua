local awful         = require('awful')
local delayed_call  = require('gears').timer.delayed_call
local suit          = awful.layout.suit
local screen_width  = awful.screen.focused().geometry.width
local screen_height = awful.screen.focused().geometry.height


local module           = {
	scratchpad = {},
}

module.workspace_names = { '  ', '  ', '  ', '  ', ' E ', '  ', '  ', '  ', '  ' }
module.layouts         = {
	suit.floating,
	suit.tile,
	suit.tile.left,
	suit.tile.bottom,
	suit.tile.top,
	suit.fair,
	suit.fair.horizontal,
	suit.spiral,
	suit.spiral.dwindle,
	suit.max,
	suit.max.fullscreen,
	suit.magnifier,
	suit.corner.nw,
	-- suit.corner.ne,
	-- suit.corner.sw,
	-- suit.corner.se,
}
module.startup_layout  = module.layouts[2]
module.terminal        = 'kitty'
module.editor          = os.getenv('EDITOR') or 'gedit'
module.modkey          = 'Mod4' -- Modkey: Mod4 = Super, Mod1 = Alt
module.scratchpad      = {
	rule = { instance = 'scratchpad' },
	properties = {
		floating = true,
		ontop = true,
		width = screen_width * 0.7,
		height = screen_height * 0.75
	},
	callback = function(client)
		awful.placement.centered(client, { honor_padding = true, honor_workarea = true })
		delayed_call(function() client.urgent = false end)
	end,
}
-- theme = gears.filesystem.get_themes_dir() .. 'default/theme.lua'

return module
