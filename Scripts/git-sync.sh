#!/usr/bin/env bash

mkdir "$HOME/nixos-sync/"

mv "$HOME/.config/alacritty/" "$HOME/nixos-sync/"
mv "$HOME/.config/i3/" "$HOME/nixos-sync/"

ln -s "$HOME/nixos-sync/alacritty/" "$HOME/.config/alacritty/"
ln -s "$HOME/nixos-sync/i3/" "$HOME/.config/i3/"

ls -la "$HOME/.config/"
read Enter
