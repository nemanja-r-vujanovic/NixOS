#!/bin/bash

mkdir ~/.config/alacritty/
echo -n "[font]
size = 30" > ~/.config/alacritty/alacritty.toml

sed -i 's/exec i3-sensible-terminal/exec alacritty/g' ~/.config/i3/config

echo -n "Press Enter to exit."
echo -n "Then reload configs: Super + Shift + C"
read Enter
