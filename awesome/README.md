# Awesome

## Files

- rc.lua: main configuration file
- theme.lua: theme
- variables.lua: where the variables are defined
- functions.lua: some custom functions

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
