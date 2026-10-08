#!/usr/bin/env bash

mkdir -p "$HOME/nixos-sync/"

mv "$HOME/.vimrc" "$HOME/nixos-sync"
mv "$HOME/.config/alacritty" "$HOME/nixos-sync"
mv "$HOME/.config/i3" "$HOME/nixos-sync"
mv "$HOME/.config/i3status" "$HOME/nixos-sync"
mv "$HOME/.config/rofi" "$HOME/nixos-sync"

ln -sT "$HOME/nixos-sync/.vimrc" "$HOME/.vimrc"
ln -sT "$HOME/nixos-sync/alacritty" "$HOME/.config/alacritty"
ln -sT "$HOME/nixos-sync/i3" "$HOME/.config/i3"
ln -sT "$HOME/nixos-sync/i3status" "$HOME/.config/i3status"
ln -sT "$HOME/nixos-sync/rofi" "$HOME/.config/rofi"

ls -la "$HOME/.config/"
read Enter
