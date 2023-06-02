SHELL := /bin/sh
HOME_DIR = $(shell echo $$HOME)
# .xinitrc
# .Xresources
# .bash_profile
# .bashrc

.PHONY: symlink
symlink:
	ln -sf $(HOME_DIR)/.config/bash/bash_profile $(HOME_DIR)/.bash_profile
	ln -sf $(HOME_DIR)/.config/bash/bashrc $(HOME_DIR)/.bashrc
	ln -sf $(HOME_DIR)/.config/X11/xinitrc $(HOME_DIR)/.xinitrc
	ln -sf $(HOME_DIR)/.config/X11/Xresources $(HOME_DIR)/.Xresources
