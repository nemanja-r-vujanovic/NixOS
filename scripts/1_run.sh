#!/usr/bin/env bash

./"nixos-sync/scripts/vim.sh"
./"nixos-sync/scripts/alacritty.sh"
./"nixos-sync/scripts/i3.sh"
./"nixos-sync/scripts/i3status.sh"
./"nixos-sync/scripts/rofi.sh"
./"nixos-sync/scripts/pcmanfm.sh"
# ...
./"nixos-sync/scripts/git-sync.sh"

rm "$HOME/first-boot.md"
systemctl reboot