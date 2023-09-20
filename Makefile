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

all: symlink icons install

.PHONY: test
test:
	@echo $(DEPENDECIES) $(AUR_DEPENDECIES)

symlink:
	ln -sf $(CONFIG_HOME_DIR)/bash/bash_profile $(HOME_DIR)/.bash_profile
	ln -sf $(CONFIG_HOME_DIR)/bash/bashrc $(HOME_DIR)/.bashrc
	ln -sf $(CONFIG_HOME_DIR)/X11/Xresources $(HOME_DIR)/.Xresources
	cp --remove-destination $(CONFIG_HOME_DIR)/X11/xinitrc $(HOME_DIR)/.xinitrc

dependecies:
	$(PKG_MANAGER) $(DEPENDECIES)
	$(AUR_MANAGER) $(AUR_DEPENDECIES)

install: dependecies
	sudo install --owner=root --group=root --mode=744 ./etc/grub.d/* /etc/grub.d/
	sudo grub-mkconfig --output=/boot/grub/grub.cfg
	sudo install --owner=root --group=root --mode=744 ./etc/pacman.d/hooks/log-installed.hook /etc/pacman.d/hooks/
	sudo sed -i 's/<user>/$(USERNAME)/g' /etc/pacman.d/hooks/log-installed.hook
	sudo install --owner=root --group=root --mode=644 ./etc/xdg/reflector/reflector.conf /etc/xdg/reflector/
	sudo install --owner=root --group=root --mode=644 ./etc/doas.conf /etc/
	sudo sed -i 's/<user>/$(USERNAME)/g' /etc/doas.conf
	sudo install --owner=root --group=root --mode=644 ./etc/vconsole.conf /etc/
	sudo install --owner=root --group=root --mode=644 ./etc/zsh/zshenv /etc/zsh/
	sudo install --owner=root --group=root --mode=644 ./etc/X11/xorg.conf.d/*.conf /etc/X11/xorg.conf.d/
	sudo install --owner=root --group=root --mode=700 ./etc/NetworkManager/dispatcher.d/09-timezone /etc/NetworkManager/dispatcher.d/
	sudo install --owner=root --group=root --mode=700 ./etc/NetworkManager/dispatcher.d/10-enable-sshd /etc/NetworkManager/dispatcher.d/
	printf '\033[36m%s\033[0m\n' 'You need to change /etc/NetworkManager/dispatcher.d/10-enable-sshd.sh uuid'

.PHONY: sxhkd
sxhkd: dependencies
	sudo sed -i '0,/Path askpass/{s/.*Path askpass.*/Path askpass \/usr\/lib\/ssh\/ssh-askpass/}' /etc/sudo.conf
	systemctl enable --user sxhkd.service

$(MPD_SHARE) $(MPD_STATE) $(DBUS_SERVICE_DIR) $(ICONS_TARGET_DIR):
	mkdir --parents --verbose $@

mpd: | $(MPD_SHARE) $(MPD_STATE)
	touch "$(MPD_SHARE)/database"
	touch "$(MPD_SHARE)/mpd.log"
	touch "$(MPD_STATE)/mpd.pid"
	touch "$(MPD_STATE)/mpdstate"

.PHONY: xmonad
xmonad:
	sudo pacman -S --needed --noconfirm \
		xmonad \
		xmonad-utils \
		xmonad-extras \
		xmonad-contrib \
		xmobar \
		trayer

dbus: | $(DBUS_SERVICE_DIR)
	cp $(DBUS_SERVICES) $(DBUS_SERVICE_DIR)

.PHONY: icons
icons: | $(ICONS_TARGET_DIR)
	cp -r $(ICONS_SOURCE_DIR) $(ICONS_TARGET_DIR)

git-hooks: pre-push post-merge
	install --verbose --mode=755 $^ .git/hooks/

xdg-user-dirs:
	xdg-user-dirs-update --force
