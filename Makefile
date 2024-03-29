SHELL            := /bin/sh
HOME_DIR          = $(shell echo $$HOME)
DATA_HOME_DIR     = $(or $(shell echo $$XDG_DATA_HOME),$(shell echo $$HOME)/.local/share)
CONFIG_HOME_DIR  ?= $(or $(shell echo $$XDG_CONFIG_HOME),$(shell echo $$HOME)/.config)
STATE_HOME_DIR    = $(or $(shell echo $$XDG_STATE_HOME),$(shell echo $$HOME)/.local/state)
USERNAME          = $(shell whoami)
MPD_SHARE         = $(DATA_HOME_DIR)/mpd
MPD_STATE         = $(STATE_HOME_DIR)/mpd
DBUS_SERVICE_DIR  = $(DATA_HOME_DIR)/dbus-1/services
DBUS_SERVICES     = $(CONFIG_HOME_DIR)/dunst/org.freedesktop.Notifications.service
ICONS_TARGET_DIR  = $(DATA_HOME_DIR)
ICONS_SOURCE_DIR  = $(CONFIG_HOME_DIR)/icons
NEWSBOAT_HOME_DIR = $(CONFIG_HOME_DIR)/newsboat
PKG_MANAGER       = sudo pacman -S --needed --noconfirm
AUR_MANAGER       = yay -S --aur --needed --noconfirm

all: etc/* [a-zA-Z]*

.PHONY: list-dependecies
list-dependecies:
	@echo $(DEPENDECIES) $(AUR_DEPENDECIES)

.PHONY: etc/NetworkManager
etc/NetworkManager:
	$(PKG_MANAGER) \
		networkmanager \
		network-manager-applet \
		networkmanager-openvpn \
		nm-connection-editor
	sudo ./etc/NetworkManager/install.sh

.PHONY: etc/X11 etc/X11/
etc/X11 etc/X11/:
	$(PKG_MANAGER) \
		libinput \
		xf86-input-libinput
	sudo ./etc/X11/install.sh

.PHONY: etc/grub.d etc/grub.d/
etc/grub.d etc/grub.d/:
	$(PKG_MANAGER) grub os-prober
	sudo ./etc/grub.d/install.sh

.PHONY: etc/xdg/reflector etc/xdg/reflector/
etc/xdg/reflector etc/xdg/reflector/:
	$(PKG_MANAGER) reflector
	sudo ./etc/xdg/reflector/install.sh

.PHONY: etc/zsh etc/zsh/
etc/zsh etc/zsh/:
	$(PKG_MANAGER) zsh
	sudo ./etc/zsh/install.sh

.PHONY: etc/doas.conf opendoas
etc/doas.conf opendoas:
	$(PKG_MANAGER) opendoas
	sudo install --owner=root --group=root --mode=400 ./etc/doas.conf /etc/
	sudo sed -i 's|<user>|$(USERNAME)|g' /etc/doas.conf

.PHONY: /etc/vconsole.conf
/etc/vconsole.conf:
	$(PKG_MANAGER) terminus-font setconf
	sudo setconf --add /etc/vconsole.conf FONT=ter-124b

$(DBUS_SERVICE_DIR) \
	$(ICONS_TARGET_DIR) \
	$(MPD_SHARE) \
	$(MPD_STATE) \
	$(NEWSBOAT_HOME_DIR):
	mkdir --parents --verbose $@

.git/hooks/*: git/hooks/*
	install --verbose --mode=755 $^ $@

.PHONY: git-hooks
git-hooks: .git/hooks/pre-push

.PHONY: alacritty
alacritty:
	$(PKG_MANAGER) \
		alacritty \
		otf-firamono-nerd \
		ttf-fira-code \
		ttf-firacode-nerd

.PHONY: awesome
awesome:
	$(PKG_MANAGER) \
		awesome \
		awesome-terminal-fonts \
		otf-font-awesome

.PHONY: bash
bash:
	$(PKG_MANAGER) \
		bash \
		bash-completion \
		jq \
		neofetch
	ln -sf $(CONFIG_HOME_DIR)/bash/bash_profile $(HOME_DIR)/.bash_profile
	ln -sf $(CONFIG_HOME_DIR)/bash/bashrc $(HOME_DIR)/.bashrc

.PHONY: bat
bat:
	$(PKG_MANAGER) \
		bat \
		bat-extras

.PHONY: cups
cups:
	$(PKG_MANAGER) \
		cups \
		cups-pdf \
		system-config-printer
	sudo systemctl enable --now cups.service

.PHONY: dash
dash: yay
	$(AUR_MANAGER) \
		dashbinsh

dbus: | $(DBUS_SERVICE_DIR)
	cp $(DBUS_SERVICES) $(DBUS_SERVICE_DIR)

.PHONY: dunst
dunst:
	$(PKG_MANAGER) \
		dunst \
		inotify-tools

.PHONY: firewall
firewall:
	$(PKG_MANAGER) \
		firewalld
	sudo systemctl enable --now firewalld.service

.PHONY: fonts
fonts:
	$(PKG_MANAGER) \
		noto-fonts-cjk

.PHONY: git
git:
	$(PKG_MANAGER) \
		git \
		neovim \
		onefetch

.PHONY: hypr
hypr: swayidle swaylock waybar
	$(PKG_MANAGER) \
		arc-gtk-theme \
		hyprland \
		xdg-desktop-portal-hyprland
	systemctl --user enable --now swayidle-hyprland.service

.PHONY: icons
icons: | $(ICONS_TARGET_DIR)
	cp -r $(ICONS_SOURCE_DIR) $(ICONS_TARGET_DIR)

.PHONY: ly
ly:
	$(PKG_MANAGER) \
		ly \
		setconf
	sudo setconf --uncomment /etc/ly/config.ini animate=true
	sudo setconf --uncomment /etc/ly/config.ini animation=1
	sudo setconf --uncomment /etc/ly/config.ini bigclock=true
	sudo setconf --uncomment /etc/ly/config.ini lang=pt
	sudo systemctl enable ly.service

.PHONY: mpd
mpd: | $(MPD_SHARE) $(MPD_STATE)
	$(PKG_MANAGER) mpd mpc timidity++
	systemctl --user enable --now mpd
	touch "$(MPD_SHARE)/database"
	touch "$(MPD_SHARE)/mpd.log"
	touch "$(MPD_STATE)/mpd.pid"
	touch "$(MPD_STATE)/mpdstate"

.PHONY: mpv
mpv:
	$(PKG_MANAGER) \
		ffmpeg \
		mediainfo \
		mpv \
		yt-dlp

.PHONY: nemo
nemo: yay
	$(PKG_MANAGER) \
		glacier-calc \
		nemo \
		nemo-audio-tab \
		nemo-emblems \
		nemo-fileroller \
		nemo-image-converter \
		nemo-preview \
		nemo-python \
		nemo-share \
		nemo-terminal
	$(AUR_MANAGER) \
		gtkhash-nemo


.PHONY: newsboat
newsboat: | $(NEWSBOAT_HOME_DIR)
	$(PKG_MANAGER) newsboat
	touch "$(NEWSBOAT_HOME_DIR)/repos-urls"
	touch "$(NEWSBOAT_HOME_DIR)/urls"

.PHONY: pipewire
pipewire:
	$(PKG_MANAGER) \
		easyeffects \
		noise-suppression-for-voice \
		qpwgraph
	systemctl --user enable pipewire pipewire-pulse
	systemctl --user restart pipewire pipewire-pulse

.PHONY: redshift
redshift: yay
	$(AUR_MANAGER) \
		redshift-wayland-git

reflector: etc/xdg/reflector
	$(PKG_MANAGER) reflector
	sudo systemctl enable reflector.timer
	sudo systemctl start reflector.service

.PHONY: rofi
rofi:
	$(PKG_MANAGER) \
		rofi \
		rofi-calc \
		rofi-emoji \
		rofi-pass

.PHONY: shell
shell: zsh bash opendoas bat newsboat
	$(PKG_MANAGER) eza neofetch

.PHONY: sxhkd
sxhkd:
	$(PKG_MANAGER) sxhkd x11-ssh-askpass
	sudo sed -i '0,/.*Path askpass.*/s||Path askpass /usr/lib/ssh/ssh-askpass|' /etc/sudo.conf
	systemctl --user enable sxhkd.service

