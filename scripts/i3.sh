#!/usr/bin/env bash
set -euo pipefail

sed -i "s|exec i3-sensible-terminal|exec alacritty|g" "$HOME/.config/i3/config"
sed -i 's|bindsym \$mod+d exec --no-startup-id dmenu_run|bindsym $mod+d exec --no-startup-id dmenu_run -fn "DejaVu Sans-20"|g' "$HOME/.config/i3/config"
sed -i "s|font pango:monospace 8|font pango:DejaVu Sans 20|g" "$HOME/.config/i3/config"
sed -i "s|#font pango:DejaVu Sans Mono 8|font pango:DejaVu Sans 20|g" "$HOME/.config/i3/config"

cat >> "$HOME/.config/i3/config" <<'EOF'

exec --no-startup-id "$HOME/nixos-sync/apps/sandbox/scripts/policykit.sh"
exec --no-startup-id "$HOME/nixos-sync/apps/sandbox/scripts/dunst.sh"

bindsym $mod+c exec "$HOME/nixos-sync/apps/sandbox/scripts/chromium-standard.sh"
bindsym $mod+i exec "$HOME/nixos-sync/apps/sandbox/scripts/chromium-incognito.sh"
bindsym $mod+b exec "$HOME/nixos-sync/apps/sandbox/scripts/chromium-sandboxed.sh"
bindsym $mod+p exec "$HOME/nixos-sync/apps/scripts/pcmanfm.sh"
bindsym $mod+Print exec --no-startup-id "$HOME/nixos-sync/apps/scripts/scrot.sh"
bindsym $mod+t exec --no-startup-id "$HOME/nixos-sync/apps/scripts/picom.sh"

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
