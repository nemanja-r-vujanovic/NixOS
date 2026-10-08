#!/usr/bin/env bash

echo "bindsym $mod+c exec chromium
bindsym $mod+p exec pcmanfm
bindsym $mod+m exec rofi -show drun

bar
{
    status_command i3status
    font pango: DejaVu Sans 20
    height 35
}"

read Enter

vim "$HOME/.config/i3/config"