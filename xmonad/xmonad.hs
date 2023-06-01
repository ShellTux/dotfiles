-- Base
import XMonad
import System.Directory
import System.IO (hClose, hPutStr, hPutStrLn)
import System.Exit (exitSuccess)
import qualified XMonad.StackSet as W

-- Actions
import XMonad.Actions.Commands (runCommand, defaultCommands)
import XMonad.Actions.CycleWS (nextWS, prevWS, shiftToNext, shiftToPrev, nextScreen, prevScreen, shiftNextScreen, shiftPrevScreen, toggleWS)
import XMonad.Actions.FindEmptyWorkspace (viewEmptyWorkspace, tagToEmptyWorkspace)
import XMonad.Actions.NoBorders (toggleBorder)
import qualified XMonad.Actions.ConstrainedResize as Sqr (mouseResizeWindow)
import qualified XMonad.Actions.FlexibleResize as Flex (mouseResizeWindow)

-- Data
import Data.Monoid
import qualified Data.Map as M
 
-- Hooks
import XMonad.Hooks.DynamicIcons (iconsPP, appIcon)
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks --(ToggleStruts)
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP
import XMonad.Hooks.WindowSwallowing (swallowEventHook)

-- Layouts
import XMonad.Layout.CenteredMaster --(centerMaster, Grid)
import XMonad.Layout.Circle
import XMonad.Layout.Drawer (simpleDrawer, Property(Or), Property(ClassName), onTop)
import XMonad.Layout.NoBorders (noBorders, smartBorders)
import XMonad.Layout.Renamed (renamed, Rename(Replace))
import XMonad.Layout.Tabbed (simpleTabbed, tabbed)
import XMonad.Layout.ThreeColumns
import XMonad.Layout.ToggleLayouts (ToggleLayout(..), toggleLayouts)

-- Layouts modifiers
--import XMonad.Layout.Gaps (gaps, Direction2D(U), Direction2D(R), Direction2D(D), Direction2D(L))
import XMonad.Layout.Spacing (smartSpacing)
import qualified XMonad.Layout.Magnifier as Mag (magnifierczOff, MagnifyMsg(MagnifyMore), MagnifyMsg(MagnifyLess), MagnifyMsg(Toggle))

-- Utilities
import XMonad.Util.Dmenu
import XMonad.Util.EZConfig (additionalKeysP, mkNamedKeymap)
import XMonad.Util.Loggers
import XMonad.Util.Run (runProcessWithInput, safeSpawn, spawnPipe)
import XMonad.Util.SpawnOnce
import XMonad.Util.Ungrab (unGrab)

myFont :: String
myFont = "xft:SauceCodePro Nerd Font Mono:regular:size=16:antialias=true:hinting=true"

myModMask :: KeyMask
myModMask = mod4Mask        -- Sets modkey to super/windows key

myTerminal :: String
myTerminal = "alacritty"    -- Sets default terminal

myBrowser :: String
myBrowser = "firefox "  -- Sets qutebrowser as browser

--myEmacs :: String
--myEmacs = "emacsclient -c -a 'emacs' "  -- Makes emacs keybindings easier to type

myEditor :: String
--myEditor = "emacsclient -c -a 'emacs' "  -- Sets emacs as editor
myEditor = myTerminal ++ " -e vim "    -- Sets vim as editor
--
-- myBorderWidth :: Dimension
myBorderWidth = 2           -- Sets border width for windows
--
-- myNormColor :: String       -- Border color of normal windows
-- myNormColor   = colorBack   -- This variable is imported from Colors.THEME
--
-- myFocusColor :: String      -- Border color of focused windows
-- myFocusColor  = color15     -- This variable is imported from Colors.THEME
--
-- mySoundPlayer :: String
-- mySoundPlayer = "ffplay -nodisp -autoexit " -- The program that will play system sounds
--
-- windowCount :: X (Maybe String)
-- windowCount = gets $ Just . show . length . W.integrate' . W.stack . W.workspace . W.current . windowset

