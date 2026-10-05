#!/usr/bin/env bash

rm -r "Configurations/"
mv "Wallpapers/" "$HOME/"

chmod +x *".sh"

./"vim.sh"
./"alacritty.sh"
./"rofi.sh"
