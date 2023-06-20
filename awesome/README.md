# Awesome

## Files

- `rc.lua`: main configuration file
- `theme.lua`: theme
- `variables.lua`: where the variables are defined
- `functions.lua`: some custom functions
- `scratch.lua`: scratchpad lua file

## Features of My Awesome WM

- Window Swallowing

  For window swallowing, I came across this [reddit post](https://www.reddit.com/r/awesomewm/comments/h07f5y/does_awesome_support_window_swallowing/),
  and simply copy and paste with some modifications.

```lua
function is_terminal(c)
    return (c.class and c.class:match("term")) and true or false
end

function copy_size(c, parent_client)
    if not c or not parent_client then
        return
    end
    if not c.valid or not parent_client.valid then
        return
    end
    c.x=parent_client.x;
    c.y=parent_client.y;
    c.width=parent_client.width;
    c.height=parent_client.height;
end
function check_resize_client(c)
    if(c.child_resize) then
        copy_size(c.child_resize, c)
    end
end

client.connect_signal("property::size", check_resize_client)
client.connect_signal("property::position", check_resize_client)
client.connect_signal("manage", function(c)
    if is_terminal(c) then
        return
    end
    local parent_client=awful.client.focus.history.get(c.screen, 1)
    if parent_client and is_terminal(parent_client) then
        parent_client.child_resize=c
        c.floating=true
        copy_size(c, parent_client)
    end
end)
```

- Browse non-empty tags

  When browsing tags left or right, it will go to the next non-empty tag.
  Inspired by this [reddit](https://www.reddit.com/r/awesomewm/comments/lzly7b/browse_through_non_empty_tags/) post.

```lua
module.tag.view_next = function(empty, direction, screen)
	if empty then
		local wrap = function(index, total)
			if index < 1 then
				return total
			elseif index > total then
				return 1
			else
				return index
			end
		end

		return function()
			screen = screen or awful.screen.focused()
			local tags = screen.tags
			local original_index = wrap(screen.selected_tag.index + direction, #tags)

			local current_index = original_index
			while #(tags[current_index]:clients()) == 0 do
				current_index = wrap(current_index + direction, #tags)
				if current_index == original_index then
					break
				end
			end

			tags[current_index]:view_only()
		end
	else
		if direction > 0 then
			return awful.tag.viewnext
		elseif direction < 0 then
			return awful.tag.viewprev
		end
	end
end
```

- Scratchpad

  Launch a dropdown terminal, here is some sources and inspiration:

  - [Documentation for scratchpad_manager](https://www.reddit.com/r/awesomewm/comments/9u8ndc/documentation_for_scratchpad_manager/)
  - [awesome-scratch](https://github.com/notnew/awesome-scratch)
  - [Easy scratchpad](https://www.reddit.com/r/awesomewm/comments/x3lxgd/easy_scratchpad/)
  - [awesome-scratchpad.lua](https://pastebin.com/p8ZLV2wq)

- Sticky windows

  Make a window visible in all tags

  - [Awesome WM shortcut to toggle or make a window sticky. This shortcut is not show in my Super+S help menu](https://stackoverflow.com/questions/73519361/awesome-wm-shortcut-to-toggle-or-make-a-window-sticky-this-shortcut-is-not-show)
  - [Clients not going sticky.](https://www.reddit.com/r/awesomewm/comments/yl6w8c/clients_not_going_sticky/)

You need to make sure the keybind is inside the `clientkey` not globalkeys

```lua
awful.key({ modkey, 'Shift' }, 's', function(client) client.sticky = not client.sticky end,
	{ description = 'Toggle sticky', group = 'client' }),
```

- Notifaction defaults

```lua
naughty.config.defaults['icon_size'] = 384
naughty.config.defaults['timeout'] = 10
```

- Hide tags without clients

```lua
awful.widget.taglist {
    ...,
    filter  = awful.widget.taglist.filter.noempty,
    ...,
}
```
