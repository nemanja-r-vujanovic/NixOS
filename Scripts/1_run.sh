#!/usr/bin/env bash

rm -r "Configurations/"
mv "Wallpapers/" "$HOME/"

./"vim.sh"
./"alacritty.sh"
./"rofi.sh"
./"git-sync.sh"
./"i3.sh"