myIcons :: Query [String]
myIcons = composeAll
  [ className =? "discord" --> appIcon "\xfb6e"
  , className =? "Discord" --> appIcon "\xf268"
  , className =? "Firefox" --> appIcon "\63288"
  , className =? "Spotify" <||> className =? "spotify" --> appIcon "阮"
  ]

myStartupHook :: X ()
myStartupHook = do
  spawn "killall trayer"  -- kill current trayer on each restart

  spawnOnce "picom"
  spawnOnce "sxhkd"
  spawnOnce "dunst"
  spawnOnce "clipmenud"
  spawnOnce "numlockx on"
  spawnToWorkspace "discord" "9"
  spawnOnce "nm-applet"
  spawnOnce "syncthingtray"
  spawnOnce "while :; do feh --no-fehbg --bg-fill --randomize $HOME/Imagens/Wallpapers; sleep 300; done" -- Random wallpaper every 5 minutes

  --spawn ("sleep 2 && trayer --edge top --align right --widthtype request --padding 6 --SetDockType true --SetPartialStrut true --expand true --monitor 1 --transparent true --alpha 0 " ++ colorTrayer ++ " --height 22")
  spawn "sleep 2 && trayer --edge top --align right --SetDockType true --SetPartialStrut true --expand true --width 5 --transparent true --tint 0x5f5f5f --height 22"

-- Whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

-- Whether clicking on a window to focus also passes the click to the window
myClickJustFocuses :: Bool
myClickJustFocuses = False

-- > workspaces = ["web", "irc", "code" ] ++ map show [4..9]
myWorkspaces    = ["1","2","3","4","5","6","7","8","9"]

-- Border colors for unfocused and focused windows, respectively.
--
myNormalBorderColor  = "#dddddd"
myFocusedBorderColor = "#ff0000"

commands :: X [(String, X ())]
commands = defaultCommands

spawnToWorkspace :: String -> String -> X ()
spawnToWorkspace program workspace = do
                                      spawnOnce program     
                                      windows $ W.greedyView workspace

myXmobarPP :: PP
myXmobarPP = def
      { ppSep             = magenta " | "
      , ppTitleSanitize   = xmobarStrip
      , ppCurrent         = wrap " " "" . xmobarBorder "Top" "#8be9fd" 2
      , ppHidden          = white . wrap " " ""
      , ppHiddenNoWindows = lowWhite . wrap " " ""
      , ppUrgent          = red . wrap (yellow "!") (yellow "!")
      , ppOrder           = \[ws, l, _, wins] -> [ws, l, wins]
      , ppExtras          = [logTitles formatFocused formatUnfocused]
}
      where
      formatFocused   = wrap (white    "[") (white    "]") . magenta . ppWindow
      formatUnfocused = wrap (lowWhite "[") (lowWhite "]") . blue    . ppWindow

      -- | Windows should have *some* title, which should not not exceed a
      --     -- sane length.
      ppWindow :: String -> String
      ppWindow = xmobarRaw . (\w -> if null w then "untitled" else w) . shorten 30

      blue, lowWhite, magenta, red, white, yellow :: String -> String
      magenta  = xmobarColor "#ff79c6" ""
      blue     = xmobarColor "#bd93f9" ""
      white    = xmobarColor "#f8f8f2" ""
      yellow   = xmobarColor "#f1fa8c" ""
      red      = xmobarColor "#ff5555" ""
      lowWhite = xmobarColor "#bbbbbb" ""

