#!/usr/bin/env bash

rm -r "../Configurations/"
mv "../Wallpapers/" "$HOME/"

./"vim.sh"
./"alacritty.sh"
./"i3.sh"
./"i3status.sh"
./"rofi.sh"
# ...
./"git-sync.sh"
