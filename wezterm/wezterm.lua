-- Pull in the wezterm API
local wezterm = require 'wezterm'
local gui = wezterm.gui

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- This table will hold the configuration.
local config = {
	automatically_reload_config = true,
	default_cwd = '~',
	default_prog = { '/usr/bin/zsh' },
	enable_wayland = true,
	window_background_opacity = 0.8,
	window_decorations = 'NONE',
	-- keys = {
	-- 	{
	-- 		key = 'f',
	-- 		mods = 'ALT',
	-- 		action = wezterm.action.ToggleFullScreen,
	-- 	},
	-- },
}

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
-- config.color_scheme = 'AdventureTime'

-- and finally, return the configuration to wezterm
return config