------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.
--
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $
    -- launch a terminal
    [ ((modm .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf)
    -- launch dmenu
    , ((modm,               xK_p     ), spawn "dmenu_run")
    -- launch gmrun
    , ((modm .|. shiftMask, xK_p     ), spawn "gmrun")
    -- close focused window
    , ((modm .|. shiftMask, xK_c     ), kill)
     -- Rotate through the available layout algorithms
    , ((modm,               xK_space ), sendMessage NextLayout)
    --  Reset the layouts on the current workspace to default
    , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)
    -- Resize viewed windows to the correct size
    , ((modm,               xK_n     ), refresh)
    -- Move focus to the next window
    , ((mod1Mask,           xK_Tab   ), windows W.focusDown)
    -- Cycle through WS
    , ((modm,               xK_Down),  nextWS)
    , ((modm,               xK_Up),    prevWS)
    , ((modm .|. shiftMask, xK_Down),  shiftToNext)
    , ((modm .|. shiftMask, xK_Up),    shiftToPrev)
    , ((modm,               xK_Right), nextScreen)
    , ((modm,               xK_Left),  prevScreen)
    , ((modm .|. shiftMask, xK_Right), shiftNextScreen)
    , ((modm .|. shiftMask, xK_Left),  shiftPrevScreen)
    , ((modm,               xK_z),     toggleWS)
    -- Move focus to the next window
    , ((modm,               xK_j     ), windows W.focusDown)
    -- Move focus to the previous window
    , ((modm,               xK_k     ), windows W.focusUp  )
    -- Move focus to the master window
    , ((modm,               xK_m     ), windows W.focusMaster  )
    -- Swap the focused window and the master window
    , ((modm,               xK_Return), windows W.swapMaster)
    -- Swap the focused window with the next window
    , ((modm .|. shiftMask, xK_j     ), windows W.swapDown  )
    -- Swap the focused window with the previous window
    , ((modm .|. shiftMask, xK_k     ), windows W.swapUp    )
    -- Shrink the master area
    , ((modm,               xK_h     ), sendMessage Shrink)
    -- Expand the master area
    , ((modm,               xK_l     ), sendMessage Expand)
    -- Push window back into tiling
    , ((modm,               xK_t     ), withFocused $ windows . W.sink)
    -- Increment the number of windows in the master area
    , ((modm              , xK_comma ), sendMessage (IncMasterN 1))
    -- Deincrement the number of windows in the master area
    , ((modm              , xK_period), sendMessage (IncMasterN (-1)))
    -- Toggle the status bar gap
    -- Use this binding with avoidStruts from Hooks.ManageDocks.
    -- See also the statusBar function from Hooks.DynamicLog.
    , ((modm              , xK_b     ), sendMessage ToggleStruts)
    -- Quit xmonad
    , ((modm .|. shiftMask, xK_q     ), io exitSuccess)
    -- Restart xmonad
    , ((modm              , xK_q     ), spawn "xmonad --recompile && xmonad --restart")
    -- Recompile xmonad
    --, ((modm              , xK_r     ), spawn "alacritty -e xmonad --recompile")
    , ((modm              , xK_r     ), spawn "xmonad --recompile")
    -- Run xmessage with a summary of the default keybindings (useful for beginners)
    , ((modm .|. shiftMask, xK_slash ), xmessage help)
    -- Launch Firefox
    --, ((modm              , xK_f ), spawn "firefox")
    -- Take a screenshot
    --, ((modm, Print ), unGrab *> spawn "scrot -s")
    -- Dmenu prompt xmonad commands
    --, ((modm .|. controlMask, xK_y), commands >>= runCommand)
    -- Find Empty Workspace
    , ((mod1Mask                          ,  xK_m   ), viewEmptyWorkspace         )
    , ((mod1Mask .|. shiftMask            ,  xK_m   ), tagToEmptyWorkspace        )
    -- Toggle Borders
    , ((modm                              , xK_g ),    withFocused toggleBorder   )
    -- Magnifier
    , ((modm .|. controlMask              , xK_plus ), sendMessage Mag.MagnifyMore)
    , ((modm .|. controlMask              , xK_minus), sendMessage Mag.MagnifyLess)
    , ((modm .|. controlMask              , xK_m    ), sendMessage Mag.Toggle     )
    -- Spawn Htop
    , ((mod1Mask                          , xK_h    ), spawn "$TERMINAL -e htop")
    -- Toggle fullscreen
    , ((modm                              , xK_f    ), sendMessage (Toggle "Full"))--, sendMessage ToggleStruts)
    ]
    ++

    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++

    -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
    [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]


