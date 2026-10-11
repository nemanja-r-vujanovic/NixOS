#!/usr/bin/env bash

mkdir -p "$HOME/.config/i3/"
sed -i "s|exec i3-sensible-terminal|exec alacritty|g" "$HOME/.config/i3/config"

cat >> "$HOME/.config/i3/config" <<'EOF'

exec --no-startup-id lxqt-policykit-agent

bindsym $mod+c exec chromium
bindsym $mod+p exec pcmanfm
bindsym $mod+m exec rofi -show drun

bar
{
    status_command i3status
    font pango:DejaVu Sans 20
    height 35
}
EOF

echo "Delete previous: bar {}"

echo -n "Press Enter to exit."
read Enter
echo

vim "$HOME/.config/i3/config"
