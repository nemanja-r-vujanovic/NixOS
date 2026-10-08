#!/usr/bin/env bash

mkdir -p "$HOME/nixos-sync/"

mv "$HOME/.vimrc" "$HOME/nixos-sync/"
mv "$HOME/.config/alacritty/" "$HOME/nixos-sync/"
mv "$HOME/.config/i3/" "$HOME/nixos-sync/"
mv "$HOME/.config/i3status/" "$HOME/nixos-sync/"
mv "$HOME/.config/rofi/" "$HOME/nixos-sync/"

ln -s "$HOME/nixos-sync/.vimrc" "$HOME/.vimrc"
ln -s "$HOME/nixos-sync/alacritty/" "$HOME/.config/alacritty/"
ln -s "$HOME/nixos-sync/i3/" "$HOME/.config/i3/"
ln -s "$HOME/nixos-sync/i3status/" "$HOME/.config/i3status/"
ln -s "$HOME/nixos-sync/rofi/" "$HOME/.config/rofi/"

ls -la "$HOME/.config/"
read Enter
