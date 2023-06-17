# Sxhkd

Simple X hotkey daemon

The configuration locates at `sxhkdrc`

## Keybinds

Keybind                                                | Action
---                                                    | ---
`XF86AudioPlay`                                        | `Toggle mpd music`
`shift + XF86AudioPlay`                                | `Notify current playing music`
`super + XF86AudioPlay`                                | `Select music from mpd playlist`
`super + alt + {0-9}`                                  | `Seek music`
`XF86AudioMute`                                        | `Toggle mute`
`XF86Audio{LowerVolume,RaiseVolume}`                   | `Change volume by 5%`
`control + XF86Audio{LowerVolume,RaiseVolume}`         | `Change volume by 1%`
`shift + XF86Audio{LowerVolume,RaiseVolume}`           | `Change mpd volume by 5%`
`control + shift + XF86Audio{LowerVolume,RaiseVolume}` | `Change mpd volume by 1%`
`XF86Audio{Prev,Next}`                                 | `Go to previous/next music`
`XF86MonBrightness{Down,Up}`                           | `Change brightness by 5%`
`shift + XF86MonBrightness{Down,Up}`                   | `Change brightness by 1%`
`super + shift + apostrophe`                           | `Select article from arch-wiki`
`super + Insert`                                       | `Mount a drive`
`super + shift + Insert`                               | `Unmount a drive`
`super + v`                                            | `Copy a entry from the clipboard history (clipmenu)`
`super + F4`                                           | `Menu to poweroff computer`
`Print`                                                | `Screenshot with flameshot`
`super + Print`                                        | `Select mode screenshot`
`super + period`                                       | `Select emoji`
