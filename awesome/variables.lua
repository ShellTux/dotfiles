local suit = require('awful').layout.suit
local module = {}

module.workspace_names = { '', '', '', '', 'E', '', '', '', '' }
module.layouts = {
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
module.startup_layout = module.layouts[2]
module.terminal   = 'kitty'
module.editor     = os.getenv('EDITOR') or 'gedit'
module.modkey = 'Mod4' -- Modkey: Mod4 = Super, Mod1 = Alt
-- theme = gears.filesystem.get_themes_dir() .. 'default/theme.lua'

return module
