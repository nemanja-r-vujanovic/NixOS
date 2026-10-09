#!/usr/bin/env bash

echo 'PS1="${PS1#\\n}"' >> "$HOME/.bashrc"
source "$HOME/.bashrc"

mkdir -p "$HOME/.config/alacritty/"
echo -n "[font]
size = 30" > "$HOME/.config/alacritty/alacritty.toml"

echo "Reload configs: Super + Shift + C"

echo -n "Press Enter to exit."
read Enter
echo
