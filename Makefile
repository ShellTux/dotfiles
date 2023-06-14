.PHONY: symlink mpd
SHELL         := /bin/sh
HOME_DIR       = $(shell echo $$HOME)
CONFIG_DIR    ?= $(or $(shell echo $$XDG_CONFIG_HOME),$(shell echo $$HOME)/.config)
USERNAME       = $(shell whoami)
MPD_SHARE      = $(shell echo "$$HOME"/.local/share/mpd)
MPD_STATE      = $(shell echo "$$HOME"/.local/state/mpd)
PKG_MANAGER = sudo pacman -S --needed --noconfirm
DEPENDECIES = libinput xf86-input-libinput

all: symlink install

symlink:
	ln -sf $(CONFIG_DIR)/bash/bash_profile $(HOME_DIR)/.bash_profile
	ln -sf $(CONFIG_DIR)/bash/bashrc $(HOME_DIR)/.bashrc
	ln -sf $(CONFIG_DIR)/X11/xinitrc $(HOME_DIR)/.xinitrc
	ln -sf $(CONFIG_DIR)/X11/Xresources $(HOME_DIR)/.Xresources

dependecies:
	$(PKG_MANAGER) $(DEPENDECIES)

install: dependecies
	sudo cp ./etc/grub.d/* /etc/grub.d
	sudo grub-mkconfig -o /boot/grub/grub.cfg
	sudo cp ./etc/pacman.d/hooks/log-installed.hook /etc/pacman.d
	sudo cp ./etc/xdg/reflector/reflector.conf /etc/xdg/reflector
	sudo cp ./etc/zsh/zshenv /etc/zsh
	sudo cp ./etc/doas.conf /etc/doas.conf
	sudo sed -i 's/<user>/$(USERNAME)/g' /etc/doas.conf
	sudo cp ./etc/vconsole.conf /etc
	sudo cp ./etc/X11/xorg.conf.d/*.conf /etc/X11/xorg.conf.d

$(MPD_SHARE) $(MPD_STATE):
	mkdir --parents --verbose $@

mpd: | $(MPD_SHARE) $(MPD_STATE)
	touch "$(MPD_SHARE)/database"
	touch "$(MPD_SHARE)/mpd.log"
	touch "$(MPD_STATE)/mpd.pid"
	touch "$(MPD_STATE)/mpdstate"
