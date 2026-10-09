#!/usr/bin/env bash

mkdir -p "$HOME/.config/i3status/"

cat > "$HOME/.config/i3status/config" <<'EOF'
general
{
    interval = 1
}

order += "battery all"
order += "tztime local"

battery all
{
    format = "%percentage |"
}

tztime local
{
    format = "%d.%m.%Y. | %H:%M:%S"
}
EOF
