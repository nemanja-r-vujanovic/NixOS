#!/usr/bin/env bash
set -euo pipefail

echo -n "[font]
size = 30" > "$HOME/.config/alacritty/alacritty.toml"

echo "Reload configs: Super + Shift + C"

echo -n "Press Enter to exit."
read Enter
echo
