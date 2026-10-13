#!/usr/bin/env bash
set -euo pipefail

mkdir -p "$HOME/.config/i3/"
sed -i "s|exec i3-sensible-terminal|exec alacritty|g" "$HOME/.config/i3/config"
sed -i 's|bindsym \$mod+d exec --no-startup-id dmenu_run|bindsym $mod+d exec --no-startup-id dmenu_run -fn "DejaVu Sans-20"|g' "$HOME/.config/i3/config"
sed -i "s|font pango:monospace 8|font pango:DejaVu Sans 20|g" "$HOME/.config/i3/config"
sed -i "s|#font pango:DejaVu Sans Mono 8|font pango:DejaVu Sans 20|g" "$HOME/.config/i3/config"

cat >> "$HOME/.config/i3/config" <<'EOF'

exec --no-startup-id lxqt-policykit-agent

bindsym $mod+c exec chromium
bindsym $mod+p exec pcmanfm

bar
{
    status_command i3status
    font pango:DejaVu Sans 20
    height 35
}
EOF

echo "Delete previous bar {} ':188,190d'"

echo -n "Press Enter to exit."
read Enter
echo

vim "$HOME/.config/i3/config"