------------------------------------------------------------------------
-- Mouse bindings: default actions bound to mouse events
myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList
    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modm, button1), \w -> focus w >> mouseMoveWindow w
                                      >> windows W.shiftMaster)
    -- mod-button2, Raise the window to the top of the stack
    , ((modm, button2), \w -> focus w >> windows W.shiftMaster)
    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modm, button3), \w -> focus w >> mouseResizeWindow w
                                      >> windows W.shiftMaster)
    -- you may also bind events to the mouse scroll wheel (button4 and button5)

    -- Resize window respecting aspect ratio
    , ((modm, button3),               \w -> focus w >> Sqr.mouseResizeWindow w False)
    , ((modm .|. shiftMask, button3), \w -> focus w >> Sqr.mouseResizeWindow w True )
    -- Resize floating windows from any corner
    , ((modm, button3), \w -> focus w >> Flex.mouseResizeWindow w)
    ]

------------------------------------------------------------------------
-- Layouts:

-- tall     = renamed [Replace "tall"] $ smartBorders
monocle  = renamed [Replace "monocle"] $
           smartBorders
           Full
-- tabs     = renamed [Replace "tabs"]
--            -- I cannot add spacing to this layout because it will
--            -- add spacing between window and tabs which looks bad.
--            $ tabbed shrinkText myTabTheme




myLayout = Mag.magnifierczOff 1.5 $ toggleLayouts (noBorders Full) $  tiled ||| simpleTabbed ||| Full ||| Mirror tiled ||| drawer `onTop` Tall 1 0.03 0.5 ||| noBorders Full ||| threeCol ||| Circle -- ||| centerMaster Grid
  where
  threeCol = ThreeColMid nmaster delta ratio
  tiled   = Tall nmaster delta ratio
  -- The default number of windows in the master pane
  nmaster = 1
  -- Default proportion of screen occupied by master pane
  ratio   = 1/2
  -- Percent of screen to increment by when resizing panes
  delta   = 3/100
  inactiveBorderColor = "#FF0000"
  activeTextColor = "#00FF00"
  drawer = simpleDrawer 0.01 0.3 (ClassName "Rhythmbox" `Or` ClassName "Xchat")

------------------------------------------------------------------------
-- Window rules:

-- Execute arbitrary actions and WindowSet manipulations when managing
-- a new window. You can use this to, for example, always float a
-- particular program, or have a client always appear on a particular
-- workspace.
--
-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
-- and click on the client you're interested in.
--
-- To match on the WM_NAME, you can use 'title' in the same way that
-- 'className' and 'resource' are used below.
--
myManageHook = composeAll
    [ 
      className =? "MPlayer"        --> doFloat
    , className =? "Gimp"           --> doFloat
    --, className =? "discord"      --> doFloat
    , resource  =? "desktop_window" --> doIgnore
    , resource  =? "kdesktop"       --> doIgnore 
    , className =? "Tk"             --> doFloat
    ]

------------------------------------------------------------------------
-- Event handling

-- * EwmhDesktops users should change this to ewmhDesktopsEventHook
--
-- Defines a custom handler function for X Events. The function should
-- return (All True) if the default handler is to be run afterwards. To
-- combine event hooks use mappend or mconcat from Data.Monoid.
--
myEventHook = swallowEventHook (className =? "Alacritty" <||> className =? "Termite") (return True)

------------------------------------------------------------------------
-- Status bars and logging

