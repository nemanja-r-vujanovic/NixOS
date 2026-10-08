#!/usr/bin/env bash

mkdir "$HOME/.config/alacritty/"
echo -n "[font]
size = 30" > "$HOME/.config/alacritty/alacritty.toml"

echo "Press Enter to exit."
echo "Then reload configs: Super + Shift + C"
read Enter
