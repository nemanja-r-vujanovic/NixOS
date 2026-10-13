#!/usr/bin/env bash
set -euo pipefail

bash "$HOME/nixos-sync/scripts/mkdirs.sh"
# ...
bash "$HOME/nixos-sync/scripts/vim.sh"
bash "$HOME/nixos-sync/scripts/bashrc.sh"
bash "$HOME/nixos-sync/scripts/alacritty.sh"
bash "$HOME/nixos-sync/scripts/i3.sh"
bash "$HOME/nixos-sync/scripts/i3status.sh"
bash "$HOME/nixos-sync/scripts/pcmanfm.sh"
bash "$HOME/nixos-sync/scripts/aliases.sh"
bash "$HOME/nixos-sync/scripts/chromium-ublock.sh"
# ...
bash "$HOME/nixos-sync/scripts/git-sync.sh"
bash "$HOME/nixos-sync/scripts/clean-up.sh"

systemctl reboot
