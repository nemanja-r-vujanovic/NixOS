#!/usr/bin/env bash

mkdir -p "$HOME/.config/alacritty/"
echo -n "[font]
size = 30" > "$HOME/.config/alacritty/alacritty.toml"

echo "Reload configs: Super + Shift + C"
echo "Press Enter to exit."
read Enter
