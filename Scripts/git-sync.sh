#!/usr/bin/env bash

sudo mv "/etc/nixos/" "$HOME/nixos-sync/"
mv "$HOME/.vimrc" "$HOME/nixos-sync/"
mv "$HOME/.config/alacritty/" "$HOME/nixos-sync/"
mv "$HOME/.config/i3/" "$HOME/nixos-sync/"
mv "$HOME/.config/i3status/" "$HOME/nixos-sync/"
mv "$HOME/.config/rofi/" "$HOME/nixos-sync/"
mv "$HOME/.config/pcmanfm/" "$HOME/nixos-sync/"

sudo ln -sT "$HOME/nixos-sync/nixos" "/etc/nixos/"
ln -sT "$HOME/nixos-sync/.vimrc" "$HOME/.vimrc"
ln -sT "$HOME/nixos-sync/alacritty" "$HOME/.config/alacritty"
ln -sT "$HOME/nixos-sync/i3" "$HOME/.config/i3"
ln -sT "$HOME/nixos-sync/i3status" "$HOME/.config/i3status"
ln -sT "$HOME/nixos-sync/rofi" "$HOME/.config/rofi"
ln -sT "$HOME/nixos-sync/pcmanfm" "$HOME/.config/pcmanfm/"

ls -la "$HOME/.config/"

echo -n "Press Enter to exit."
read Enter
echo
