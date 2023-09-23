#!/bin/sh
set -xe

cd ./etc/grub.d/

destination=/etc/grub.d/

for file in \
	30_uefi-firmware \
	40_custom
do
	install --owner=root --group=root --mode=744 "$file" "$destination"
done

grub-mkconfig --output=/boot/grub/grub.cfg
