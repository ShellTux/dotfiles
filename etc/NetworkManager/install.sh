#!/bin/sh
set -xe

cd ./etc/NetworkManager/dispatcher.d/
destination=/etc/NetworkManager/dispatcher.d

for file in \
	09-timezone \
	10-enable-sshd
do
	install --owner=root --group=root --mode=700 "$file" "$destination"
done

printf '\033[36m%s\033[0m\n' "You need to change $destination/10-enable-sshd.sh uuid"
