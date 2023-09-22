#!/bin/sh
set -xe

username="$1"

grub() {
	install --owner=root --group=root --mode=744 ./etc/grub.d/* /etc/grub.d/
	grub-mkconfig --output=/boot/grub/grub.cfg
}

pacman() {
	install --owner=root --group=root --mode=744 \
		./etc/pacman.d/hooks/log-installed.hook /etc/pacman.d/hooks/
	sed -i 's|<user>|'"$username"'|g' /etc/pacman.d/hooks/log-installed.hook
}

reflector() {
	install --owner=root --group=root --mode=644 ./etc/xdg/reflector/reflector.conf /etc/xdg/reflector/
}

doas() {
	install --owner=root --group=root --mode=644 ./etc/doas.conf /etc/
	echo "$1"
	sed -i 's|<user>|'"$username"'|g' /etc/doas.conf
}

vconsole() {
	install --owner=root --group=root --mode=644 ./etc/vconsole.conf /etc/
}

zsh() {
	install --owner=root --group=root --mode=644 ./etc/zsh/zshenv /etc/zsh/
}

xorg() {
	for file in ./etc/X11/xorg.conf.d/40-libinput.conf
	do
		install --owner=root --group=root --mode=644 "$file" /etc/X11/xorg.conf.d/
	done
}

network_manager() {
	cd ./etc/NetworkManager/dispatcher.d/
	destination=/etc/NetworkManager/dispatcher.d
	for file in \
		09-timezone \
		10-enable-sshd
	do
		install --owner=root --group=root --mode=700 "$file" "$destination"
	done
	printf '\033[36m%s\033[0m\n' \
		"You need to change $destination/10-enable-sshd.sh uuid"
}

grub
# pacman
reflector
doas
vconsole
zsh
xorg
network_manager
