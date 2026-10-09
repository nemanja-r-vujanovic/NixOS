#!/usr/bin/env bash

./"$HOME/nixos-sync/Scripts/vim.sh"
./"$HOME/nixos-sync/Scripts/alacritty.sh"
./"$HOME/nixos-sync/Scripts/i3.sh"
./"$HOME/nixos-sync/Scripts/i3status.sh"
./"$HOME/nixos-sync/Scripts/rofi.sh"
./"$HOME/nixos-sync/Scripts/pcmanfm.sh"
# ...
./"$HOME/nixos-sync/Scripts/git-sync.sh"

rm "$HOME/first-boot.md"
systemctl reboot
