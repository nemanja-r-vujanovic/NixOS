#!/usr/bin/env bash
set -euo pipefail

sudo vim "/etc/nixos/configuration.nix"
sudo nixos-rebuild switch

bash "$HOME/nixos-sync/maintenance/reboot-prompt.sh"
