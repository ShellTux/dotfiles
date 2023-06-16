# Alacritty

<img src="https://raw.githubusercontent.com/alacritty/alacritty/master/extra/logo/compat/alacritty-term%2Bscanlines.png" alt="Alacritty Logo" style="max-width: 200px; max-height: 200px;">

The `alacrity.yaml` file is a configuration file for the `Alacritty` terminal emulator.
It includes various settings that can be customized to suit your preferences.

Here's what each section of the configuration file does:

- `import`: This section imports the color scheme from a YAML file in the ~/.config/alacritty/colorschemes directory.
- `env`: This sets the terminal type to alacritty.
- `window`: This section sets the dimensions and position of the window
  - `opacity`: 0.9
  - `title`: Alacritty
- `scrolling`:
  - `history`: 10.000 lines
  - `scroll multiplier`: 3
- `font`:
  - `family`: Fira Code Regular
  - `size`: 19 points
- `draw_bold_text_with_bright_colors`: This disables drawing bold text
  in bright colors.
- `selection`: This disables saving selected text to the clipboard.
- `cursor`: This sets the cursor style to a block shape with blinking turned off.
  It also enables hollow cursor when unfocused and sets the thickness to 0.15.
- `live_config_reload`: This enables live configuration reloading for the terminal.
- `working_directory`: This sets the working directory to None.
- `ipc_socket`: This enables interprocess communication (IPC) over Unix sockets.
- `mouse`: This sets the double-click and triple-click thresholds to 300ms and
  hides the mouse cursor while typing.
- `key_bindings`:

  | Key              | Mod keys            | action             |
  | ---------------- | ------------------- | ------------------ |
  | `Return`         | `Control` + `Shift` | `SpawnNewInstance` |
  | `Plus`           | `Control`           | `IncreaseFontSize` |
  | `NumpadAdd`      | `Control`           | `IncreaseFontSize` |
  | `Minus`          | `Control`           | `DecreaseFontSize` |
  | `NumpadSubtract` | `Control`           | `DecreaseFontSize` |
  | `Key0`           | `Control`           | `ResetFontSize`    |

- `debug`: This controls various debug options, such as disabling render timer,
  persistent logging, log level, and printing events.

Overall, this configuration file provides a solid starting point for customizing
the Alacritty terminal emulator to your needs.