.PHONY: syncthing
syncthing: yay
	$(PKG_MANAGER) \
		syncthing
	$(AUR_MANAGER) \
	syncthing-gtk \
	syncthingtray

.PHONY: systemd
systemd: sxhkd
	$(PKG_MANAGER) \
		polkit-gnome
	systemctl --user enable --now polkit-gnome.service
	systemctl --user enable --now ssh-agent.service
	systemctl --user enable --now sxhkd.service

.PHONY: swayidle
swayidle:
	$(PKG_MANAGER) \
		swayidle

.PHONY: swaylock
swaylock:
	$(AUR_MANAGER) \
		swaylock-effects-git

.PHONY: tmux
tmux:
	$(PKG_MANAGER) \
		git \
		tmux

.PHONY: ueberzug
ueberzug:
	$(AUR_MANAGER) \
		ueberzugpp

.PHONY: waybar
waybar: yay
	$(PKG_MANAGER) \
		waybar
	# $(AUR_MANAGER) \
	# 	wlogout

.PHONY: wezterm
wezterm:
	$(PKG_MANAGER) \
		wezterm \
		wezterm-terminfo \
		wezterm-shell-integration

.PHONY: X11
X11: cups firewall syncthing
	$(PKG_MANAGER) \
		clipmenu \
		flameshot \
		network-manager-applet \
		numlockx \
		picom \
		ttf-joypixels
	$(AUR_MANAGER) \
		redshift-wayland-git
	ln -sf $(CONFIG_HOME_DIR)/X11/Xresources $(HOME_DIR)/.Xresources
	cp --remove-destination $(CONFIG_HOME_DIR)/X11/xinitrc $(HOME_DIR)/.xinitrc


.PHONY: xdg-user-dirs
xdg-user-dirs:
	$(PKG_MANAGER) xdg-user-dirs
	xdg-user-dirs-update --force

.PHONY: xmonad xmobar
xmonad xmobar:
	$(PKG_MANAGER) \
		trayer \
		ttf-joypixels \
		xmobar \
		xmonad \
		xmonad-contrib \
		xmonad-extras \
		xmonad-utils

.PHONY: yay
yay:
	./yay/yay-install.sh

.PHONY: yazi
yazi: ueberzug
	$(PKG_MANAGER) \
		yazi

.PHONY: zathura
zathura:
	$(PKG_MANAGER) \
		zathura \
		zathura-cb \
		zathura-djvu \
		zathura-pdf-mupdf

.PHONY: zsh
zsh:
	$(PKG_MANAGER) \
		jq \
		neofetch \
		thefuck \
		zsh \
		zsh-autosuggestions \
		zsh-completions \
		zsh-syntax-highlighting \
		zsh-theme-powerlevel10k

_btrfs: yay
	$(PKG_MANAGER) \
		btrfs-heatmap \
		compsize \
		duperemove \
		grub-btrfs
	$(AUR_MANAGER) timeshift-autosnap
	sudo setconf /etc/timeshift-autosnap.conf maxSnapshots=10
