#!/usr/bin/env bash

echo "Search: 'rofi theme selector'"
echo "Select: 'arc-dark by leofa'"
echo "Press: 'Alt + A'"
read Enter

rofi -show drun

mkdir -p "$HOME/.config/rofi/"

echo -n -e "\n
configuration
{
    font: "DejaVu Sans 20";
}" >> "$HOME/.config/rofi/config.rasi"
