#!/usr/bin/env bash

mkdir "$HOME/.config/alacritty/"
echo -n "[font]
size = 32" > "$HOME/.config/alacritty/alacritty.toml"

sed -i 's/exec i3-sensible-terminal/exec alacritty/g' "$HOME/.config/i3/config"

echo "Press Enter to exit."
echo "Then reload configs: Super + Shift + C"
read Enter
