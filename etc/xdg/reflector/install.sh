#!/bin/sh
set -xe

cd ./etc/xdg/reflector/

destination=/etc/xdg/reflector/

for file in \
	reflector.conf
do
	install --owner=root --group=root --mode=644 "$file" "$destination"
done
