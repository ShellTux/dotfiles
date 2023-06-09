# My Dotfiles

These are my personal configuration files for various applications
that I use on a daily basis.
This repository serves as a way to easily sync and backup my configurations
across different machines.

## Installation

To install these dotfiles on a new machine, simply clone this repository into your home directory:

```sh
git clone https://github.com/ShellTux/dotfiles ~/.config
```

Then run make to install symbolic links to `.bashrc`, `.bash_profile`,
`.xinitrc`, `.Xresources` on the home directory, and install the files under the etc folder.

```sh
cd ~/.config
make
```


## Usage

Once installed, any changes you make to the configuration files in your home
directory will be reflected in the corresponding files in this repository.
Similarly, any changes you make to the files in this repository
will be reflected in your home directory.

Some programs depend on my [shell scripts](https://github.com/ShellTux/shell-scripts).

```sh
git clone https://github.com/ShellTux/shell-scripts ~/.local/bin
```

## Included Configurations

This repository includes configurations for:

- [Alacritty](https://alacritty.org/)
- [Awesome WM](https://awesomewm.org/)
- [Bash](https://www.gnu.org/software/bash/)
- [Bat](https://github.com/sharkdp/bat)
- [Bpython](https://bpython-interpreter.org/)
- [Btop](https://github.com/aristocratos/btop)
- [Calcurse](https://www.calcurse.org/)
- [Clang-format](https://clang.llvm.org/docs/ClangFormat.html)
- [Clang-tidy](https://clang.llvm.org/extra/clang-tidy/)
- [Dunst](https://dunst-project.org/)
- [Fastfetch](https://github.com/LinusDierheimer/fastfetch)
- [Git](https://git-scm.com/)
- [Htop](https://htop.dev/)
- [Hyprland](https://hyprland.org/)
- [Kitty](https://sw.kovidgoyal.net/kitty/)
- [Lf](https://github.com/gokcehan/lf)
- [Mpd](https://www.musicpd.org/)
- [Mpv](https://mpv.io/)
- [Ncmpcpp](https://github.com/ncmpcpp/ncmpcpp)
- [Neofetch](https://github.com/dylanaraps/neofetch)
- [Newsboat](https://newsboat.org/)
- [Npm](https://www.npmjs.com/)
- [Nvim](https://neovim.io/)
- [Picom](https://github.com/yshui/picom)
- [Pipewire](https://pipewire.org/)
- [Polybar](https://polybar.github.io/)
- [Python](https://www.python.org/)
<!-- - [Qalculate](https://qalculate.github.io/) -->
- [Ranger](https://github.com/ranger/ranger)
- [Redshift](http://jonls.dk/redshift/)
- [Rofi](https://github.com/davatorium/rofi)
- [Sway](https://swaywm.org/)
- [Sxhkd](https://github.com/baskerville/sxhkd)
- [Systemd](https://systemd.io/)
- [Tmux](https://github.com/tmux/tmux)
- [Vifm](https://vifm.info/)
- [Vim](https://www.vim.org/)
- [Waybar](https://github.com/Alexays/Waybar)
- [Wezterm](https://wezfurlong.org/wezterm/index.html)
- [Wgetrc](https://www.gnu.org/software/wget/)
- [Wl-clipboard-history](https://github.com/ShellTux/wl-clipboard-history)
- [Wofi](https://hg.sr.ht/~scoopta/wofi)
- Xbindkeys
- [Xmobar](https://codeberg.org/xmobar/xmobar)
- [Xmonad](https://xmonad.org/)
- [X.Org](https://www.x.org/wiki/)
- [Xournalpp](https://xournalpp.github.io/)
- [Yarn](https://yarnpkg.com/)
- [Yay](https://github.com/Jguer/yay)
- [Zathura](https://pwmt.org/projects/zathura/)
- [Zsh](https://www.zsh.org/)

Feel free to fork this repository and customize the configurations to your liking.
