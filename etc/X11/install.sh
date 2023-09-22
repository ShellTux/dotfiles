#!/bin/sh
set -xe

cd ./etc/X11/xorg.conf.d/

destination=/etc/X11/xorg.conf.d/

for file in 40-libinput.conf
do
	install --owner=root --group=root --mode=644 "$file" "$destination"
done
