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
DEPENDECIES       = \
		    clipmenu \
		    eza \
		    firewalld \
		    flameshot \
		    jq \
		    libinput \
		    network-manager-applet \
		    noise-suppression-for-voice \
		    picom \
		    qpwgraph \
		    rofi \
		    rofi-calc \
		    rofi-emoji \
		    sxhkd \
		    syncthing \
		    x11-ssh-askpass \
		    xf86-input-libinput \
		    xorg-xrdb
AUR_DEPENDECIES   = \
		    redshift-wayland-git \
		    syncthing-gtk \
		    syncthingtray

.PHONY: list-dependecies
list-dependecies:
	@echo $(DEPENDECIES) $(AUR_DEPENDECIES)

symlink:
	ln -sf $(CONFIG_HOME_DIR)/bash/bash_profile $(HOME_DIR)/.bash_profile
	ln -sf $(CONFIG_HOME_DIR)/bash/bashrc $(HOME_DIR)/.bashrc
	ln -sf $(CONFIG_HOME_DIR)/X11/Xresources $(HOME_DIR)/.Xresources
	cp --remove-destination $(CONFIG_HOME_DIR)/X11/xinitrc $(HOME_DIR)/.xinitrc

dependecies: yay
	$(PKG_MANAGER) $(DEPENDECIES)
	$(AUR_MANAGER) $(AUR_DEPENDECIES)

etc/NetworkManager:
	$(PKG_MANAGER) \
		networkmanager \
		network-manager-applet \
		networkmanager-openvpn \
		nm-connection-editor
	sudo ./etc/NetworkManager/install.sh

etc/X11:
	$(PKG_MANAGER) \
		libinput \
		xf86-input-libinput
	sudo ./etc/X11/install.sh

etc/grub.d:
	$(PKG_MANAGER) grub
	sudo ./etc/grub.d/install.sh

etc/xdg/reflector:
	$(PKG_MANAGER) reflector
	sudo ./etc/xdg/reflector/install.sh

etc/zsh:
	$(PKG_MANAGER) zsh
	sudo ./etc/zsh/install.sh

etc/doas.conf:
	$(PKG_MANAGER) opendoas
	sudo install --owner=root --group=root --mode=644 ./etc/vconsole.conf /etc/
	sudo sed -i 's|<user>|$(USERNAME)|g' /etc/doas.conf

etc/vconsole.conf:
	$(PKG_MANAGER) terminus-font
	sudo install --owner=root --group=root --mode=644 ./etc/vconsole.conf /etc/

$(DBUS_SERVICE_DIR) \
	$(ICONS_TARGET_DIR) \
	$(MPD_SHARE) \
	$(MPD_STATE) \
	$(NEWSBOAT_HOME_DIR):
	mkdir --parents --verbose $@

git-hooks: pre-push post-merge
	install --verbose --mode=755 $^ .git/hooks/

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

.PHONY: bat
bat:
	$(PKG_MANAGER) \
		bat \
		bat-extras

dbus: | $(DBUS_SERVICE_DIR)
	cp $(DBUS_SERVICES) $(DBUS_SERVICE_DIR)

.PHONY: dunst
dunst:
	$(PKG_MANAGER) \
		dunst \
		notify-tools

.PHONY: git
git:
	$(PKG_MANAGER) \
		git \
		onefetch

.PHONY: hypr
hypr:
	$(PKG_MANAGER) \
		hyprland \
		xdg-desktop-portal-hyprland
	$(AUR_MANAGER) \
		waybar-hyprland-git

.PHONY: icons
icons: | $(ICONS_TARGET_DIR)
	cp -r $(ICONS_SOURCE_DIR) $(ICONS_TARGET_DIR)

.PHONY: mpd
mpd: | $(MPD_SHARE) $(MPD_STATE)
	$(PKG_MANAGER) mpd mpc timidity++
	systemctl --user enable --now mpd
	touch "$(MPD_SHARE)/database"
	touch "$(MPD_SHARE)/mpd.log"
	touch "$(MPD_STATE)/mpd.pid"
	touch "$(MPD_STATE)/mpdstate"

.PHONY: newsboat
newsboat: | $(NEWSBOAT_HOME_DIR)
	touch "$(NEWSBOAT_HOME_DIR)/repos-urls"
	touch "$(NEWSBOAT_HOME_DIR)/urls"

.PHONY: sxhkd
sxhkd:
	$(PKG_MANAGER) sxhkd x11-ssh-askpass
	sudo sed -i '0,/.*Path askpass.*/s||Path askpass /usr/lib/ssh/ssh-askpass|' /etc/sudo.conf
	systemctl --user enable sxhkd.service

.PHONY: xdg-user-dirs
xdg-user-dirs:
	$(PKG_MANAGER) xdg-user-dirs
	xdg-user-dirs-update --force

.PHONY: xmonad xmobar
xmonad xmobar:
	$(PKG_MANAGER) \
		xmonad \
		xmonad-utils \
		xmonad-extras \
		xmonad-contrib \
		xmobar \
		trayer

yay:
	./yay/yay-install.sh

zsh:
	$(PKG_MANAGER) \
		zsh \
		zsh-autosuggestions \
		zsh-syntax-highlighting \
		zsh-theme-powerlevel10k
