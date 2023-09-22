#!/bin/sh
set -xe

pacman -Qi yay >/dev/null 2>/dev/null && exit 0

temp_dir="$(mktemp --directory)"

sudo pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay.git "$temp_dir"
cd "$temp_dir"
makepkg -si
