#!/usr/bin/env bash

mkdir "$HOME/.config/i3status/"

echo -n "general
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
}" > "$HOME/.config/i3status/config"
