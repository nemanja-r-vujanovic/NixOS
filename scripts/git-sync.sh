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

sudo ln -s -T "$HOME/nixos-sync/nixos" "/etc/nixos"
ln -s -T "$HOME/nixos-sync/.vimrc" "$HOME/.vimrc"
ln -s -T "$HOME/nixos-sync/.bashrc" "$HOME/.bashrc"
ln -s -T "$HOME/nixos-sync/.bash_aliases" "$HOME/.bash_aliases"
ln -s -T "$HOME/nixos-sync/alacritty" "$HOME/.config/alacritty"
ln -s -T "$HOME/nixos-sync/i3" "$HOME/.config/i3"
ln -s -T "$HOME/nixos-sync/i3status" "$HOME/.config/i3status"
ln -s -T "$HOME/nixos-sync/rofi" "$HOME/.config/rofi"
ln -s -T "$HOME/nixos-sync/pcmanfm" "$HOME/.config/pcmanfm"
ln -s -T "$HOME/nixos-sync/libfm" "$HOME/.config/libfm"

ls -a -l "$HOME/.config/"

echo -n "Press Enter to exit."
read Enter
echo