-- Perform an arbitrary action on each internal state change or X event.
-- See the 'XMonad.Hooks.DynamicLog' extension for examples.
--
myLogHook = return ()

------------------------------------------------------------------------
-- Now run xmonad with all the defaults we set up.

-- Run xmonad with the settings you specify. No need to modify this.

main :: IO ()
main = xmonad 
      . ewmhFullscreen 
      . ewmh 
      . withEasySB (statusBarProp "xmobar ~/.config/xmobar/xmobarrc" (pure myXmobarPP)) defToggleStrutsKey
      -- . withEasySB (statusBarProp "xmobar ~/.config/xmobar/xmobarrc2" (pure myXmobarPP)) defToggleStrutsKey
      $ defaults
      where
      toggleStrutsKey :: XConfig Layout -> (KeyMask, KeySym)
      toggleStrutsKey XConfig{ modMask = m } = (m, xK_b)

defaults = def {
      -- simple stuff
        terminal           = myTerminal,
        focusFollowsMouse  = myFocusFollowsMouse,
        clickJustFocuses   = myClickJustFocuses,
        borderWidth        = myBorderWidth,
        modMask            = myModMask,
        workspaces         = myWorkspaces,
        normalBorderColor  = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,

      -- key bindings
        keys               = myKeys,
        mouseBindings      = myMouseBindings,

      -- hooks, layouts
        layoutHook         = smartSpacing 4 $ smartBorders myLayout,
        manageHook         = myManageHook,
        handleEventHook    = myEventHook,
        logHook            = myLogHook,
        startupHook        = myStartupHook
    }

-- | Finally, a copy of the default bindings in simple textual tabular format.
help :: String
help = unlines ["The default modifier key is 'alt'. Default keybindings:",
    "",
    "-- launching and killing programs",
    "mod-Shift-Enter  Launch xterminal",
    "mod-p            Launch dmenu",
    "mod-Shift-p      Launch gmrun",
    "mod-Shift-c      Close/kill the focused window",
    "mod-Space        Rotate through the available layout algorithms",
    "mod-Shift-Space  Reset the layouts on the current workSpace to default",
    "mod-n            Resize/refresh viewed windows to the correct size",
    "mod-Shift-/      Show this help message with the default keybindings",
    "",
    "-- move focus up or down the window stack",
    "mod-Tab        Move focus to the next window",
    "mod-Shift-Tab  Move focus to the previous window",
    "mod-j          Move focus to the next window",
    "mod-k          Move focus to the previous window",
    "mod-m          Move focus to the master window",
    "",
    "-- modifying the window order",
    "mod-Return   Swap the focused window and the master window",
    "mod-Shift-j  Swap the focused window with the next window",
    "mod-Shift-k  Swap the focused window with the previous window",
    "",
    "-- resizing the master/slave ratio",
    "mod-h  Shrink the master area",
    "mod-l  Expand the master area",
    "",
    "-- floating layer support",
    "mod-t  Push window back into tiling; unfloat and re-tile it",
    "",
    "-- increase or decrease number of windows in the master area",
    "mod-comma  (mod-,)   Increment the number of windows in the master area",
    "mod-period (mod-.)   Deincrement the number of windows in the master area",
    "",
    "-- quit, or restart",
    "mod-Shift-q  Quit xmonad",
    "mod-q        Restart xmonad",
    "mod-[1..9]   Switch to workSpace N",
    "",
    "-- Workspaces & screens",
    "mod-Shift-[1..9]   Move client to workspace N",
    "mod-{w,e,r}        Switch to physical/Xinerama screens 1, 2, or 3",
    "mod-Shift-{w,e,r}  Move client to screen 1, 2, or 3",
    "",
    "-- Mouse bindings: default actions bound to mouse events",
    "mod-button1  Set the window to floating mode and move by dragging",
    "mod-button2  Raise the window to the top of the stack",
    "mod-button3  Set the window to floating mode and resize by dragging"]
