#!/bin/sh
set -xe

yay --version >/dev/null 2>/dev/null && exit 0

temp_dir="$(mktemp --directory)"

sudo pacman -S --noconfirm --needed git base-devel
git clone https://aur.archlinux.org/yay.git "$temp_dir"
cd "$temp_dir"
makepkg -si --noconfirm --needed
