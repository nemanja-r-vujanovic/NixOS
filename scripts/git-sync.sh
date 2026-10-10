#!/usr/bin/env bash

sudo mv "/etc/nixos/" "$HOME/nixos-sync/"
mv "$HOME/.vimrc" "$HOME/nixos-sync/"
mv "$HOME/.bashrc" "$HOME/nixos-sync/"
mv "$HOME/.bash_aliases" "$HOME/nixos-sync/"
mv "$HOME/.config/alacritty/" "$HOME/nixos-sync/"
mv "$HOME/.config/i3/" "$HOME/nixos-sync/"
mv "$HOME/.config/i3status/" "$HOME/nixos-sync/"
mv "$HOME/.config/rofi/" "$HOME/nixos-sync/"
mv "$HOME/.config/pcmanfm/" "$HOME/nixos-sync/"
mv "$HOME/.config/libfm/" "$HOME/nixos-sync/"

sudo ln -sT "$HOME/nixos-sync/nixos" "/etc/nixos"
ln -sT "$HOME/nixos-sync/.vimrc" "$HOME/.vimrc"
ln -sT "$HOME/nixos-sync/.bashrc" "$HOME/.bashrc"
ln -sT "$HOME/nixos-sync/.bash_aliases" "$HOME/.bash_aliases"
ln -sT "$HOME/nixos-sync/alacritty" "$HOME/.config/alacritty"
ln -sT "$HOME/nixos-sync/i3" "$HOME/.config/i3"
ln -sT "$HOME/nixos-sync/i3status" "$HOME/.config/i3status"
ln -sT "$HOME/nixos-sync/rofi" "$HOME/.config/rofi"
ln -sT "$HOME/nixos-sync/pcmanfm" "$HOME/.config/pcmanfm"
ln -sT "$HOME/nixos-sync/libfm" "$HOME/.config/libfm"

ls -la "$HOME/.config/"

echo -n "Press Enter to exit."
read Enter
echo
