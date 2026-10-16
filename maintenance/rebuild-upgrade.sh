#!/usr/bin/env bash
set -euo pipefail

# Similar to "sudo pacman -Syu" on Arch or "sudo apt update && sudo apt full-upgrade" on Debian
sudo nixos-rebuild switch --upgrade

bash "$HOME/nixos-sync/maintenance/confirm-reboot.sh"
