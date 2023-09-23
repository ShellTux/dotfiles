#!/bin/sh
set -xe

cd ./etc/zsh/

destination=/etc/zsh/

for file in \
	zshenv
do
	install --owner=root --group=root --mode=644 "$file" "$destination"
done
