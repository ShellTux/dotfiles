SHELL     := /bin/sh
HOME_DIR   = $(shell echo $$HOME)
USERNAME   = $(shell whoami)
MPD_SHARE  = $(shell echo "$$HOME"/.local/share/mpd)
MPD_STATE  = $(shell echo "$$HOME"/.local/state/mpd)

# .xinitrc
# .Xresources
# .bash_profile
# .bashrc

all: symlink install

.PHONY: symlink
symlink:
	ln -sf $(HOME_DIR)/.config/bash/bash_profile $(HOME_DIR)/.bash_profile
	ln -sf $(HOME_DIR)/.config/bash/bashrc $(HOME_DIR)/.bashrc
	ln -sf $(HOME_DIR)/.config/X11/xinitrc $(HOME_DIR)/.xinitrc
	ln -sf $(HOME_DIR)/.config/X11/Xresources $(HOME_DIR)/.Xresources

install:
	sudo cp ./etc/grub.d/* /etc/grub.d
	sudo grub-mkconfig -o /boot/grub/grub.cfg
	sudo cp ./etc/pacman.d/hooks/log-installed.hook /etc/pacman.d
	sudo cp ./etc/xdg/reflector/reflector.conf /etc/xdg/reflector
	sudo cp ./etc/zsh/zshenv /etc/zsh
	sudo cp ./etc/doas.conf /etc/doas.conf
	sudo sed -i 's/<user>/$(USERNAME)/g' /etc/doas.conf
	sudo cp ./etc/vconsole.conf /etc

$(MPD_SHARE) $(MPD_STATE):
	mkdir --parents --verbose $@

mpd: $(MPD_SHARE)/database $(MPD_SHARE)/mpd.log $(MPD_STATE)/mpd.pid $(MPD_STATE)/mpdstate | $(MPD_SHARE) $(MPD_STATE)
	touch "$(MPD_SHARE)/database"
	touch "$(MPD_SHARE)/mpd.log"
	touch "$(MPD_STATE)/mpd.pid"
	touch "$(MPD_STATE)/mpdstate"
