#!/usr/bin/env bash
set -euo pipefail

echo -n "[font]
size = 30

[window]
opacity = 0.6" > "$HOME/.config/alacritty/alacritty.toml"

echo "Reload configs: Super + Shift + C"

echo -n "Press Enter to exit."
read Enter
echo
