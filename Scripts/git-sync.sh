#!/usr/bin/env bash

mkdir -p "$HOME/nixos-sync/"

mv "/etc/nixos/configuration.nix" "$HOME/nixos-sync/"
mv "$HOME/.vimrc" "$HOME/nixos-sync/"
mv "$HOME/.config/alacritty/" "$HOME/nixos-sync/"
mv "$HOME/.config/i3/" "$HOME/nixos-sync/"
mv "$HOME/.config/i3status/" "$HOME/nixos-sync/"
mv "$HOME/.config/rofi/" "$HOME/nixos-sync/"
mv "$HOME/Scripts/" "$HOME/nixos-sync/"
mv "$HOME/Wallpapers/" "$HOME/nixos-sync/"

ln -sT "$HOME/nixos-sync/configuration.nix" "/etc/nixos/configuration.nix"
ln -sT "$HOME/nixos-sync/.vimrc" "$HOME/.vimrc"
ln -sT "$HOME/nixos-sync/alacritty" "$HOME/.config/alacritty"
ln -sT "$HOME/nixos-sync/i3" "$HOME/.config/i3"
ln -sT "$HOME/nixos-sync/i3status" "$HOME/.config/i3status"
ln -sT "$HOME/nixos-sync/rofi" "$HOME/.config/rofi"
ln -sT "$HOME/nixos-sync/Scripts" "$HOME/Scripts"
ln -sT "$HOME/nixos-sync/Wallpapers" "$HOME/Wallpapers"

ls -la "$HOME/.config/"
read Enter
