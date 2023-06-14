local awful         = require('awful')
local beautiful     = require('beautiful')
local gears         = require('gears')
local hotkeys_popup = require('awful.hotkeys_popup')
local wibox         = require('wibox') -- Widget and layout library
local variables     = require('variables')


local module = {
	screen = {}
}


module.help = function() hotkeys_popup.show_help(nil, awful.screen.focused()) end
module.quit = function() awesome.quit() end
module.screen.set_wallpaper = function(screen)
	-- Wallpaper
	if beautiful.wallpaper then
		local wallpaper = beautiful.wallpaper
		-- If wallpaper is a function, call it with the screen
		if type(wallpaper) == 'function' then
			wallpaper = wallpaper(screen)
		end
		gears.wallpaper.maximized(wallpaper, screen, true)
	end
end

module.screen.connect_for_each_screen = function(screen)
	-- Wallpaper
	-- module.screen.set_wallpaper(screen)

	-- Each screen has its own tag table.
	awful.tag(variables.workspace_names, screen, variables.startup_layout)

	-- Create a promptbox for each screen
	screen.mypromptbox = awful.widget.prompt()
	-- Create an imagebox widget which will contain an icon indicating which layout we're using.
	-- We need one layoutbox per screen.
	screen.mylayoutbox = awful.widget.layoutbox(screen)
	screen.mylayoutbox:buttons(gears.table.join(
		awful.button({}, 1, function() awful.layout.inc(1) end),
		awful.button({}, 3, function() awful.layout.inc(-1) end),
		awful.button({}, 4, function() awful.layout.inc(1) end),
		awful.button({}, 5, function() awful.layout.inc(-1) end)))
	-- Create a taglist widget
	screen.mytaglist = awful.widget.taglist {
		screen  = screen,
		filter  = awful.widget.taglist.filter.all,
		buttons = taglist_buttons
	}

	-- Create a tasklist widget
	screen.mytasklist = awful.widget.tasklist {
		screen  = screen,
		filter  = awful.widget.tasklist.filter.currenttags,
		buttons = tasklist_buttons
	}

	-- Create the wibox
	screen.mywibox = awful.wibar({ position = 'top', screen = screen })

	-- Add widgets to the wibox
	screen.mywibox:setup {
		layout = wibox.layout.align.horizontal,
		{
			-- Left widgets
			layout = wibox.layout.fixed.horizontal,
			mylauncher,
			screen.mytaglist,
			screen.mypromptbox,
		},
		screen.mytasklist, -- Middle widget
		{
			-- Right widgets
			layout = wibox.layout.fixed.horizontal,
			mykeyboardlayout,
			wibox.widget.systray(),
			mytextclock,
			screen.mylayoutbox,
		},
	}
end

local function is_terminal(client)
	return (client.class and client.class:match('kitty'))
end

local function copy_size(client, parent_client)
	if not client or not parent_client then
		return
	end
	if not client.valid or not parent_client.valid then
		return
	end
	client.x = parent_client.x;
	client.y = parent_client.y;
	client.width = parent_client.width;
	client.height = parent_client.height;
end

module.check_resize_client = function(client)
	if (client.child_resize) then
		copy_size(client.child_resize, client)
	end
end

-- TODO: Disable swallowing for specific child windows
module.manage = function(client)
	if is_terminal(client) then
		return
	end
	local parent_client = awful.client.focus.history.get(client.screen, 1)
	if parent_client and is_terminal(parent_client) then
		parent_client.child_resize = client
		parent_client.minimized = true

		client:connect_signal("unmanage", function() parent_client.minimized = false end)

		-- c.floating=true
		copy_size(client, parent_client)
	end
end

return module
