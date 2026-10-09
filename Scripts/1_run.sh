#!/usr/bin/env bash

./"vim.sh"
./"alacritty.sh"
./"i3.sh"
./"i3status.sh"
./"rofi.sh"
./"pcmanfm.sh"
# ...
./"git-sync.sh"

rm "$HOME/first-boot.md"
systemctl reboot
