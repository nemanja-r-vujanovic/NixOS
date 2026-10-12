#!/usr/bin/env bash
set -euo pipefail

mkdir -p "$HOME/.config/i3/"
sed -i "s|exec i3-sensible-terminal|exec alacritty|g" "$HOME/.config/i3/config"

cat >> "$HOME/.config/i3/config" <<'EOF'

exec --no-startup-id lxqt-policykit-agent

bindsym $mod+c exec chromium
bindsym $mod+p exec pcmanfm
bindsym $mod+m exec rofi -show drun

# Maximize:
bindsym Shift+f fullscreen enable

# Unmaximize:
bindsym Shift+s fullscreen disable; \
	resize set 75 ppt 75 ppt; \
	move position center

# Top half:
bindsym Shift+w fullscreen disable; \
	resize set 100 ppt 50 ppt; \
	move position 0 ppt 0 ppt

# Bottom half:
bindsym Shift+x fullscreen disable; \
	resize set 100 ppt 50 ppt; \
	move position 0 ppt 50 ppt

# Left half:
bindsym Shift+a fullscreen disable; \
	resize set 50 ppt 100 ppt; \
	move position 0 ppt 0 ppt

# Right half:
bindsym Shift+d fullscreen disable; \
	resize set 50 ppt 100 ppt; \
	move position 50 ppt 0 ppt

# Top-left
bindsym Shift+q fullscreen disable; \
	resize set 50 ppt 50 ppt; \
	move position 0 ppt 0 ppt

# Bottom-left
bindsym Shift+y fullscreen disable; \
	resize set 50 ppt 50 ppt; \
	move position 0 ppt 50 ppt

# Top-right
bindsym Shift+e fullscreen disable; \
	resize set 50 ppt 50 ppt; \
	move position 50 ppt 0 ppt

# Bottom-right
bindsym Shift+c fullscreen disable; \
	resize set 50 ppt 50 ppt; \
	move position 50 ppt 50 ppt

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
