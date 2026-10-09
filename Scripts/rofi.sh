#!/usr/bin/env bash

echo "Search: rofi theme selector"
echo "Select: arc-dark by leofa"
echo "Press: Alt + A"

echo -n "Press Enter to exit."
read Enter
echo

rofi -show drun

mkdir -p "$HOME/.config/rofi/"

cat >> "$HOME/.config/rofi/config.rasi" <<'EOF'
configuration
{
    font: "DejaVu Sans 20";
}
EOF
