#!/usr/bin/env bash

./"nixos-sync/Scripts/vim.sh"
./"nixos-sync/Scripts/alacritty.sh"
./"nixos-sync/Scripts/i3.sh"
./"nixos-sync/Scripts/i3status.sh"
./"nixos-sync/Scripts/rofi.sh"
./"nixos-sync/Scripts/pcmanfm.sh"
# ...
./"nixos-sync/Scripts/git-sync.sh"

rm "$HOME/first-boot.md"
systemctl reboot
